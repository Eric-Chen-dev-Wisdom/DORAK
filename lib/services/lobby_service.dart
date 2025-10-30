// services/lobby_service.dart
import 'firebase_service.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import 'dart:math';

class LobbyService {
  final FirebaseService _firebaseService = FirebaseService();
  final Random _random = Random();

  // Create a new room
  Future<GameRoom> createRoom(String hostId, String hostName) async {
    final roomCode = _generateRoomCode();
    
    // Check if room already exists
    final exists = await _firebaseService.doesRoomExist(roomCode);
    if (exists) {
      // Try again with new code
      return createRoom(hostId, hostName);
    }
    
    final room = GameRoom.createNew(
      code: roomCode,
      hostId: hostId,
      hostName: hostName,
    );
    
    await _firebaseService.createRoom(room);
    return room;
  }

  // Join an existing room
  Future<bool> joinRoom(String roomCode, UserModel user, String team) async {
    try {
      // Check if room exists
      final exists = await _firebaseService.doesRoomExist(roomCode);
      if (!exists) {
        return false;
      }
      
      await _firebaseService.joinRoom(roomCode, user, team);
      return true;
    } catch (e) {
      print('Error joining room: $e');
      return false;
    }
  }

  // Get room stream for real-time updates - FIXED VERSION
  Stream<GameRoom?> getRoomStream(String roomCode) {
    return _firebaseService.getRoomStream(roomCode).asyncMap((snapshot) async {
      if (snapshot.exists) {
        try {
          final data = snapshot.data() as Map<String, dynamic>;
          return GameRoom.fromJson(data);
        } catch (e) {
          print('❌ Error parsing room data: $e');
          print('❌ Data received: ${snapshot.data()}');
          return null;
        }
      }
      return null;
    });
  }

  // Get room once (for initial load)
  Future<GameRoom?> getRoom(String roomCode) async {
    return await _firebaseService.getRoom(roomCode);
  }

  // Generate a 6-character room code
  String _generateRoomCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
      6, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  // Debug method to see all rooms
  Future<void> debugPrintAllRooms() async {
    final rooms = await _firebaseService.getAllRoomCodes();
    print('📋 All rooms in emulator: $rooms');
  }
}