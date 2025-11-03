import 'firebase_service.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../models/category_model.dart';
import 'dart:math';

class LobbyService {
  final FirebaseService _firebaseService = FirebaseService();
  final Random _random = Random();

  // Create a new room with auth recovery
  Future<GameRoom> createRoom(String hostId, String hostName) async {
    final int maxRetries = 3;
    int retryCount = 0;

    print('🟡 Starting room creation for host: $hostName ($hostId)');

    while (retryCount < maxRetries) {
      final roomCode = _generateRoomCode();
      print(
          '🟡 Generated room code: $roomCode (attempt ${retryCount + 1}/$maxRetries)');

      try {
        // Check if room already exists
        final exists = await _firebaseService.doesRoomExist(roomCode);
        print('🟡 Room exists check: $exists');

        if (exists) {
          retryCount++;
          print('🔄 Room code $roomCode exists, retrying...');
          continue;
        }

        final room = GameRoom.createNew(
          code: roomCode,
          hostId: hostId,
          hostName: hostName,
        );

        print('🟡 Created room object, calling FirebaseService.createRoom...');
        await _firebaseService.createRoom(room);
        print('✅ Room created successfully: ${room.code}');
        return room;
      } catch (e) {
        retryCount++;
        print('❌ Error creating room (attempt $retryCount/$maxRetries): $e');

        if (retryCount >= maxRetries) {
          throw Exception(
              'Failed to create room after $maxRetries attempts: $e');
        }

        // Wait before retry
        await Future.delayed(Duration(seconds: retryCount));
      }
    }

    throw Exception('Failed to create room after $maxRetries attempts');
  }

  // Join an existing room
  Future<bool> joinRoom(String roomCode, UserModel user, String team) async {
    try {
      print(
          '🟡 Joining room: $roomCode, user: ${user.displayName}, team: $team');

      // Check if room exists
      final exists = await _firebaseService.doesRoomExist(roomCode);
      print('🟡 Room exists: $exists');

      if (!exists) {
        return false;
      }

      await _firebaseService.joinRoom(roomCode, user, team);
      print('✅ Successfully joined room');
      return true;
    } catch (e) {
      print('❌ Error joining room: $e');
      return false;
    }
  }

  // Update room state to start the game (category selection phase)
  Future<void> startGame(GameRoom room) async {
    try {
      room.state = GameState.categorySelection;
      await _firebaseService.updateRoom(room);
      print('✓ Room ${room.code} moved to categorySelection');
    } catch (e) {
      print('✗ Error starting game: $e');
      rethrow;
    }
  }

  // Host updates selected categories live so joiners can see choices
  Future<void> updateSelectedCategories(
      String roomCode, List<Category> categories) async {
    try {
      final room = await _firebaseService.getRoom(roomCode);
      if (room == null) throw Exception('Room $roomCode not found');
      room.selectedCategories = categories;
      await _firebaseService.updateRoom(room);
      print('✓ Categories updated (${categories.length}) for $roomCode');
    } catch (e) {
      print('✗ Error updating categories: $e');
      rethrow;
    }
  }

  // Finalize categories and transition to inGame for everyone
  Future<void> finalizeCategoriesAndStart(
      String roomCode, List<Category> categories) async {
    try {
      final room = await _firebaseService.getRoom(roomCode);
      if (room == null) throw Exception('Room $roomCode not found');
      room.selectedCategories = categories;
      room.state = GameState.inGame;
      await _firebaseService.updateRoom(room);
      print('✓ Room $roomCode moved to inGame with ${categories.length} categories');
    } catch (e) {
      print('✗ Error finalizing categories: $e');
      rethrow;
    }
  }

  // Get room stream for real-time updates
  Stream<GameRoom?> getRoomStream(String roomCode) {
    print('🟡 Setting up room stream for: $roomCode');
    return _firebaseService.getRoomStream(roomCode).asyncMap((snapshot) async {
      print('🟡 Room stream update received, exists: ${snapshot.exists}');
      if (snapshot.exists) {
        try {
          final data = snapshot.data() as Map<String, dynamic>;
          final room = GameRoom.fromJson(data);
          print('🟡 Room parsed successfully: ${room.code}');
          return room;
        } catch (e) {
          print('❌ Error parsing room data: $e');
          print('❌ Data received: ${snapshot.data()}');
          return null;
        }
      }
      print('🟡 Room does not exist in stream');
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
}
