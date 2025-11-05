import 'dart:math';
import 'firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../models/category_model.dart';

class LobbyService {
  final FirebaseService _firebaseService = FirebaseService();
  final Random _random = Random();

  // =========================================================
  // ROOM CREATION
  // =========================================================
  Future<GameRoom> createRoom(String hostId, String hostName) async {
    const int maxRetries = 3;
    int retryCount = 0;

    print('🟢 Starting room creation for host: $hostName ($hostId)');

    while (retryCount < maxRetries) {
      final roomCode = _generateRoomCode();
      print('🟡 Generated room code: $roomCode (try ${retryCount + 1}/$maxRetries)');

      try {
        final exists = await _firebaseService.doesRoomExist(roomCode);
        if (exists) {
          retryCount++;
          print('🔄 Room code $roomCode already exists, retrying...');
          continue;
        }

        final room = GameRoom.createNew(
          code: roomCode,
          hostId: hostId,
          hostName: hostName,
        );

        await _firebaseService.createRoom(room);
        print('✅ Room successfully created: ${room.code}');
        return room;
      } catch (e) {
        retryCount++;
        print('❌ Error creating room (attempt $retryCount): $e');
        if (retryCount >= maxRetries) {
          throw Exception('Failed to create room after $maxRetries attempts: $e');
        }
        await Future.delayed(Duration(seconds: retryCount));
      }
    }

    throw Exception('Failed to create room after $maxRetries attempts');
  }

  // =========================================================
  // JOIN ROOM
  // =========================================================
  Future<bool> joinRoom(String roomCode, UserModel user, String team) async {
    try {
      print('🟢 Joining room: $roomCode by ${user.displayName} (team $team)');
      final exists = await _firebaseService.doesRoomExist(roomCode);
      if (!exists) return false;

      await _firebaseService.safeJoinRoom(roomCode, user, team);
      print('✅ Successfully joined room $roomCode');
      return true;
    } catch (e) {
      print('❌ Error joining room: $e');
      return false;
    }
  }

  // =========================================================
  // GAME START / CATEGORY PHASE
  // =========================================================
  Future<void> startGame(GameRoom room) async {
    try {
      room.state = GameState.categorySelection;
      await _firebaseService.updateRoom(room);
      print('🚀 Game started (category selection) for room ${room.code}');
    } catch (e) {
      print('❌ Error starting game: $e');
      rethrow;
    }
  }

  Future<void> updateSelectedCategories(
      String roomCode, List<Category> categories) async {
    try {
      final room = await _firebaseService.getRoom(roomCode);
      if (room == null) throw Exception('Room not found');
      room.selectedCategories = categories;
      await _firebaseService.updateRoom(room);
      print('✅ Updated categories (${categories.length}) for $roomCode');
    } catch (e) {
      print('❌ Error updating categories: $e');
      rethrow;
    }
  }

  Future<void> finalizeCategoriesAndStart(
      String roomCode, List<Category> categories) async {
    try {
      final room = await _firebaseService.getRoom(roomCode);
      if (room == null) throw Exception('Room not found');
      room.selectedCategories = categories;
      room.state = GameState.inGame;
      await _firebaseService.updateRoom(room);
      print('🏁 Room $roomCode moved to in-game');
    } catch (e) {
      print('❌ Error finalizing categories: $e');
      rethrow;
    }
  }

  // Prepare questions per host settings and start game for everyone
  Future<void> prepareQuestionsAndStart({
    required String roomCode,
    required List<Category> categories,
    required String difficulty, // 'all'|'easy'|'medium'|'hard'
    required int count,
  }) async {
    try {
      final room = await _firebaseService.getRoom(roomCode);
      if (room == null) throw Exception('Room not found');

      final List<Map<String, dynamic>> pool = [];
      for (final cat in categories) {
        final snap = await FirebaseFirestore.instance
            .collection('categories')
            .doc(cat.id)
            .collection('challenges')
            .get();
        for (final doc in snap.docs) {
          final data = doc.data();
          final diffStr = (data['difficulty'] as String?) ?? '';
          final matches = difficulty == 'all' ||
              diffStr.toLowerCase().contains(difficulty.toLowerCase());
          if (!matches) continue;
          final options = (data['options'] as List?)?.cast<String>() ?? const [];
          final correct = data['correctAnswer'];
          int correctIndex = -1;
          if (correct is int) {
            correctIndex = correct;
          } else if (correct is String && options.isNotEmpty) {
            correctIndex = options.indexOf(correct);
          }
          pool.add({
            'id': doc.id,
            'categoryId': cat.id,
            'category': cat.name,
            'question': data['question'] ?? '',
            'options': options,
            'correctAnswer': correctIndex,
            'difficulty': diffStr,
          });
        }
      }

      pool.shuffle();
      final selected = pool.take(count.clamp(1, pool.length)).toList();

      room.selectedCategories = categories;
      room.selectedDifficulty = difficulty;
      room.questionCount = selected.length;
      room.preparedQuestions = selected;
      room.state = GameState.inGame;
      await _firebaseService.updateRoom(room);
      print('dY"� Prepared ${selected.length} questions (diff=$difficulty) and started');
    } catch (e) {
      print('�?O Error preparing questions: $e');
      rethrow;
    }
  }

  // =========================================================
  // CHAT WRAPPERS
  // =========================================================
  Future<void> sendChat(
      String roomCode, String senderId, String senderName, String text) async {
    try {
      await _firebaseService.sendChatMessage(roomCode, {
        'senderId': senderId,
        'senderName': senderName,
        'text': text,
      });
      print('💬 Chat message sent from $senderName');
    } catch (e) {
      print('❌ Error sending chat message: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream(String roomCode) {
    return _firebaseService.getChatStream(roomCode);
  }

  // =========================================================
  // ROOM STREAM / SHARE SIGNAL
  // =========================================================
  Stream<GameRoom?> getRoomStream(String roomCode) {
    print('📡 Setting up lobby room stream for: $roomCode');
    return _firebaseService.getRoomStream(roomCode).asyncMap((snapshot) async {
      if (!snapshot.exists || snapshot.data() == null) return null;
      try {
        final room = GameRoom.fromJson(snapshot.data()!);
        return room;
      } catch (e) {
        print('❌ Error parsing room data: $e');
        return null;
      }
    });
  }

  Future<GameRoom?> getRoom(String roomCode) async {
    return await _firebaseService.getRoom(roomCode);
  }

  Future<void> signalShare(String roomCode, String by) async {
    await _firebaseService.signalShare(roomCode, by);
  }

  // =========================================================
  // UTILITY
  // =========================================================
  String _generateRoomCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(
        Iterable.generate(6, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }
}
