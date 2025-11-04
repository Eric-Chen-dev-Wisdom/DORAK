import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_init.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Enhanced error handling for auth issues
  Stream<DocumentSnapshot> getRoomStream(String roomCode) {
    print('dYY� Getting room stream for: $roomCode');
    return _firestore
        .collection('rooms')
        .doc(roomCode)
        .snapshots()
        .handleError((error) {
      print('�?O Room stream error: $error');

      // Check if it's an auth error and try to recover (emulator-only)
      if (error.toString().contains('UNAUTHENTICATED') ||
          error.toString().contains('INVALID_REFRESH_TOKEN')) {
        print('dY", Auth error detected');
        if (FirebaseInit.useEmulators) {
          print('dY", Clearing auth state (emulator only)');
          _clearAuthState();
        }
      }
      throw error;
    });
  }

  Future<void> createRoom(GameRoom room) async {
    try {
      print('dYY� Creating room in Firestore: ${room.code}');

      // Only clear auth state on emulator to avoid logging out real users
      await _clearAuthState();

      await _firestore.collection('rooms').doc(room.code).set(room.toJson());
      print('�o. Room created in EMULATOR: ${room.code}');

      // Verify the room was created
      final createdDoc =
          await _firestore.collection('rooms').doc(room.code).get();
      print('�o. Room verification: ${createdDoc.exists}');
    } catch (e) {
      print('�?O Error creating room: $e');

      // If it's an auth error, clear state and retry once (emulator-only)
      if (e.toString().contains('UNAUTHENTICATED') ||
          e.toString().contains('INVALID_REFRESH_TOKEN')) {
        print('dY", Auth error, clearing state and retrying...');
        await _clearAuthState();
        await _firestore.collection('rooms').doc(room.code).set(room.toJson());
        print('�o. Room created after retry: ${room.code}');
      } else {
        rethrow;
      }
    }
  }

  Future<void> updateRoom(GameRoom room) async {
    try {
      await _clearAuthState(); // emulator-only
      await _firestore.collection('rooms').doc(room.code).update(room.toJson());
      print('�o. Room updated in EMULATOR: ${room.code}');
    } catch (e) {
      print('�?O Error updating room: $e');
      rethrow;
    }
  }

  Future<void> joinRoom(String roomCode, UserModel user, String team) async {
    try {
      await _clearAuthState(); // emulator-only

      final roomRef = _firestore.collection('rooms').doc(roomCode);

      // Check if room exists
      final roomDoc = await roomRef.get();
      if (!roomDoc.exists) {
        throw Exception('Room $roomCode does not exist');
      }

      // Update the specific team array
      await roomRef.update({
        'team$team': FieldValue.arrayUnion([user.toJson()])
      });

      print('�o. User ${user.displayName} joined team $team in EMULATOR');
    } catch (e) {
      print('�?O Error joining room: $e');
      rethrow;
    }
  }

  // Atomic share signal from host to all clients
  Future<void> signalShare(String roomCode, String by) async {
    try {
      await _clearAuthState(); // emulator-only
      await _firestore.collection('rooms').doc(roomCode).update({
        'shareNonce': FieldValue.increment(1),
        'shareBy': by,
        'lastSharedAt': FieldValue.serverTimestamp(),
      });
      print('✓ Share signal sent for room $roomCode by $by');
    } catch (e) {
      print('✗ Error signaling share: $e');
      rethrow;
    }
  }

  Future<GameRoom?> getRoom(String roomCode) async {
    try {
      await _clearAuthState(); // emulator-only
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      if (doc.exists) {
        return GameRoom.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('�?O Error getting room: $e');
      return null;
    }
  }

  Future<bool> doesRoomExist(String roomCode) async {
    try {
      await _clearAuthState(); // emulator-only
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      return doc.exists;
    } catch (e) {
      print('�?O Error checking room: $e');
      return false;
    }
  }

  // Helper method to clear auth state
  Future<void> _clearAuthState() async {
    if (!FirebaseInit.useEmulators) return; // Never sign out on production
    try {
      await FirebaseAuth.instance.signOut();
      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      print('Auth clear error: $e');
    }
  }

  // Remove user from room
  Future<void> leaveRoom(String roomCode, String userId, String team) async {
    try {
      await _clearAuthState(); // emulator-only

      final roomRef = _firestore.collection('rooms').doc(roomCode);
      final roomDoc = await roomRef.get();

      if (roomDoc.exists) {
        final data = roomDoc.data()!;
        final teamList =
            List<Map<String, dynamic>>.from(data['team$team'] ?? []);
        final updatedTeam =
            teamList.where((user) => user['id'] != userId).toList();

        await roomRef.update({'team$team': updatedTeam});

        print('�o. User $userId left team $team');
      }
    } catch (e) {
      print('�?O Error leaving room: $e');
      rethrow;
    }
  }
  // Voting system
   Future<void> startVoting(String roomCode) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'votingInProgress': true,
        'teamAVotes': {},
        'teamBVotes': {},
      });
      print('🟢 Voting started for room $roomCode');
    } catch (e) {
      print('❌ Error starting voting: $e');
      rethrow;
    }
  }

  Future<void> submitVote(String roomCode, String team, String userId, int answerIndex) async {
    try {
      final voteField = team == 'A' ? 'teamAVotes' : 'teamBVotes';
      await _firestore.collection('rooms').doc(roomCode).update({
        '$voteField.$userId': answerIndex,
      });
      print('✅ $userId voted for option $answerIndex in team $team');
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
      print('🟥 Voting ended for room $roomCode');
    } catch (e) {
      print('❌ Error ending voting: $e');
      rethrow;
    }
  }

  Future<void> updateTeamPoints(String roomCode, int teamAPoints, int teamBPoints) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'teamAPoints': teamAPoints,
        'teamBPoints': teamBPoints,
      });
      print('🏆 Points updated for $roomCode — A: $teamAPoints, B: $teamBPoints');
    } catch (e) {
      print('❌ Error updating team points: $e');
    }
  }
}
