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
  Stream<DocumentSnapshot<Map<String, dynamic>>> getRoomStream(String roomCode) {
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
      await _firestore.collection('rooms').doc(room.code).update(room.toJson());
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

  Future<void> safeJoinRoom(String roomCode, UserModel user, String team) async {
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
      'teamA': teamA.map((u) => u['id'] == user.id ? user.toJson() : u).toList(),
      'teamB': teamB.map((u) => u['id'] == user.id ? user.toJson() : u).toList(),
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
  Future<void> sendChatMessage(String roomCode, Map<String, dynamic> message) async {
    await _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('chat')
        .add({
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

  // =========================================================
  // VOTING SYSTEM
  // =========================================================
  Future<void> startVoting(String roomCode) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'votingInProgress': true,
        'teamAVotes': {},
        'teamBVotes': {},
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
      });
      print('🟥 Voting ended for $roomCode');
    } catch (e) {
      print('❌ Error ending voting: $e');
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
        'teamAPoints': teamAPoints,
        'teamBPoints': teamBPoints,
      });
      print('🏆 Updated points — A: $teamAPoints, B: $teamBPoints');
    } catch (e) {
      print('❌ Error updating team points: $e');
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
