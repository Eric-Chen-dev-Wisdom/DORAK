// services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // REMOVE ALL Firebase Auth references
  // ONLY keep Firestore methods

  Stream<DocumentSnapshot> getRoomStream(String roomCode) {
    return _firestore.collection('rooms').doc(roomCode).snapshots();
  }

  Future<void> createRoom(GameRoom room) async {
    try {
      await _firestore.collection('rooms').doc(room.code).set(room.toJson());
      print('✅ Room created in EMULATOR: ${room.code}');
    } catch (e) {
      print('❌ Error creating room: $e');
      rethrow;
    }
  }

  Future<void> updateRoom(GameRoom room) async {
    try {
      await _firestore.collection('rooms').doc(room.code).update(room.toJson());
      print('✅ Room updated in EMULATOR: ${room.code}');
    } catch (e) {
      print('❌ Error updating room: $e');
      rethrow;
    }
  }

  Future<void> joinRoom(String roomCode, UserModel user, String team) async {
    try {
      final roomRef = _firestore.collection('rooms').doc(roomCode);
      
      final roomDoc = await roomRef.get();
      if (!roomDoc.exists) {
        throw Exception('Room $roomCode does not exist');
      }
      
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
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      if (doc.exists) {
        return GameRoom.fromJson(doc.data()! as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('❌ Error getting room: $e');
      return null;
    }
  }

  Future<bool> doesRoomExist(String roomCode) async {
    try {
      final doc = await _firestore.collection('rooms').doc(roomCode).get();
      return doc.exists;
    } catch (e) {
      print('❌ Error checking room: $e');
      return false;
    }
  }

  Future<List<String>> getAllRoomCodes() async {
    try {
      final query = await _firestore.collection('rooms').get();
      return query.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print('❌ Error getting all rooms: $e');
      return [];
    }
  }

  Future<void> updateRoomState(String roomCode, GameState newState) async {
    try {
      await _firestore.collection('rooms').doc(roomCode).update({
        'state': newState.toString(),
      });
    } catch (e) {
      print('❌ Error updating room state: $e');
      rethrow;
    }
  }
}