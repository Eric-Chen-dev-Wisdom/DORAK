import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import '../models/room_model.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Enhanced error handling for auth issues
  Stream<DocumentSnapshot> getRoomStream(String roomCode) {
    print('🟡 Getting room stream for: $roomCode');
    return _firestore.collection('rooms').doc(roomCode).snapshots().handleError((error) {
      print('❌ Room stream error: $error');
      
      // Check if it's an auth error and try to recover
      if (error.toString().contains('UNAUTHENTICATED') || 
          error.toString().contains('INVALID_REFRESH_TOKEN')) {
        print('🔄 Auth error detected, clearing auth state...');
        _clearAuthState();
      }
      throw error;
    });
  }

  Future<void> createRoom(GameRoom room) async {
    try {
      print('🟡 Creating room in Firestore: ${room.code}');
      
      // Clear auth state before operation
      await _clearAuthState();
      
      await _firestore.collection('rooms').doc(room.code).set(room.toJson());
      print('✅ Room created in EMULATOR: ${room.code}');
      
      // Verify the room was created
      final createdDoc = await _firestore.collection('rooms').doc(room.code).get();
      print('✅ Room verification: ${createdDoc.exists}');
      
    } catch (e) {
      print('❌ Error creating room: $e');
      
      // If it's an auth error, clear state and retry once
      if (e.toString().contains('UNAUTHENTICATED') || 
          e.toString().contains('INVALID_REFRESH_TOKEN')) {
        print('🔄 Auth error, clearing state and retrying...');
        await _clearAuthState();
        await _firestore.collection('rooms').doc(room.code).set(room.toJson());
        print('✅ Room created after retry: ${room.code}');
      } else {
        rethrow;
      }
    }
  }

  Future<void> updateRoom(GameRoom room) async {
    try {
      await _clearAuthState(); // Clear auth before operation
      await _firestore.collection('rooms').doc(room.code).update(room.toJson());
      print('✅ Room updated in EMULATOR: ${room.code}');
    } catch (e) {
      print('❌ Error updating room: $e');
      rethrow;
    }
  }

  Future<void> joinRoom(String roomCode, UserModel user, String team) async {
    try {
      await _clearAuthState(); // Clear auth before operation
      
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
      
      print('✅ User ${user.displayName} joined team $team in EMULATOR');
    } catch (e) {
      print('❌ Error joining room: $e');
      rethrow;
    }
  }

  Future<GameRoom?> getRoom(String roomCode) async {
    try {
      await _clearAuthState(); // Clear auth before operation
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      if (doc.exists) {
        return GameRoom.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('❌ Error getting room: $e');
      return null;
    }
  }

  Future<bool> doesRoomExist(String roomCode) async {
    try {
      await _clearAuthState(); // Clear auth before operation
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      return doc.exists;
    } catch (e) {
      print('❌ Error checking room: $e');
      return false;
    }
  }

  // Helper method to clear auth state
  Future<void> _clearAuthState() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Small delay to ensure auth state is cleared
      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      print('⚠️ Error clearing auth state: $e');
    }
  }

  // Remove user from room
  Future<void> leaveRoom(String roomCode, String userId, String team) async {
    try {
      await _clearAuthState(); // Clear auth before operation
      
      final roomRef = _firestore.collection('rooms').doc(roomCode);
      final roomDoc = await roomRef.get();
      
      if (roomDoc.exists) {
        final data = roomDoc.data()!;
        final teamList = List<Map<String, dynamic>>.from(data['team$team'] ?? []);
        final updatedTeam = teamList.where((user) => user['id'] != userId).toList();
        
        await roomRef.update({
          'team$team': updatedTeam
        });
        
        print('✅ User $userId left team $team');
      }
    } catch (e) {
      print('❌ Error leaving room: $e');
      rethrow;
    }
  }
}