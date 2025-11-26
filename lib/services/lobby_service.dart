import 'dart:math';
import 'firebase_service.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../models/category_model.dart';
import '../data/default_questions.dart';

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
      print(
          '🟡 Generated room code: $roomCode (try ${retryCount + 1}/$maxRetries)');

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
          throw Exception(
              'Failed to create room after $maxRetries attempts: $e');
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

  // Read ARB map for a given language code; returns empty map if not found.
  Future<Map<String, dynamic>> _loadArb(String lang) async {
    try {
      final path = 'lib/l10n/app_${lang}.arb';
      final txt = await rootBundle.loadString(path);
      final m = json.decode(txt);
      if (m is Map<String, dynamic>) return m;
      return <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
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
      GameRoom? room = await _firebaseService.getRoom(roomCode);
      if (room == null) throw Exception('Room not found');
      room.selectedCategories = categories;
      room.state = GameState.inGame;
      await _firebaseService.updateRoom(room);
      // Start the synchronized timer explicitly
      await _firebaseService.setTimer(room.code, 60, running: true);
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
    String? langCode,
  }) async {
    try {
      GameRoom? room = await _firebaseService.getRoom(roomCode);
      if (room == null) throw Exception('Room not found');

      final String lang = (langCode ?? 'en').toLowerCase();
      // Load ARB for fallback if Firestore is missing localization
      final Map<String, dynamic> _arb = await _loadArb(lang);
      // Also load English ARB for sanity fallback when current data is Arabic but locale is EN
      final Map<String, dynamic> _arbEn =
          lang == 'en' ? _arb : await _loadArb('en');
      final List<Map<String, dynamic>> pool = [];
      
      // Get list of already used question IDs for this room
      final usedIds = Set<String>.from(room.usedQuestionIds);
      print('🔍 Filtering questions - ${usedIds.length} already used in this room');
      
      for (final cat in categories) {
        final snap = await FirebaseFirestore.instance
            .collection('categories')
            .doc(cat.id)
            .collection('challenges')
            .get();
        for (final doc in snap.docs) {
          // Skip if question was already used in this room
          if (usedIds.contains(doc.id)) {
            print('⏭️ Skipping used question: ${doc.id}');
            continue;
          }
          
          final data = doc.data();
          final diffStr = (data['difficulty'] as String?) ?? '';
          final matches = difficulty == 'all' ||
              diffStr.toLowerCase().contains(difficulty.toLowerCase());
          if (!matches) continue;
          var options = (data['options_${lang}'] as List?)?.cast<String>() ??
              (data['options'] as List?)?.cast<String>() ??
              const [];
          final correct = data['correctAnswer'];
          int correctIndex = -1;
          if (correct is int) {
            correctIndex = correct;
          } else if (correct is String && options.isNotEmpty) {
            correctIndex = options.indexOf(correct);
          }
          // Question with ARB fallback
          String question = (data['question_${lang}'] as String?) ??
              (data['question'] as String?) ??
              '';
          final base = 'q_${doc.id}';
          final arbQ = _arb['${base}_text'] as String?;
          // Arabic locale: prefer ARB if localized field missing OR question likely not Arabic
          if (lang != 'en') {
            final containsArabic =
                RegExp(r'[\u0600-\u06FF]').hasMatch(question);
            if ((question.isEmpty || !containsArabic) &&
                arbQ != null &&
                arbQ.isNotEmpty) {
              question = arbQ;
            }
          }
          if (lang != 'en') {
            // Options ARB fallback if available
            final arbOptions = <String>[];
            for (var i = 1; i <= 10; i++) {
              final v = _arb['${base}_opt$i'];
              if (v is String && v.isNotEmpty) {
                arbOptions.add(v);
              } else {
                break;
              }
            }
            if (arbOptions.isNotEmpty) options = arbOptions;
          } else {
            // English locale: ensure options are English; if options look Arabic, use EN ARB
            final looksArabic =
                options.any((o) => RegExp(r'[\u0600-\u06FF]').hasMatch(o));
            if (looksArabic) {
              final arbOptionsEn = <String>[];
              for (var i = 1; i <= 10; i++) {
                final v = _arbEn['${base}_opt$i'];
                if (v is String && v.isNotEmpty) {
                  arbOptionsEn.add(v);
                } else {
                  break;
                }
              }
              if (arbOptionsEn.isNotEmpty) options = arbOptionsEn;
            }
          }

          // Localize category label via ARB fallback
          String categoryLabel = cat.name;
          final catKey = 'cat_${cat.id}Name';
          if (lang != 'en') {
            final looksArabicName =
                RegExp(r'[\u0600-\u06FF]').hasMatch(categoryLabel);
            final arbCat = _arb[catKey] as String?;
            if ((!looksArabicName || categoryLabel.isEmpty) &&
                arbCat != null && arbCat.isNotEmpty) {
              categoryLabel = arbCat;
            }
          } else {
            final looksArabicName =
                RegExp(r'[\u0600-\u06FF]').hasMatch(categoryLabel);
            final arbCatEn = _arbEn[catKey] as String?;
            if ((categoryLabel.isEmpty || looksArabicName) &&
                arbCatEn != null && arbCatEn.isNotEmpty) {
              categoryLabel = arbCatEn;
            }
          }

          pool.add({
            'id': doc.id,
            'categoryId': cat.id,
            'category': categoryLabel,
            'question': question,
            'options': options,
            'correctAnswer': correctIndex,
            'difficulty': diffStr,
          });
        }
      }

      // Fallback to bundled defaults if Firestore has no or too few localized questions
      if (pool.length < count) {
        final defs = defaultQuestionsByCategory();
        for (final cat in categories) {
          final list = defs[cat.id] ?? const <Challenge>[];
          for (final q in list) {
            // Skip if question was already used in this room
            if (usedIds.contains(q.id)) {
              continue;
            }
            
            // Filter by requested difficulty
            if (difficulty != 'all' &&
                q.difficulty.name.toLowerCase() != difficulty.toLowerCase()) {
              continue;
            }

            final base = 'q_${q.id}';
            // Question text from ARB for current lang, fallback to default
            final arbQ = _arb['${base}_text'] as String?;
            final question = (lang != 'en')
                ? (arbQ ?? q.question)
                : ((_arbEn['${base}_text'] as String?) ?? q.question);

            // Options from ARB for current lang, fallback to default options
            List<String> options = [];
            final sourceArb = (lang != 'en') ? _arb : _arbEn;
            for (var i = 1; i <= 10; i++) {
              final v = sourceArb['${base}_opt$i'];
              if (v is String && v.isNotEmpty) {
                options.add(v);
              } else {
                break;
              }
            }
            if (options.isEmpty) options = q.options ?? const [];

            int correctIndex = -1;
            if (q.correctAnswer is String && options.isNotEmpty) {
              final idx = options.indexOf(q.correctAnswer as String);
              if (idx >= 0) correctIndex = idx;
            }

          // Localize category name using ARB in defaults fallback path as well
          String categoryLabel = cat.name;
          final catKey = 'cat_${cat.id}Name';
          if (lang != 'en') {
            final looksArabicName = RegExp(r'[\u0600-\u06FF]').hasMatch(categoryLabel);
            final arbCat = _arb[catKey] as String?;
            if ((!looksArabicName || categoryLabel.isEmpty) && arbCat != null && arbCat.isNotEmpty) {
              categoryLabel = arbCat;
            }
          } else {
            final looksArabicName = RegExp(r'[\u0600-\u06FF]').hasMatch(categoryLabel);
            final arbCatEn = _arbEn[catKey] as String?;
            if ((categoryLabel.isEmpty || looksArabicName) && arbCatEn != null && arbCatEn.isNotEmpty) {
              categoryLabel = arbCatEn;
            }
          }

          // Store BOTH English and Arabic versions for multi-language support
          // Get English version from EN ARB
          final questionEn = (_arbEn['${base}_text'] as String?) ?? q.question;
          final optionsEn = <String>[];
          for (var i = 1; i <= 10; i++) {
            final v = _arbEn['${base}_opt$i'];
            if (v is String && v.isNotEmpty) {
              optionsEn.add(v);
            } else {
              break;
            }
          }
          if (optionsEn.isEmpty && q.options != null) {
            optionsEn.addAll(q.options!);
          }
          
          // Get Arabic version from AR ARB
          final questionAr = (_arb['${base}_text'] as String?) ?? q.question;
          final optionsAr = <String>[];
          for (var i = 1; i <= 10; i++) {
            final v = _arb['${base}_opt$i'];
            if (v is String && v.isNotEmpty) {
              optionsAr.add(v);
            } else {
              break;
            }
          }
          if (optionsAr.isEmpty && options.isNotEmpty) {
            optionsAr.addAll(options);
          }
          
          // Debug: Print what we're storing
          print('💾 Storing question ${q.id}:');
          print('  EN: $questionEn');
          print('  AR: $questionAr');

          pool.add({
            'id': q.id,
            'categoryId': cat.id,
            'category': categoryLabel,
            'question': question, // Current language
            'question_en': questionEn, // Always English
            'question_ar': questionAr, // Always Arabic  
            'options': options, // Current language
            'options_en': optionsEn, // Always English
            'options_ar': optionsAr, // Always Arabic
            'correctAnswer': correctIndex,
            'difficulty': q.difficulty.name,
          });
            if (pool.length >= count) break;
          }
          if (pool.length >= count) break;
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
      // Start the synchronized timer explicitly
      await _firebaseService.setTimer(room.code, 60, running: true);
      print(
          'dY" Prepared ${selected.length} questions (diff=$difficulty) and started');
    } catch (e) {
      print('?O Error preparing questions: $e');
      rethrow;
    }
  }

  Future<void> updateRoomSettings(String roomCode, List<String> categoryIds,
      String difficulty, int questionCount) async {
    try {
      final room = await _firebaseService.getRoom(roomCode);
      if (room == null) throw Exception('Room not found');

      // Fetch Category objects from Firestore using their IDs
      List<Category> selectedCategories = [];
      for (String id in categoryIds) {
        final categoryDoc = await FirebaseFirestore.instance
            .collection('categories')
            .doc(id)
            .get();
        if (categoryDoc.exists) {
          selectedCategories.add(Category.fromJson(
              {...categoryDoc.data()!, 'id': categoryDoc.id}));
        }
      }

      room.selectedCategories = selectedCategories;
      room.selectedDifficulty = difficulty;
      room.questionCount = questionCount;
      await _firebaseService.updateRoom(room);
      print('✅ Updated room settings for $roomCode');
    } catch (e) {
      print('❌ Error updating room settings: $e');
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

  Future<void> setChatEnabled(String roomCode, bool enabled) async {
    try {
      await _firebaseService.updateRoomField(roomCode, 'chatEnabled', enabled);
      print('💬 Chat for room $roomCode set to: $enabled');
    } catch (e) {
      print('❌ Error setting chat enabled status: $e');
      rethrow;
    }
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
    return String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }
}
