import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_init.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =========================================================
  // ROOM STREAMING
  // =========================================================
  Stream<DocumentSnapshot<Map<String, dynamic>>> getRoomStream(
      String roomCode) {
    print('📡 Subscribing to room stream for: $roomCode');
    return _firestore
        .collection('rooms')
        .doc(roomCode)
        .snapshots()
        .handleError((error) async {
      print('⚠️ Room stream error: $error');

      if (error.toString().contains('UNAUTHENTICATED') ||
          error.toString().contains('INVALID_REFRESH_TOKEN')) {
        print('🧹 Clearing auth state (emulator only)');
        await _clearAuthState();
      }
    });
  }

  // Advance to next question and toggle voting
  Future<void> nextQuestion(String roomCode, int totalQuestions) async {
    try {
      await _firestore.runTransaction((txn) async {
        final ref = _firestore.collection('rooms').doc(roomCode);
        final snap = await txn.get(ref);
        if (!snap.exists) return;
        final data = snap.data() ?? {};
        final current = (data['currentRound'] as num?)?.toInt() ?? 0;
        final next = current + 1;
        if (next >= totalQuestions) {
          txn.update(ref, {
            'state': 'GameState.gameComplete',
            'votingInProgress': false,
            'isTimerRunning': false,
          });
        } else {
          txn.update(ref, {
            'currentRound': next,
            'votingInProgress': true,
            'teamAVotes': {},
            'teamBVotes': {},
            'isTimerRunning': true,
            'currentTimer': 60,
            'timerUpdatedAt': FieldValue.serverTimestamp(),
          });
        }
      });
    } catch (e) {
      print('??O Error moving to next question: $e');
    }
  }

  // End the game manually and save match history
  Future<void> endGame(String roomCode) async {
    try {
      // Save match history before ending
      await _saveMatchHistoryForRoom(roomCode);

      await _firestore.collection('rooms').doc(roomCode).update({
        'state': 'GameState.gameComplete',
        'votingInProgress': false,
        'isTimerRunning': false,
      });
      print('🛑 Game ended manually for $roomCode');
    } catch (e) {
      print('❌ Error ending game: $e');
      rethrow;
    }
  }

  Future<void> _saveMatchHistoryForRoom(String roomCode) async {
    try {
      final roomDoc = await _firestore.collection('rooms').doc(roomCode).get();
      if (!roomDoc.exists) return;

      final data = roomDoc.data()!;
      final scores = data['scores'] as Map<String, dynamic>? ?? {};
      final teamAScore = (scores['teamA'] as num?)?.toInt() ?? 0;
      final teamBScore = (scores['teamB'] as num?)?.toInt() ?? 0;

      final teamA =
          (data['teamA'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final teamB =
          (data['teamB'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      final categories =
          (data['selectedCategories'] as List?)?.cast<Map<String, dynamic>>() ??
              [];
      final categoryNames =
          categories.map((c) => c['name'] as String? ?? '').toList();

      final totalQuestions = (data['preparedQuestions'] as List?)?.length ?? 0;
      final createdAtStr = data['createdAt'] as String?;
      final createdAt =
          createdAtStr != null ? DateTime.tryParse(createdAtStr) : null;
      final duration = createdAt != null
          ? DateTime.now().difference(createdAt).inSeconds
          : 0;

      final winner = teamAScore > teamBScore
          ? 'A'
          : (teamBScore > teamAScore ? 'B' : 'TIE');

      await saveMatchHistory({
        'roomCode': roomCode,
        'finalScores': {'teamA': teamAScore, 'teamB': teamBScore},
        'teamAPlayers': teamA.map((u) => u['displayName'] ?? 'Player').toList(),
        'teamBPlayers': teamB.map((u) => u['displayName'] ?? 'Player').toList(),
        'categoriesPlayed': categoryNames,
        'totalQuestions': totalQuestions,
        'duration': duration,
        'winner': winner,
        'hadJackpot': data['isJackpotQuestion'] ?? false,
      });
      print('✅ Match history saved for room $roomCode');
    } catch (e) {
      print('❌ Error saving match history in _saveMatchHistoryForRoom: $e');
      // Don't rethrow - game can still end even if history fails
    }
  }

  // =========================================================
  // ROOM CREATION / UPDATE / FETCH
  // =========================================================
  Future<void> createRoom(GameRoom room) async {
    try {
      print('🟢 Creating room: ${room.code}');
      await _clearAuthState();
      await _firestore.collection('rooms').doc(room.code).set(room.toJson());
      print('✅ Room created: ${room.code}');
    } catch (e) {
      print('❌ Error creating room: $e');
      rethrow;
    }
  }

  Future<void> updateRoom(GameRoom room) async {
    try {
      final Map<String, dynamic> roomJson = room.toJson();
      await _firestore.collection('rooms').doc(room.code).update(roomJson);
      print('✅ Room updated: ${room.code}');
    } catch (e) {
      print('❌ Error updating room: $e');
      rethrow;
    }
  }

  Future<GameRoom?> getRoom(String roomCode) async {
    try {
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      if (doc.exists && doc.data() != null) {
        return GameRoom.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('❌ Error fetching room: $e');
      return null;
    }
  }

  Future<bool> doesRoomExist(String roomCode) async {
    try {
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      return doc.exists;
    } catch (e) {
      print('❌ Error checking room existence: $e');
      return false;
    }
  }

  // =========================================================
  // PLAYER JOIN / LEAVE
  // =========================================================
  static const int ROOM_MAX_PLAYERS = 20;

  Future<void> safeJoinRoom(
      String roomCode, UserModel user, String team) async {
    final roomRef = _firestore.collection('rooms').doc(roomCode);
    final roomDoc = await roomRef.get();
    if (!roomDoc.exists) throw Exception('Room $roomCode does not exist');

    final data = roomDoc.data()!;
    final teamA = List.from(data['teamA'] ?? []);
    final teamB = List.from(data['teamB'] ?? []);
    final total = teamA.length + teamB.length;

    final alreadyInRoom = teamA.any((u) => u['id'] == user.id) ||
        teamB.any((u) => u['id'] == user.id);

    if (alreadyInRoom) {
      await roomRef.update({
        'teamA':
            teamA.map((u) => u['id'] == user.id ? user.toJson() : u).toList(),
        'teamB':
            teamB.map((u) => u['id'] == user.id ? user.toJson() : u).toList(),
        'lastEvent': '${user.displayName} rejoined the room',
      });
      print('🔁 ${user.displayName} rejoined $roomCode');
      return;
    }

    if (total >= ROOM_MAX_PLAYERS) {
      throw Exception('Room is full');
    }

    // Add user and broadcast event
    await roomRef.update({
      'team$team': FieldValue.arrayUnion([user.toJson()]),
      'lastEvent': '${user.displayName} joined Team $team',
    });

    print('✅ ${user.displayName} joined Team $team in $roomCode');
  }

  Future<void> leaveRoom(String roomCode, String userId, String team) async {
    try {
      await _clearAuthState();
      final roomRef = _firestore.collection('rooms').doc(roomCode);
      final doc = await roomRef.get();

      if (!doc.exists) return;

      final data = doc.data()!;
      final teamList = List<Map<String, dynamic>>.from(data['team$team'] ?? []);
      final leavingUser = teamList.firstWhere(
        (u) => u['id'] == userId,
        orElse: () => {'displayName': 'A player'},
      );

      final updated = teamList.where((user) => user['id'] != userId).toList();

      await roomRef.update({
        'team$team': updated,
        'lastEvent': '${leavingUser['displayName']} left Team $team',
      });

      print('👋 ${leavingUser['displayName']} left Team $team ($roomCode)');
    } catch (e) {
      print('❌ Error leaving room: $e');
      rethrow;
    }
  }

  // =========================================================
  // CHAT SYSTEM
  // =========================================================
  Future<void> sendChatMessage(
      String roomCode, Map<String, dynamic> message) async {
    await _firestore.collection('rooms').doc(roomCode).collection('chat').add({
      ...message,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream(String roomCode,
      {int limit = 50}) {
    return _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots();
  }

  Future<void> updateRoomField(
      String roomCode, String field, dynamic value) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        field: value,
        if (field == 'isTimerRunning' || field == 'currentTimer')
          'timerUpdatedAt': FieldValue.serverTimestamp(),
      });
      print('✅ Room $roomCode field $field updated to $value');
    } catch (e) {
      print('❌ Error updating room field: $e');
      rethrow;
    }
  }

  // =========================================================
  // VOTING SYSTEM
  // =========================================================
  Stream<Map<String, dynamic>> getVotesStream(String roomCode) {
    return _firestore
        .collection('rooms')
        .doc(roomCode)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data() ?? {};

      // Safely convert teamAVotes
      final teamAVotes = data['teamAVotes'];
      final Map<String, dynamic> safeTeamAVotes = {};
      if (teamAVotes is Map) {
        teamAVotes.forEach((key, value) {
          if (key is String) {
            safeTeamAVotes[key] = value;
          }
        });
      }

      // Safely convert teamBVotes
      final teamBVotes = data['teamBVotes'];
      final Map<String, dynamic> safeTeamBVotes = {};
      if (teamBVotes is Map) {
        teamBVotes.forEach((key, value) {
          if (key is String) {
            safeTeamBVotes[key] = value;
          }
        });
      }

      return {
        'teamAVotes': safeTeamAVotes,
        'teamBVotes': safeTeamBVotes,
      };
    });
  }

  Future<void> startVoting(String roomCode) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'votingInProgress': true,
        'teamAVotes': {},
        'teamBVotes': {},
        'votingStartedAt':
            FieldValue.serverTimestamp(), // Track voting start for speed bonus
        'voteTimestamps': {}, // Clear previous vote timestamps
      });
      print('🟢 Voting started for $roomCode');
    } catch (e) {
      print('❌ Error starting voting: $e');
      rethrow;
    }
  }

  Future<void> submitVote(
      String roomCode, String team, String userId, int answerIndex) async {
    try {
      final voteField = team == 'A' ? 'teamAVotes' : 'teamBVotes';
      await _firestore.collection('rooms').doc(roomCode).update({
        '$voteField.$userId': answerIndex,
        'voteTimestamps.$userId':
            FieldValue.serverTimestamp(), // Track vote time for speed bonus
      });
      print('✅ $userId voted for $answerIndex on team $team');
    } catch (e) {
      print('❌ Error submitting vote: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getVotes(String roomCode) async {
    try {
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      final data = doc.data() ?? {};
      return {
        'teamAVotes': data['teamAVotes'] ?? {},
        'teamBVotes': data['teamBVotes'] ?? {},
      };
    } catch (e) {
      print('❌ Error getting votes: $e');
      return {'teamAVotes': {}, 'teamBVotes': {}};
    }
  }

  Future<void> endVoting(String roomCode) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'votingInProgress': false,
        'isTimerRunning': false, // Ensure timer is stopped
        // Update timestamp
      });
      print('🟥 Voting ended for $roomCode');
    } catch (e) {
      print('❌ Error ending voting: $e');
      rethrow;
    }
  }

  // =========================================================
  // QUESTION ANTI-REPETITION SYSTEM
  // =========================================================
  Future<void> markQuestionAsUsed(String roomCode, String questionId) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'usedQuestionIds': FieldValue.arrayUnion([questionId]),
      });
      print('✅ Marked question $questionId as used in room $roomCode');
    } catch (e) {
      print('❌ Error marking question as used: $e');
      rethrow;
    }
  }

  // =========================================================
  // SCORING
  // =========================================================
  Future<void> updateTeamPoints(
      String roomCode, int teamAPoints, int teamBPoints) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'scores.teamA': teamAPoints,
        'scores.teamB': teamBPoints,
      });
      print('🏆 Updated points — A: $teamAPoints, B: $teamBPoints');
    } catch (e) {
      print('❌ Error updating team points: $e');
    }
  }

  Future<void> updateStreaks(
      String roomCode, int teamAStreak, int teamBStreak) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'teamAStreak': teamAStreak,
        'teamBStreak': teamBStreak,
      });
      print('🔥 Updated streaks — A: $teamAStreak, B: $teamBStreak');
    } catch (e) {
      print('❌ Error updating streaks: $e');
    }
  }

  Future<void> activatePowerCard(String roomCode, String cardId) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'usedPowerCards': FieldValue.arrayUnion([cardId]),
        'lastEvent': 'Power card used: $cardId',
        'powerCardNonce': FieldValue.increment(1),
      });
      print('🪄 Power card activated: $cardId for $roomCode');
    } catch (e) {
      print('❌ Error activating power card: $e');
      rethrow;
    }
  }

  // =========================================================
  // TIMER SYNC
  // =========================================================
  Future<void> setTimer(String roomCode, int seconds,
      {bool running = true}) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'currentTimer': seconds,
        'isTimerRunning': running,
        'timerUpdatedAt': FieldValue.serverTimestamp(),
        // Force snapshot change even if values repeat within same second
        'timerVersion': FieldValue.increment(1),
      });
    } catch (e) {
      // ignore: avoid_print
      print('Timer update error: $e');
    }
  }

  // =========================================================
  // MATCH HISTORY
  // =========================================================
  Future<String> saveMatchHistory(Map<String, dynamic> matchData) async {
    try {
      final doc = await _firestore.collection('matchHistory').add({
        ...matchData,
        'completedAt': FieldValue.serverTimestamp(),
      });
      print('📊 Match history saved: ${doc.id}');
      return doc.id;
    } catch (e) {
      print('❌ Error saving match history: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatchHistoryByRoomCode(
      String roomCode) {
    return _firestore
        .collection('matchHistory')
        .where('roomCode', isEqualTo: roomCode)
        .orderBy('completedAt', descending: true)
        .limit(50)
        .snapshots();
  }

  Future<List<Map<String, dynamic>>> getMatchHistoryList(
      String roomCode) async {
    try {
      // Try with orderBy first (requires index)
      try {
        final snap = await _firestore
            .collection('matchHistory')
            .where('roomCode', isEqualTo: roomCode)
            .orderBy('completedAt', descending: true)
            .limit(50)
            .get();
        print(
            '📜 Match history loaded with index: ${snap.docs.length} matches');
        return snap.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
      } catch (indexError) {
        // Fallback: query without orderBy if index not ready
        print('⚠️ Index not ready, using fallback query');
        final snap = await _firestore
            .collection('matchHistory')
            .where('roomCode', isEqualTo: roomCode)
            .limit(50)
            .get();

        // Sort in memory
        final docs =
            snap.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
        docs.sort((a, b) {
          final aTime = a['completedAt'];
          final bTime = b['completedAt'];
          if (aTime == null) return 1;
          if (bTime == null) return -1;
          return bTime.compareTo(aTime);
        });

        print('📜 Match history loaded (fallback): ${docs.length} matches');
        return docs;
      }
    } catch (e) {
      print('❌ Error getting match history: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getRecentMatches({int limit = 10}) async {
    try {
      final snapshot = await _firestore
          .collection('matchHistory')
          .orderBy('completedAt', descending: true)
          .limit(limit)
          .get();
      return snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
    } catch (e) {
      print('❌ Error getting recent matches: $e');
      return [];
    }
  }

  // =========================================================
  // SHARE SIGNAL
  // =========================================================
  Future<void> signalShare(String roomCode, String by) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'shareNonce': FieldValue.increment(1),
        'shareBy': by,
        'lastSharedAt': FieldValue.serverTimestamp(),
      });
      print('📢 Share signal sent for $roomCode by $by');
    } catch (e) {
      print('❌ Error signaling share: $e');
      rethrow;
    }
  }

  // =========================================================
  // AUTH HELPER
  // =========================================================
  Future<void> _clearAuthState() async {
    if (!FirebaseInit.useEmulators) return;
    try {
      await FirebaseAuth.instance.signOut();
      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      print('Auth clear error: $e');
    }
  }
}
