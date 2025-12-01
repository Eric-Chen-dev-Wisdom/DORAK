import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:DORAK/l10n/app_localizations.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../models/analytics_model.dart';
import '../widgets/host_control_panel.dart';
import '../utils/constants.dart';
import '../utils/arb_loader.dart';
import 'result_screen.dart';
import '../services/firebase_service.dart';
import '../services/analytics_service.dart';
// Using host-written timestamps only; no server offset
import '../widgets/chat_widget.dart';
import '../services/lobby_service.dart';

class GameScreen extends StatefulWidget {
  final GameRoom room;
  final UserModel user;
  final bool isHost;

  const GameScreen({
    super.key,
    required this.room,
    required this.user,
    required this.isHost,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentQuestionIndex = 0;
  int _selectedAnswerIndex = -1;
  int _remainingTime = 60;
  bool _isTimerRunning = false;
  Timer? _countdown;
  int? _timerEndAtMs;
  bool _isChatVisible = false;

  final FirebaseService _firebaseService = FirebaseService();
  final LobbyService _lobbyService = LobbyService();

  List<Map<String, dynamic>> _questions = [];
  bool _loadingQuestions = true;
  StreamSubscription? _roomSub;
  int _displayPointsA = 0;
  int _displayPointsB = 0;
  late GameRoom _currentRoom;
  bool _gameDataSaved = false; // Prevent duplicate saves
  bool _navigatedToResults = false; // Prevent multiple navigations
  Map<String, dynamic> _arbCache = {}; // Cache for ARB translations

  // Add real-time vote tracking
  Map<String, dynamic> _currentVotes = {'teamAVotes': {}, 'teamBVotes': {}};
  StreamSubscription? _votesSub;
  int? _lastRevealedQuestionIndex; // Track which question was revealed

// Guard against redundant timer updates
  int? _lastTimerStampMs;
  int? _lastServerTimer;
  bool? _lastRunning;

  final Set<String> _ackPowerCards = {};

  Future<void> _loadArbTranslations() async {
    try {
      print('🔄 Loading ARB translations...');
      final lang = Localizations.localeOf(context).languageCode;
      print('  Language: $lang');

      _arbCache = lang == 'ar'
          ? await ArbLoader.loadArabic()
          : await ArbLoader.loadEnglish();

      print('✅ Loaded ${_arbCache.length} ARB translations for: $lang');
      print('  Sample keys: ${_arbCache.keys.take(5).toList()}');

      // Force UI update
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('❌ Error loading ARB: $e');
      print('Stack: ${StackTrace.current}');
    }
  }

  Future<void> _loadQuestions() async {
    if (widget.room.preparedQuestions.isNotEmpty) {
      setState(() {
        _questions = widget.room.preparedQuestions;
        _loadingQuestions = false;
      });
      return;
    }
    final selectedCategories = widget.room.selectedCategories;
    final String lang = Localizations.localeOf(context).languageCode;
    final List<Map<String, dynamic>> loadedQuestions = [];

    // Get list of already used question IDs to prevent repetition
    final usedIds = Set<String>.from(_currentRoom.usedQuestionIds);

    for (final category in selectedCategories) {
      final snap = await FirebaseFirestore.instance
          .collection('categories')
          .doc(category.id)
          .collection('challenges')
          .get();

      // Group questions by difficulty
      final easyQuestions = <Map<String, dynamic>>[];
      final mediumQuestions = <Map<String, dynamic>>[];
      final hardQuestions = <Map<String, dynamic>>[];

      for (final doc in snap.docs) {
        // Skip if question was already used in this room
        if (usedIds.contains(doc.id)) {
          print('⏭️ Skipping used question: ${doc.id}');
          continue;
        }

        final data = doc.data();
        final options = (data['options_${lang}'] as List?)?.cast<String>() ??
            (data['options'] as List?)?.cast<String>() ??
            const [];
        final correct = data['correctAnswer'];
        int correctIndex = -1;
        if (correct is int) {
          correctIndex = correct;
        } else if (correct is String && options.isNotEmpty) {
          correctIndex = options.indexOf(correct);
        }

        final difficulty =
            (data['difficulty'] as String?)?.toLowerCase() ?? 'easy';

        final questionData = {
          'id': doc.id,
          'category': category.name,
          'categoryId': category.id,
          'question': (data['question_${lang}'] as String?) ??
              (data['question'] as String?) ??
              '',
          'options': options,
          'correctAnswer': correctIndex,
          'difficulty': difficulty,
        };

        // Sort into difficulty buckets
        switch (difficulty) {
          case 'easy':
            easyQuestions.add(questionData);
            break;
          case 'medium':
            mediumQuestions.add(questionData);
            break;
          case 'hard':
            hardQuestions.add(questionData);
            break;
          default:
            easyQuestions.add(questionData);
        }
      }

      // Shuffle within each difficulty level for variety
      easyQuestions.shuffle();
      mediumQuestions.shuffle();
      hardQuestions.shuffle();

      // Add questions in order: Easy → Medium → Hard (2E, 2M, 2H per category)
      loadedQuestions.addAll(easyQuestions.take(2));
      loadedQuestions.addAll(mediumQuestions.take(2));
      loadedQuestions.addAll(hardQuestions.take(2));

      print(
          '📚 Category "${category.name}": ${easyQuestions.take(2).length}E + ${mediumQuestions.take(2).length}M + ${hardQuestions.take(2).length}H');
    }

    setState(() {
      _questions = loadedQuestions;
      _loadingQuestions = false;
    });

    print(
        '✅ Loaded ${_questions.length} questions (${usedIds.length} excluded as already used)');
  }

  @override
  void initState() {
    super.initState();
    _currentRoom = widget.room;
    _remainingTime = _currentRoom.currentTimer;
    _isTimerRunning = _currentRoom.isTimerRunning;
    _displayPointsA = _currentRoom.teamAPoints;
    _displayPointsB = _currentRoom.teamBPoints;
    _ackPowerCards.addAll(_currentRoom.usedPowerCards);

    // Reset save flags for new game
    _saveInProgress = false;
    _gameDataSaved = false;
    _navigatedToResults = false;

    // IMPORTANT: Load ARB translations FIRST, then questions
    _loadArbTranslations().then((_) {
      print('🎯 ARB loaded, now loading questions...');
      _loadQuestions();
    });
    // Don't call _loadQuestions() here - wait for ARB first!

    // Start listening to votes in real-time
    _startVotesListener();

    _roomSub = _firebaseService.getRoomStream(_currentRoom.code).listen((snap) {
      if (snap.metadata.hasPendingWrites) return;
      final data = snap.data();
      if (data == null) return;

      try {
        final rawTs = data['timerUpdatedAt'];
        final ver = data['timerVersion'];
        final ctDbg = data['currentTimer'];
        final runDbg = data['isTimerRunning'];
        print(
            '[Timer][GS] pending=${snap.metadata.hasPendingWrites} cache=${snap.metadata.isFromCache} ver=$ver run=$runDbg ct=$ctDbg ts=$rawTs');
      } catch (_) {}

      final room = GameRoom.fromJson(data);
      final idx = (data['currentRound'] as num?)?.toInt() ?? 0;
      final state = data['state'] as String?;

      if (mounted) {
        setState(() {
          _currentRoom = room;
          _currentQuestionIndex =
              idx.clamp(0, _questions.isEmpty ? 0 : _questions.length - 1);

          // Always sync display points from Firebase (authoritative source)
          final scores = data['scores'] as Map<String, dynamic>?;
          if (scores != null) {
            final newA = (scores['teamA'] as num?)?.toInt() ?? _displayPointsA;
            final newB = (scores['teamB'] as num?)?.toInt() ?? _displayPointsB;

            // Only update if scores actually changed (prevent flicker)
            if (newA != _displayPointsA || newB != _displayPointsB) {
              _displayPointsA = newA;
              _displayPointsB = newB;
              print('📊 Scores synced from Firebase: A=$newA, B=$newB');
            }
          }

          if (data['timerUpdatedAt'] == null) {
            return;
          }
          final tsField = data['timerUpdatedAt'];
          final ts = tsField is Timestamp
              ? tsField.toDate()
              : (tsField is String
                  ? (DateTime.tryParse(tsField) ?? DateTime.now())
                  : DateTime.now());
          final ct = _currentRoom.currentTimer;
          final running = _currentRoom.isTimerRunning;

          if (running && (ct == 0)) return;
          {
            int updatedAtMs = ts.millisecondsSinceEpoch;

            final changed = _lastTimerStampMs != updatedAtMs ||
                _lastServerTimer != ct ||
                _lastRunning != running;
            if (changed) {
              _lastTimerStampMs = updatedAtMs;
              _lastServerTimer = ct;
              _lastRunning = running;

              _timerEndAtMs = running ? updatedAtMs + (ct * 1000) : null;
              _isTimerRunning = running;

              if (running && _timerEndAtMs != null) {
                final nowMs = DateTime.now().millisecondsSinceEpoch;
                final rem = ((_timerEndAtMs! - nowMs) / 1000).ceil();
                // Ensure remaining time is reasonable - if calculation is way off, use server value
                if (rem > ct + 5 || rem < 0) {
                  _remainingTime = ct;
                } else {
                  _remainingTime = rem.clamp(0, ct + 5);
                }
                _startLocalCountdown();
              } else {
                _countdown?.cancel();
                _remainingTime = ct;
              }
            }
          }
        });
      }
      if (mounted) {
        for (final cardId in room.usedPowerCards) {
          if (_ackPowerCards.contains(cardId)) continue;
          _ackPowerCards.add(cardId);
          _showPowerCardSnack(cardId);
        }

        // Check if answer was revealed (for non-host players)
        final revealedIndex = (data['lastRevealedQuestion'] as num?)?.toInt();
        print(
            '🔔 Checking reveal: revealedIndex=$revealedIndex, last=$_lastRevealedQuestionIndex, isHost=${widget.isHost}');

        if (revealedIndex != null &&
            revealedIndex != _lastRevealedQuestionIndex &&
            !widget.isHost) {
          // Answer was just revealed, show this player's result
          print('✅ Answer revealed detected! Showing player result...');
          _lastRevealedQuestionIndex = revealedIndex;
          _showPlayerResultFromSync();
        }
      }
      if (state == 'GameState.gameComplete' &&
          mounted &&
          !_navigatedToResults) {
        // Mark as navigated immediately to prevent multiple calls
        _navigatedToResults = true;

        // Save analytics and match history before navigating (once only)
        if (!_gameDataSaved) {
          _gameDataSaved = true;
          print('🎯 Auto-save triggered (state changed to gameComplete)');
          _saveGameDataOnComplete(); // Fire and forget, don't await in listener
        }

        // Wait a moment for save to start, then navigate
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResultScreen(room: _currentRoom, user: widget.user),
              ),
            );
          }
        });
      }
    });

    final bool isHost = widget.user.id == _currentRoom.hostId;
    if (!_currentRoom.votingInProgress && isHost) {
      _currentRoom.startVoting();
    }
  }

  // Add real-time votes listener
  void _startVotesListener() {
    // Listen to votes for host control panel (even though game screen doesn't display them)
    _votesSub =
        _firebaseService.getVotesStream(widget.room.code).listen((votes) {
      if (mounted) {
        setState(() {
          _currentVotes = votes;

          // Debug: Log vote updates
          final teamAVotes = votes['teamAVotes'] as Map<String, dynamic>?;
          final teamBVotes = votes['teamBVotes'] as Map<String, dynamic>?;
          print(
              '🗳️ Votes updated: Team A = ${teamAVotes?.length ?? 0}, Team B = ${teamBVotes?.length ?? 0}');
        });
      }
    });
  }

  @override
  void dispose() {
    _roomSub?.cancel();
    _countdown?.cancel();
    _votesSub?.cancel(); // Dispose votes subscription
    super.dispose();
  }

  void _handleAnswerSelect(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  void _handleVoteSubmit() async {
    if (_selectedAnswerIndex == -1) return;

    // Determine user's team - check both teams properly
    final userTeam = _currentRoom.teamA.any((u) => u.id == widget.user.id)
        ? 'A'
        : (_currentRoom.teamB.any((u) => u.id == widget.user.id) ? 'B' : 'A');

    print(
        '🗳️ Submitting vote: User=${widget.user.displayName}, Team=$userTeam, Answer=$_selectedAnswerIndex');

    await _firebaseService.submitVote(
        _currentRoom.code, userTeam, widget.user.id, _selectedAnswerIndex);

    print('✅ Vote submitted successfully');
    _showVoteSubmitted();
  }

  void _showVoteSubmitted() {
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.voteSubmittedOption(_selectedAnswerIndex + 1)),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _handlePointsAdjust(int points) {
    setState(() {});
  }

  void _handleTimerAdjust(int seconds, bool running) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      _remainingTime = seconds;
      _isTimerRunning = running;
      _timerEndAtMs = running ? nowMs + (seconds * 1000) : null;
      _currentRoom = _currentRoom.copyWith(
        currentTimer: seconds,
        isTimerRunning: running,
        timerUpdatedAt: DateTime.now(),
      );
    });
    if (running) {
      _startLocalCountdown();
    } else {
      _countdown?.cancel();
    }
    await _firebaseService.setTimer(widget.room.code, seconds,
        running: running);
  }

  Future<void> _handleNextQuestion() async {
    final totalQuestions = _questions.length;
    await _firebaseService.nextQuestion(widget.room.code, totalQuestions);
    if (mounted) {
      setState(() {
        _selectedAnswerIndex = -1;
      });
    }
  }

  Future<void> _handleSkipQuestion() async {
    await _firebaseService.endVoting(widget.room.code);
    await _handleNextQuestion();
  }

  void _handlePowerCardUsed(String cardId) {
    _ackPowerCards.add(cardId);
    _showPowerCardSnack(cardId);
  }

  void _handlePhysicalChallengeApprove(String team, int points) async {
    // Award points to the winning team
    int newPointsA = _currentRoom.teamAPoints;
    int newPointsB = _currentRoom.teamBPoints;

    if (team == 'A') {
      newPointsA += points;
    } else if (team == 'B') {
      newPointsB += points;
    }

    // Update Firebase
    await _firebaseService.updateTeamPoints(
        widget.room.code, newPointsA, newPointsB);

    // Update local state
    setState(() {
      _displayPointsA = newPointsA;
      _displayPointsB = newPointsB;
      _currentRoom = _currentRoom.copyWith(
        scores: {'teamA': newPointsA, 'teamB': newPointsB},
      );
    });

    print('💪 Physical challenge approved: Team $team earned $points pts');
  }

  void _showPowerCardSnack(String cardId) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final title = _powerCardTitle(cardId, l10n);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.powerCardActivated(title)),
        backgroundColor: Colors.purple,
      ),
    );
  }

  String _powerCardTitle(String cardId, AppLocalizations l10n) {
    switch (cardId) {
      case 'double_points':
        return l10n.doublePoints;
      case 'steal_points':
        return l10n.stealPoints;
      case 'reverse_turn':
        return l10n.reverseTurn;
      case 'skip_round':
        return l10n.skipRound;
      default:
        return cardId;
    }
  }

  // Static flag to track if save is in progress (prevents race conditions)
  static bool _saveInProgress = false;

  // Extract game data saving to reusable method
  Future<void> _saveGameDataOnComplete() async {
    // Extra safety: check both flags to prevent any race conditions
    if (_saveInProgress) {
      print('⚠️ Save already in progress, skipping duplicate call');
      return;
    }
    _saveInProgress = true;

    // Calculate game duration
    final duration =
        DateTime.now().difference(_currentRoom.createdAt).inSeconds;

    // Determine winner
    String winner = 'tie';
    if (_currentRoom.teamAPoints > _currentRoom.teamBPoints) {
      winner = 'A';
    } else if (_currentRoom.teamBPoints > _currentRoom.teamAPoints) {
      winner = 'B';
    }

    // Calculate category usage
    final categoryUsage = <String, int>{};
    for (final q in _questions) {
      final catId = q['categoryId'] as String? ?? 'unknown';
      categoryUsage[catId] = (categoryUsage[catId] ?? 0) + 1;
    }

    // Calculate difficulty breakdown
    final difficultyBreakdown = <String, int>{
      'easy': 0,
      'medium': 0,
      'hard': 0
    };
    for (final q in _questions) {
      final diff = (q['difficulty'] as String? ?? 'easy').toLowerCase();
      if (difficultyBreakdown.containsKey(diff)) {
        difficultyBreakdown[diff] = difficultyBreakdown[diff]! + 1;
      }
    }

    // Save match history
    print('💾 Attempting to save match history...');
    print('Room code: ${widget.room.code}');
    print('Team A score: ${_currentRoom.teamAPoints}');
    print('Team B score: ${_currentRoom.teamBPoints}');

    try {
      await _firebaseService.saveMatchHistory({
        'roomCode': widget.room.code,
        'teamAScore': _currentRoom.teamAPoints,
        'teamBScore': _currentRoom.teamBPoints,
        'winner': winner,
        'teamAPlayerNames':
            _currentRoom.teamA.map((u) => u.displayName).toList(),
        'teamBPlayerNames':
            _currentRoom.teamB.map((u) => u.displayName).toList(),
        'categories':
            _currentRoom.selectedCategories.map((c) => c.name).toList(),
        'totalQuestions': _questions.length,
        'duration': duration,
        'bonusStats': {
          'teamAStreak': _currentRoom.teamAStreak,
          'teamBStreak': _currentRoom.teamBStreak,
          'powerCardsUsed': _currentRoom.usedPowerCards.length,
        },
      });
      print('✅ Match history saved successfully to Firestore');
    } catch (e) {
      print('❌ Failed to save match history: $e');
      print('Stack trace: ${StackTrace.current}');
    }

    // Save analytics data
    print('📊 Attempting to save analytics...');
    print(
        'Total players: ${_currentRoom.teamA.length + _currentRoom.teamB.length}');
    print('Questions answered: ${_questions.length}');
    print('Category usage: $categoryUsage');

    try {
      final analyticsService = AnalyticsService();
      final analytics = GameAnalytics(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        roomCode: widget.room.code,
        timestamp: DateTime.now(),
        totalPlayers: _currentRoom.teamA.length + _currentRoom.teamB.length,
        questionsAnswered: _questions.length,
        gameDuration: duration,
        categoryUsage: categoryUsage,
        difficultyBreakdown: difficultyBreakdown,
        bonusStats: {
          'streaksEarned': _currentRoom.teamAStreak + _currentRoom.teamBStreak,
          'speedBonuses': 0, // Can track if needed
          'jackpotsPlayed':
              _questions.where((q) => q['isJackpot'] == true).length,
        },
        powerCardsUsed: _currentRoom.usedPowerCards,
        winningTeam: winner,
      );

      await analyticsService.saveGameAnalytics(analytics);
      print('✅ Analytics saved successfully to Firestore/analytics collection');
    } catch (e) {
      print('❌ Failed to save analytics: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }

  void _handleEndGame() async {
    // Prevent multiple navigations
    if (_navigatedToResults) {
      print('⚠️ Already navigated to results, ignoring duplicate call');
      return;
    }
    _navigatedToResults = true;

    // Save all game data (only if not already saved)
    if (!_gameDataSaved) {
      _gameDataSaved = true;
      print('🎯 Manual save triggered (End Game button)');
      await _saveGameDataOnComplete();
    } else {
      print('ℹ️ Game data already saved, skipping duplicate save');
    }

    // End game in Firebase
    await _firebaseService.endGame(widget.room.code);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(room: _currentRoom, user: widget.user),
        ),
      );
    }
  }

  void _handleStartVoting() async {
    if (widget.user.id != widget.room.hostId) return;

    final nowMs = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      _remainingTime = 60;
      _isTimerRunning = true;
      _timerEndAtMs = nowMs + 60 * 1000;
    });
    _startLocalCountdown();
    await _firebaseService.setTimer(widget.room.code, 60, running: true);
    await _firebaseService.startVoting(widget.room.code);
    setState(() {
      widget.room.votingInProgress = true;
      _selectedAnswerIndex = -1;
      _currentRoom = _currentRoom.copyWith(
        currentTimer: 60,
        isTimerRunning: true,
        timerUpdatedAt: DateTime.now(),
        votingInProgress: true,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.votingStarted),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handleRevealAnswer() async {
    if (_questions.isEmpty) return;

    // Mark that this question was revealed (for syncing to other players)
    try {
      await _firebaseService.updateRoomData(widget.room.code, {
        'lastRevealedQuestion': _currentQuestionIndex,
        'lastRevealedAt': FieldValue.serverTimestamp(),
      });
      print(
          '✅ Reveal marker saved to Firebase: question $_currentQuestionIndex');
    } catch (e) {
      print('❌ Failed to save reveal marker: $e');
    }

    print('🎯 === REVEAL ANSWER START ===');
    print(
        '🎯 Current room scores before calculation: A=${_currentRoom.teamAPoints}, B=${_currentRoom.teamBPoints}');
    print('🎯 Display scores: A=$_displayPointsA, B=$_displayPointsB');

    final currentQuestion = _questions[_currentQuestionIndex];
    final correctAnswerIndex = (currentQuestion['correctAnswer'] as int?) ?? -1;
    final difficulty = currentQuestion['difficulty'] as String? ?? 'easy';

    // Mark question as used to prevent repetition
    final questionId = currentQuestion['id'] as String?;
    if (questionId != null &&
        !_currentRoom.usedQuestionIds.contains(questionId)) {
      await _firebaseService.markQuestionAsUsed(widget.room.code, questionId);
      print('✅ Marked question as used: $questionId');
    }

    // Check if this is a jackpot question
    final isJackpot = _currentRoom.isJackpotQuestion;
    final jackpotValue = _currentRoom.jackpotPoints ?? 0;

    final votes = await _firebaseService.getVotes(widget.room.code);
    final teamAVotes = votes['teamAVotes'] as Map<String, dynamic>;
    final teamBVotes = votes['teamBVotes'] as Map<String, dynamic>;

    // Get base points by difficulty (or jackpot if enabled)
    int basePoints =
        isJackpot ? jackpotValue : _getPointsForDifficulty(difficulty);

    // Count correct answers per team
    int correctA =
        teamAVotes.values.where((v) => v == correctAnswerIndex).length;
    int correctB =
        teamBVotes.values.where((v) => v == correctAnswerIndex).length;

    // Count wrong answers per team
    int wrongA = teamAVotes.length - correctA;
    int wrongB = teamBVotes.length - correctB;

    // Check if current player voted and if they were correct
    final currentUserId = widget.user.id;
    final currentUserTeam = _currentRoom.teamA.any((u) => u.id == currentUserId)
        ? 'A'
        : (_currentRoom.teamB.any((u) => u.id == currentUserId) ? 'B' : null);

    int? currentUserVote;
    bool? currentUserCorrect;

    if (currentUserTeam == 'A' && teamAVotes.containsKey(currentUserId)) {
      currentUserVote = teamAVotes[currentUserId];
      currentUserCorrect = currentUserVote == correctAnswerIndex;
    } else if (currentUserTeam == 'B' &&
        teamBVotes.containsKey(currentUserId)) {
      currentUserVote = teamBVotes[currentUserId];
      currentUserCorrect = currentUserVote == correctAnswerIndex;
    }

    // Show detailed voting results (host sees full breakdown)
    if (widget.isHost) {
      _showVotingResults(
        teamAVotes: teamAVotes.length,
        teamBVotes: teamBVotes.length,
        correctA: correctA,
        correctB: correctB,
        wrongA: wrongA,
        wrongB: wrongB,
        basePoints: basePoints,
      );
    }

    // Show individual result to this player
    if (currentUserCorrect != null) {
      Future.delayed(Duration(milliseconds: widget.isHost ? 100 : 0), () {
        _showPlayerResult(
          isCorrect: currentUserCorrect!,
          basePoints: basePoints,
          isJackpot: isJackpot,
          hasDoublePoints:
              _currentRoom.usedPowerCards.contains('double_points'),
        );
      });
    }

    // Calculate base points for correct answers
    int earnedA = correctA * basePoints;
    int earnedB = correctB * basePoints;

    // Apply penalties for wrong answers (jackpot penalties are same as base points)
    int penaltyA = wrongA *
        (isJackpot ? jackpotValue : _getPenaltyForDifficulty(difficulty));
    int penaltyB = wrongB *
        (isJackpot ? jackpotValue : _getPenaltyForDifficulty(difficulty));

    // Calculate speed bonuses (votes submitted in < 10 seconds)
    int speedBonusA = await _calculateSpeedBonus('A', teamAVotes.keys.toList());
    int speedBonusB = await _calculateSpeedBonus('B', teamBVotes.keys.toList());

    // Update streaks
    int teamAStreak = _currentRoom.teamAStreak;
    int teamBStreak = _currentRoom.teamBStreak;
    int streakBonusA = 0;
    int streakBonusB = 0;

    if (correctA > 0) {
      teamAStreak++;
      if (teamAStreak >= 3) {
        streakBonusA = 200; // Streak bonus
        teamAStreak = 0; // Reset after bonus
      }
    } else {
      teamAStreak = 0; // Break streak
    }

    if (correctB > 0) {
      teamBStreak++;
      if (teamBStreak >= 3) {
        streakBonusB = 200; // Streak bonus
        teamBStreak = 0; // Reset after bonus
      }
    } else {
      teamBStreak = 0; // Break streak
    }

    // Check if double points power card was used
    final hasDoublePoints =
        _currentRoom.usedPowerCards.contains('double_points');
    if (hasDoublePoints) {
      earnedA *= 2;
      earnedB *= 2;
      speedBonusA *= 2;
      speedBonusB *= 2;
      streakBonusA *= 2;
      streakBonusB *= 2;
    }

    // Calculate final points
    int totalA = earnedA + speedBonusA + streakBonusA - penaltyA;
    int totalB = earnedB + speedBonusB + streakBonusB - penaltyB;

    // Use _currentRoom for latest synced points (not widget.room)
    int currentA = _currentRoom.teamAPoints;
    int currentB = _currentRoom.teamBPoints;
    int newPointsA = currentA + totalA;
    int newPointsB = currentB + totalB;

    // Debug scoring
    print('💰 Scoring: Current A=$currentA B=$currentB');
    print(
        '💰 Adding: A=$totalA (earn:$earnedA speed:$speedBonusA streak:$streakBonusA penalty:-$penaltyA)');
    print(
        '💰 Adding: B=$totalB (earn:$earnedB speed:$speedBonusB streak:$streakBonusB penalty:-$penaltyB)');
    print('💰 New totals: A=$newPointsA B=$newPointsB');

    // Ensure points don't go negative
    if (newPointsA < 0) newPointsA = 0;
    if (newPointsB < 0) newPointsB = 0;

    // First update local state immediately for instant feedback
    setState(() {
      _isTimerRunning = false;
      _displayPointsA = newPointsA;
      _displayPointsB = newPointsB;
      _currentRoom = _currentRoom.copyWith(
        scores: {'teamA': newPointsA, 'teamB': newPointsB},
        teamAStreak: teamAStreak,
        teamBStreak: teamBStreak,
        votingInProgress: false,
      );
    });

    // Then update Firebase (scores will sync back and confirm)
    await _firebaseService.updateTeamPoints(
        widget.room.code, newPointsA, newPointsB);
    await _firebaseService.updateStreaks(
        widget.room.code, teamAStreak, teamBStreak);

    // Wait a moment for scores to propagate
    await Future.delayed(const Duration(milliseconds: 200));

    // Then end voting (this clears votes for next round)
    await _firebaseService.endVoting(widget.room.code);

    print('✅ Final scores updated: A=$newPointsA, B=$newPointsB');

    // Show detailed breakdown
    _showScoringBreakdown(
      earnedA,
      earnedB,
      speedBonusA,
      speedBonusB,
      streakBonusA,
      streakBonusB,
      penaltyA,
      penaltyB,
      totalA,
      totalB,
      hasDoublePoints,
      isJackpot,
      difficulty,
    );
  }

  int _getPointsForDifficulty(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return 100;
      case 'medium':
        return 250;
      case 'hard':
        return 400;
      default:
        return 100;
    }
  }

  int _getPenaltyForDifficulty(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return 100;
      case 'medium':
        return 150;
      case 'hard':
        return 200;
      default:
        return 100;
    }
  }

  Future<int> _calculateSpeedBonus(String team, List<String> voterIds) async {
    int speedBonusCount = 0;
    final votingStartedAt = _currentRoom.votingStartedAt;

    if (votingStartedAt == null) return 0;

    for (final userId in voterIds) {
      final voteTime = _currentRoom.voteTimestamps[userId];
      if (voteTime != null) {
        final duration = voteTime.difference(votingStartedAt).inSeconds;
        if (duration < 10) {
          speedBonusCount++;
        }
      }
    }

    return speedBonusCount * 150; // 150 pts per fast vote
  }

  void _showScoringBreakdown(
    int earnedA,
    int earnedB,
    int speedA,
    int speedB,
    int streakA,
    int streakB,
    int penaltyA,
    int penaltyB,
    int totalA,
    int totalB,
    bool doublePoints,
    bool isJackpot,
    String difficulty,
  ) {
    String message = '';
    if (isJackpot) message += '🎁 JACKPOT RESULT!\n';
    message += '📊 Scoring:\n';
    message += 'Team A: ${earnedA > 0 ? "+$earnedA" : "0"}';
    if (speedA > 0) message += ' +$speedA⚡';
    if (streakA > 0) message += ' +$streakA🔥';
    if (penaltyA > 0) message += ' -$penaltyA❌';
    message += ' = ${totalA > 0 ? "+$totalA" : "$totalA"}\n';
    message += 'Team B: ${earnedB > 0 ? "+$earnedB" : "0"}';
    if (speedB > 0) message += ' +$speedB⚡';
    if (streakB > 0) message += ' +$streakB🔥';
    if (penaltyB > 0) message += ' -$penaltyB❌';
    message += ' = ${totalB > 0 ? "+$totalB" : "$totalB"}';
    if (doublePoints) message += '\n💎 DOUBLE POINTS ACTIVE!';

    Color bgColor =
        isJackpot ? Colors.amber : (doublePoints ? Colors.purple : Colors.blue);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  // Show player result when synced from Firebase (for non-host players)
  Future<void> _showPlayerResultFromSync() async {
    if (_questions.isEmpty || _currentQuestionIndex >= _questions.length)
      return;

    final currentQuestion = _questions[_currentQuestionIndex];
    final correctAnswerIndex = (currentQuestion['correctAnswer'] as int?) ?? -1;
    final isJackpot = _currentRoom.isJackpotQuestion;
    final hasDoublePoints =
        _currentRoom.usedPowerCards.contains('double_points');
    final basePoints = isJackpot
        ? (_currentRoom.jackpotPoints ?? 100)
        : _getPointsForDifficulty(
            currentQuestion['difficulty'] as String? ?? 'easy');

    // Get votes and check if this player voted
    final votes = await _firebaseService.getVotes(widget.room.code);
    final teamAVotes = votes['teamAVotes'] as Map<String, dynamic>;
    final teamBVotes = votes['teamBVotes'] as Map<String, dynamic>;

    final currentUserId = widget.user.id;
    int? userVote;

    if (teamAVotes.containsKey(currentUserId)) {
      userVote = teamAVotes[currentUserId];
    } else if (teamBVotes.containsKey(currentUserId)) {
      userVote = teamBVotes[currentUserId];
    }

    if (userVote != null) {
      final isCorrect = userVote == correctAnswerIndex;
      _showPlayerResult(
        isCorrect: isCorrect,
        basePoints: basePoints,
        isJackpot: isJackpot,
        hasDoublePoints: hasDoublePoints,
      );
    }
  }

  // Show individual player result notification
  void _showPlayerResult({
    required bool isCorrect,
    required int basePoints,
    required bool isJackpot,
    required bool hasDoublePoints,
  }) {
    final loc = AppLocalizations.of(context)!;

    int points = basePoints;
    if (hasDoublePoints) points *= 2;

    final title = isCorrect
        ? (isJackpot ? '🎁 JACKPOT!' : '✅ ${loc.correct}')
        : '❌ Wrong Answer';

    final message = isCorrect
        ? 'Your team earned +$points pts!'
        : 'Your team lost -${_getPenaltyPoints(basePoints)} pts';

    final color = isCorrect ? Colors.green : Colors.red;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        backgroundColor: color.withOpacity(0.95),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            if (hasDoublePoints && isCorrect) ...[
              const SizedBox(height: 8),
              const Text(
                '🎊 DOUBLE POINTS ACTIVE!',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: const Text('OK', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );

    // Auto-close after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
    });
  }

  int _getPenaltyPoints(int basePoints) {
    if (basePoints == 100) return 100; // Easy
    if (basePoints == 250) return 150; // Medium
    if (basePoints == 400) return 200; // Hard
    return basePoints; // Jackpot uses same as basePoints
  }

  // Show detailed voting results dialog (for host)
  void _showVotingResults({
    required int teamAVotes,
    required int teamBVotes,
    required int correctA,
    required int correctB,
    required int wrongA,
    required int wrongB,
    required int basePoints,
  }) {
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('📊 Voting Results', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Team A Results
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppConstants.primaryRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    '${loc.teamA} Results',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryRed,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Votes',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('$teamAVotes',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('✅ Correct',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.green)),
                          Text('$correctA',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('❌ Wrong',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                          Text('$wrongA',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                  if (correctA > 0) ...[
                    const SizedBox(height: 8),
                    Text('+${correctA * basePoints} pts',
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Team B Results
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppConstants.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    '${loc.teamB} Results',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryGreen,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Votes',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('$teamBVotes',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('✅ Correct',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.green)),
                          Text('$correctB',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('❌ Wrong',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                          Text('$wrongB',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                  if (correctB > 0) ...[
                    const SizedBox(height: 8),
                    Text('+${correctB * basePoints} pts',
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (_loadingQuestions) {
      return Scaffold(
        body: Stack(
          children: [
            // Kuwaiti background for loading state
            Positioned.fill(
              child: Opacity(
                opacity: 0.12,
                child: Image.asset(
                  'assets/images/Kuwaiti.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    Color syncColor;
    if (!_isTimerRunning) {
      syncColor = Colors.grey;
    } else if (_timerEndAtMs != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final pred = ((_timerEndAtMs! - now) / 1000).ceil();
      final delta = (pred - _remainingTime).abs();
      syncColor = delta <= 1 ? Colors.green : Colors.redAccent;
    } else {
      syncColor = Colors.amber;
    }

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(loc.dorakGameTitle),
        backgroundColor: const Color(0xFFCE1126),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (widget.isHost)
            IconButton(
              tooltip: loc.hostControlsTooltip,
              icon: const Icon(Icons.tune),
              onPressed: _openHostMenu,
            ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildGameHeader(context, syncColor),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildQuestionCard(context, currentQuestion),
                      const SizedBox(height: 20),
                      // Check if it's a physical/verbal challenge (no options)
                      if (_isPhysicalChallenge(currentQuestion))
                        _buildPhysicalChallengeInfo(context, currentQuestion)
                      else ...[
                        _buildAnswerOptions(context, currentQuestion),
                        const SizedBox(height: 20),
                        // Show vote button for ALL players including host
                        _buildVoteButton(context),
                        // Note: Voting status removed from here
                        // Only host control panel shows voting status
                      ],
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_isChatVisible)
            Positioned(
              right: 16,
              bottom: 16,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ChatWidget(
                  room: widget.room,
                  user: widget.user,
                  lobbyService: _lobbyService,
                  l10n: loc,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isChatVisible = !_isChatVisible;
          });
        },
        backgroundColor: Colors.green,
        child: Icon(_isChatVisible ? Icons.close : Icons.chat),
      ),
    );
  }

  void _openHostMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        final height = MediaQuery.of(context).size.height * 0.6;
        return SizedBox(
          height: height,
          child: HostControlPanel(
            room: _currentRoom,
            currentVotes: _currentVotes,
            onPointsAdjust: _handlePointsAdjust,
            onTimerAdjust: _handleTimerAdjust,
            onNextQuestion: _handleNextQuestion,
            onSkipQuestion: _handleSkipQuestion,
            onPowerCardUsed: _handlePowerCardUsed,
            onEndGame: _handleEndGame,
            onStartVoting: _handleStartVoting,
            onRevealAnswer: _handleRevealAnswer,
            onPhysicalChallengeApprove: _handlePhysicalChallengeApprove,
          ),
        );
      },
    );
  }

  Widget _buildGameHeader(BuildContext context, Color syncColor) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(loc.teamA,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFCE1126))),
                Text('$_displayPointsA',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(loc.playersCount(widget.room.teamA.length),
                    style: const TextStyle(fontSize: 16)),
                if (_currentRoom.teamAStreak > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '🔥 ${_currentRoom.teamAStreak} streak',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          Column(
            children: [
              Text(loc.timeLabel,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold)),
              Text('$_remainingTime',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCE1126))),
              Text(loc.secondsLabel,
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 4),
              Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: syncColor, shape: BoxShape.circle),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Text(loc.teamB,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF007A3D))),
                Text('$_displayPointsB',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(loc.playersCount(widget.room.teamB.length),
                    style: const TextStyle(fontSize: 16)),
                if (_currentRoom.teamBStreak > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '🔥 ${_currentRoom.teamBStreak} streak',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(
      BuildContext context, Map<String, dynamic> question) {
    final loc = AppLocalizations.of(context)!;
    final difficulty =
        (question['difficulty'] as String? ?? 'easy').toLowerCase();
    final isJackpot = _currentRoom.isJackpotQuestion;
    final points = isJackpot
        ? (_currentRoom.jackpotPoints ?? 0)
        : _getPointsForDifficulty(difficulty);
    final difficultyColor = isJackpot
        ? Colors.amber
        : (difficulty == 'hard'
            ? Colors.red
            : (difficulty == 'medium' ? Colors.orange : Colors.green));

    return Card(
      elevation: isJackpot ? 8 : 4,
      shadowColor: isJackpot ? Colors.amber : null,
      child: Container(
        decoration: isJackpot
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber, width: 3),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (isJackpot)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade700, Colors.amber.shade400],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '🎁 JACKPOT QUESTION! $points PTS!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.white, size: 24),
                    ],
                  ),
                ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCE1126).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      question['category'] ?? loc.generalKnowledge,
                      style: const TextStyle(
                          color: Color(0xFFCE1126),
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (!isJackpot)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: difficultyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            difficulty == 'hard'
                                ? Icons.star
                                : (difficulty == 'medium'
                                    ? Icons.star_half
                                    : Icons.star_outline),
                            size: 12,
                            color: difficultyColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$points pts',
                            style: TextStyle(
                                color: difficultyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _getLocalizedQuestion(question),
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, height: 1.3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              _buildCategoryProgress(question),
              const SizedBox(height: 8),
              Text(
                loc.questionNumber(
                  (_currentQuestionIndex + 1),
                  (_questions.length),
                ),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryProgress(Map<String, dynamic> question) {
    final currentCategory = question['categoryId'] as String?;
    if (currentCategory == null) return const SizedBox.shrink();

    // Count questions from same category up to current index
    int categoryQuestionsAnswered = 0;
    int totalInCategory = 0;
    int easyCount = 0;
    int mediumCount = 0;
    int hardCount = 0;

    for (int i = 0; i < _questions.length; i++) {
      if (_questions[i]['categoryId'] == currentCategory) {
        totalInCategory++;
        final diff =
            (_questions[i]['difficulty'] as String? ?? 'easy').toLowerCase();
        if (diff == 'easy') easyCount++;
        if (diff == 'medium') mediumCount++;
        if (diff == 'hard') hardCount++;

        if (i < _currentQuestionIndex) {
          categoryQuestionsAnswered++;
        }
      }
    }

    final currentInCategory =
        categoryQuestionsAnswered + 1; // +1 for current question

    if (totalInCategory <= 1)
      return const SizedBox.shrink(); // Don't show if only 1 question

    final progress = currentInCategory / totalInCategory;

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          runSpacing: 4,
          children: [
            const Icon(Icons.category, size: 14, color: Colors.grey),
            Text(
              'Category: $currentInCategory/$totalInCategory',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Difficulty indicators
            if (easyCount > 0) ...[
              Icon(Icons.circle, size: 6, color: Colors.green),
              Text('$easyCount',
                  style: TextStyle(fontSize: 9, color: Colors.grey)),
            ],
            if (mediumCount > 0) ...[
              Icon(Icons.circle, size: 6, color: Colors.orange),
              Text('$mediumCount',
                  style: TextStyle(fontSize: 9, color: Colors.grey)),
            ],
            if (hardCount > 0) ...[
              Icon(Icons.circle, size: 6, color: Colors.red),
              Text('$hardCount',
                  style: TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFCE1126)),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  // SIMPLE SOLUTION: Load from cached ARB based on language
  String _getLocalizedQuestion(Map<String, dynamic> question) {
    final questionId = question['id'] as String?;
    final lang = Localizations.localeOf(context).languageCode;

    print('🔍 _getLocalizedQuestion called');
    print('  Question ID: $questionId');
    print('  Language: $lang');
    print('  🔎 FULL QUESTION DATA: $question');
    print('  question_ar: ${question['question_ar']}');
    print('  question_en: ${question['question_en']}');
    print('  question: ${question['question']}');

    // For default questions (q_gk_001 format), use ARB
    if (questionId != null && questionId.startsWith('q_')) {
      final key = '${questionId}_text';
      final arbText = _arbCache[key];

      if (arbText != null && arbText.toString().isNotEmpty) {
        print('  ✅ Using ARB translation!');
        return arbText.toString();
      }
    }

    // For OpenTrivia/imported questions - use stored translations
    if (lang == 'ar') {
      // Try Arabic first
      if (question['question_ar'] != null &&
          question['question_ar'].toString().isNotEmpty) {
        print('  ✅ Using stored Arabic translation');
        return question['question_ar'].toString();
      }
    }

    // Try English
    if (question['question_en'] != null &&
        question['question_en'].toString().isNotEmpty) {
      print('  ✅ Using stored English translation');
      return question['question_en'].toString();
    }

    // Final fallback to 'question' field
    print('  ⚠️ Using fallback question field');
    return question['question']?.toString() ?? '';
  }

  List<String> _getLocalizedOptions(Map<String, dynamic> question) {
    final questionId = question['id'] as String?;

    // For default questions (q_gk_001 format), use ARB
    if (questionId != null && questionId.startsWith('q_')) {
      final options = <String>[];
      for (int i = 1; i <= 10; i++) {
        final key = '${questionId}_opt$i';
        final value = _arbCache[key];
        if (value != null && value.toString().isNotEmpty) {
          options.add(value.toString());
        } else {
          break;
        }
      }
      if (options.isNotEmpty) {
        return options; // ✅ From ARB!
      }
    }

    // For imported questions, use stored translations
    final lang = Localizations.localeOf(context).languageCode;
    if (lang == 'ar' && question['options_ar'] != null) {
      return List<String>.from(question['options_ar']);
    }
    if (question['options_en'] != null) {
      return List<String>.from(question['options_en']);
    }

    // Final fallback
    return List<String>.from(question['options'] ?? []);
  }

  bool _isPhysicalChallenge(Map<String, dynamic> question) {
    final options = question['options'];
    // Physical/verbal challenges have no answer options
    return options == null || (options is List && options.isEmpty);
  }

  Widget _buildPhysicalChallengeInfo(
      BuildContext context, Map<String, dynamic> question) {
    final approvedTeam = _currentRoom.physicalChallengeApproved;
    final isApproved = approvedTeam != null;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isApproved
                  ? [Colors.green.shade600, Colors.green.shade400]
                  : [Colors.orange.shade600, Colors.deepOrange.shade400],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(
                isApproved ? Icons.check_circle : Icons.sports_martial_arts,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                isApproved ? '✅ CHALLENGE APPROVED!' : '💪 PHYSICAL CHALLENGE!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _getPhysicalChallengeMessage(isApproved, approvedTeam),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getPhysicalChallengeMessage(bool isApproved, String? approvedTeam) {
    if (widget.isHost) {
      if (isApproved) {
        return 'Team $approvedTeam successfully completed! Points awarded.';
      }
      return 'Use "Approve Challenge" button in Host Controls to award points!';
    } else {
      if (isApproved) {
        return '✅ Team $approvedTeam completed the challenge! Points awarded.';
      }
      return '⏳ Perform the challenge! Waiting for host approval...';
    }
  }

  Widget _buildAnswerOptions(
      BuildContext context, Map<String, dynamic> question) {
    final loc = AppLocalizations.of(context)!;
    final options = _getLocalizedOptions(question);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(loc.selectYourAnswer,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.2),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return _buildAnswerOption(options[index], index);
          },
        ),
      ],
    );
  }

  Widget _buildAnswerOption(String option, int index) {
    final isSelected = _selectedAnswerIndex == index;
    return GestureDetector(
      onTap: () => _handleAnswerSelect(index),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF007A3D) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  isSelected ? const Color(0xFF007A3D) : Colors.grey.shade300,
              width: 1.5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(option,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black87),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }

  Widget _buildVoteButton(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _selectedAnswerIndex == -1 ? null : _handleVoteSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFCE1126),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(loc.submitVote,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _startLocalCountdown() {
    _countdown?.cancel();
    if (_timerEndAtMs == null || !_isTimerRunning) return;
    bool stopWritten = false;
    void tick() {
      if (!mounted || _timerEndAtMs == null) return;
      final now = DateTime.now().millisecondsSinceEpoch;
      final rem = ((_timerEndAtMs! - now) / 1000).ceil();
      setState(() {
        _remainingTime = rem > 0 ? rem : 0;
        if (_remainingTime <= 0) {
          _isTimerRunning = false;
          _countdown?.cancel();
        }
      });
      if (_remainingTime <= 0 &&
          !stopWritten &&
          widget.user.id == widget.room.hostId) {
        stopWritten = true;
        _firebaseService.setTimer(widget.room.code, 0, running: false);
      }
    }

    tick();
    _countdown = Timer.periodic(const Duration(seconds: 1), (_) => tick());
  }
}
