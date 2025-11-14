import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:DORAK/l10n/app_localizations.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../widgets/host_control_panel.dart';
import '../utils/constants.dart';
import 'result_screen.dart';
import '../services/firebase_service.dart';
import '../services/question_service.dart';
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
  final Map<String, int> _teamVotes = {'A': 0, 'B': 0};
  Timer? _countdown;
  int? _timerEndAtMs;
  bool _isChatVisible = false;

  final FirebaseService _firebaseService = FirebaseService();
  final QuestionService _questionService = QuestionService();
  final LobbyService _lobbyService = LobbyService();

  List<Map<String, dynamic>> _questions = [];
  bool _loadingQuestions = true;
  StreamSubscription? _roomSub;
  int _displayPointsA = 0;
  int _displayPointsB = 0;
  late GameRoom _currentRoom;
  
  // Add real-time vote tracking
  Map<String, dynamic> _currentVotes = {'teamAVotes': {}, 'teamBVotes': {}};
  StreamSubscription? _votesSub;

// Guard against redundant timer updates
  int? _lastTimerStampMs;
  int? _lastServerTimer;
  bool? _lastRunning;

  final Set<String> _ackPowerCards = {};

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
    for (final category in selectedCategories) {
      final snap = await FirebaseFirestore.instance
          .collection('categories')
          .doc(category.id)
          .collection('challenges')
          .get();
      for (final doc in snap.docs) {
        final data = doc.data();
        final options =
            (data['options_${lang}'] as List?)?.cast<String>() ??
            (data['options'] as List?)?.cast<String>() ??
            const [];
        final correct = data['correctAnswer'];
        int correctIndex = -1;
        if (correct is int) {
          correctIndex = correct;
        } else if (correct is String && options.isNotEmpty) {
          correctIndex = options.indexOf(correct);
        }
        loadedQuestions.add({
          'id': doc.id,
          'category': category.name,
          'categoryId': category.id,
          'question': (data['question_${lang}'] as String?) ??
              (data['question'] as String?) ??
              '',
          'options': options,
          'correctAnswer': correctIndex,
        });
      }
    }
    loadedQuestions.shuffle();
    setState(() {
      _questions = loadedQuestions;
      _loadingQuestions = false;
    });
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

    _loadQuestions();
    
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
        print('[Timer][GS] pending=${snap.metadata.hasPendingWrites} cache=${snap.metadata.isFromCache} ver=$ver run=$runDbg ct=$ctDbg ts=$rawTs');
      } catch (_) {}
      
      final room = GameRoom.fromJson(data);
      final idx = (data['currentRound'] as num?)?.toInt() ?? 0;
      final state = data['state'] as String?;
      
      if (mounted) {
        setState(() {
          _currentRoom = room;
          _currentQuestionIndex =
              idx.clamp(0, _questions.isEmpty ? 0 : _questions.length - 1);
          final scores = data['scores'] as Map<String, dynamic>?;
          if (scores != null) {
            _displayPointsA =
                (scores['teamA'] as num?)?.toInt() ?? _displayPointsA;
            _displayPointsB =
                (scores['teamB'] as num?)?.toInt() ?? _displayPointsB;
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
                _remainingTime = rem.clamp(0, 9999);
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
      }
      if (state == 'GameState.gameComplete' && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultScreen(room: _currentRoom, user: widget.user),
          ),
        );
      }
    });
    
    final bool isHost = widget.user.id == _currentRoom.hostId;
    if (!_currentRoom.votingInProgress && isHost) {
      _currentRoom.startVoting();
    }
  }

  // Add real-time votes listener
  void _startVotesListener() {
    _votesSub = _firebaseService.getVotesStream(widget.room.code).listen((votes) {
      if (mounted) {
        setState(() {
          _currentVotes = votes;
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

  await _firebaseService.submitVote(
      _currentRoom.code, userTeam, widget.user.id, _selectedAnswerIndex);

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

  void _handleEndGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultScreen(room: widget.room, user: widget.user),
      ),
    );
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
    final currentQuestion = _questions[_currentQuestionIndex];
    final correctAnswerIndex = (currentQuestion['correctAnswer'] as int?) ?? -1;

    final votes = await _firebaseService.getVotes(widget.room.code);
    final teamAVotes = votes['teamAVotes'] as Map<String, dynamic>;
    final teamBVotes = votes['teamBVotes'] as Map<String, dynamic>;

    int correctA =
        teamAVotes.values.where((v) => v == correctAnswerIndex).length;
    int correctB =
        teamBVotes.values.where((v) => v == correctAnswerIndex).length;

    int pointsA = widget.room.teamAPoints + correctA;
    int pointsB = widget.room.teamBPoints + correctB;

    await _firebaseService.updateTeamPoints(widget.room.code, pointsA, pointsB);
    await _firebaseService.endVoting(widget.room.code);

    setState(() {
      _isTimerRunning = false;
      widget.room.updatePoints(pointsA, pointsB);
      widget.room.votingInProgress = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.answerRevealed(
            correctA,
            correctB,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // Helper method to get real-time vote counts
 int get _totalVotesA {
  final teamAVotes = _currentVotes['teamAVotes'];
  if (teamAVotes is Map) return teamAVotes.length;
  return 0;
}

int get _totalVotesB {
  final teamBVotes = _currentVotes['teamBVotes'];
  if (teamBVotes is Map) return teamBVotes.length;
  return 0;
}

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (_loadingQuestions) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
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
                      _buildAnswerOptions(context, currentQuestion),
                      const SizedBox(height: 20),
                      // Show vote button for ALL players including host
                      _buildVoteButton(context),
                      if (widget.isHost) _buildVotesDisplay(context),
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
            onPointsAdjust: _handlePointsAdjust,
            onTimerAdjust: _handleTimerAdjust,
            onNextQuestion: _handleNextQuestion,
            onSkipQuestion: _handleSkipQuestion,
            onPowerCardUsed: _handlePowerCardUsed,
            onEndGame: _handleEndGame,
            onStartVoting: _handleStartVoting,
            onRevealAnswer: _handleRevealAnswer,
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
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
              ),
            ),
            const SizedBox(height: 12),
            Text(
              question['question'] ?? '',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, height: 1.3),
              textAlign: TextAlign.center,
            ),
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
    );
  }

  Widget _buildAnswerOptions(
      BuildContext context, Map<String, dynamic> question) {
    final loc = AppLocalizations.of(context)!;
    final options = List<String>.from(question['options'] ?? []);
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

  Widget _buildVotesDisplay(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(loc.teamVotes,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  Text(loc.teamA,
                      style: const TextStyle(
                          color: Color(0xFFCE1126),
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  Text(loc.votesCount(_totalVotesA),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
                Column(children: [
                  Text(loc.teamB,
                      style: const TextStyle(
                          color: Color(0xFF007A3D),
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  Text(loc.votesCount(_totalVotesB),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.room.votingInProgress
                  ? loc.votingInProgress
                  : loc.waitingForHost,
              style: TextStyle(
                fontSize: 12,
                color:
                    widget.room.votingInProgress ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
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
        _remainingTime = rem.clamp(0, 9999);
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