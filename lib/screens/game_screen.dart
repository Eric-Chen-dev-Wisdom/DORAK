import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../widgets/host_control_panel.dart';
import '../utils/constants.dart';
import 'result_screen.dart';
import '../services/firebase_service.dart';
import '../services/question_service.dart';

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
  Map<String, int> _teamVotes = {'A': 0, 'B': 0};

  final FirebaseService _firebaseService = FirebaseService();
  final QuestionService _questionService = QuestionService();

  List<Map<String, dynamic>> _questions = [];
  bool _loadingQuestions = true;
  StreamSubscription? _roomSub;
  int _displayPointsA = 0;
  int _displayPointsB = 0;

  // Load questions prepared by host, fallback to Firestore if missing
  Future<void> _loadQuestions() async {
    // If host already prepared questions, use them
    if (widget.room.preparedQuestions.isNotEmpty) {
      setState(() {
        _questions = widget.room.preparedQuestions;
        _loadingQuestions = false;
      });
      return;
    }

    // Fallback: load everything (legacy)
    final selectedCategories = widget.room.selectedCategories;
    final List<Map<String, dynamic>> loadedQuestions = [];
    for (final category in selectedCategories) {
      final snap = await FirebaseFirestore.instance
          .collection('categories')
          .doc(category.id)
          .collection('challenges')
          .get();
      for (final doc in snap.docs) {
        final data = doc.data();
        final options = (data['options'] as List?)?.cast<String>() ?? const [];
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
          'question': data['question'] ?? '',
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
    _remainingTime = widget.room.currentTimer;
    _isTimerRunning = widget.room.isTimerRunning;
    _displayPointsA = widget.room.teamAPoints;
    _displayPointsB = widget.room.teamBPoints;

    _loadQuestions(); // Load Firestore questions

    // Sync current question and game state across clients
    _roomSub = _firebaseService.getRoomStream(widget.room.code).listen((snap) {
      final data = snap.data();
      if (data == null) return;
      final idx = (data['currentRound'] as num?)?.toInt() ?? 0;
      final state = data['state'] as String?;
      if (mounted) {
        setState(() {
          _currentQuestionIndex =
              idx.clamp(0, _questions.isEmpty ? 0 : _questions.length - 1);
          final scores = data['scores'] as Map<String, dynamic>?;
          if (scores != null) {
            _displayPointsA =
                (scores['teamA'] as num?)?.toInt() ?? _displayPointsA;
            _displayPointsB =
                (scores['teamB'] as num?)?.toInt() ?? _displayPointsB;
          }
        });
      }
      if (state == 'GameState.gameComplete' && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(room: widget.room, user: widget.user),
          ),
        );
      }
    });

    // Initialize voting state (derive host from room.hostId)
    final bool isHost = widget.user.id == widget.room.hostId;
    if (!widget.room.votingInProgress && isHost) {
      widget.room.startVoting();
    }
  }

  @override
  void dispose() {
    _roomSub?.cancel();
    super.dispose();
  }

  void _handleAnswerSelect(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  void _handleVoteSubmit() async {
    if (_selectedAnswerIndex == -1) return;
    // Guard: host cannot vote
    if (widget.user.id == widget.room.hostId) return;

    final userTeam =
        widget.room.teamA.any((u) => u.id == widget.user.id) ? 'A' : 'B';

    await _firebaseService.submitVote(
        widget.room.code, userTeam, widget.user.id, _selectedAnswerIndex);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Vote submitted for option ${_selectedAnswerIndex + 1}'),
      ),
    );
  }

  void _handlePointsAdjust(int points) {
    setState(() {});
  }

  void _handleTimerAdjust(int seconds) {
    setState(() {
      _remainingTime = seconds;
      widget.room.updateTimer(seconds);
    });
  }

  void _handleNextQuestion() async {
    if (_questions.isEmpty) return;
    await _firebaseService.nextQuestion(widget.room.code, _questions.length);
  }

  void _handleSkipQuestion() async {
    if (_questions.isEmpty) return;
    await _firebaseService.nextQuestion(widget.room.code, _questions.length);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Question skipped!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _handlePowerCardUsed(String card) {
    widget.room.usePowerCard(card);

    switch (card) {
      case 'Double Points':
        break;
      case 'Steal Points':
        final stolenPoints = 2;
        final newTeamAPoints = widget.room.teamAPoints + stolenPoints;
        final newTeamBPoints = widget.room.teamBPoints - stolenPoints;
        widget.room.updatePoints(newTeamAPoints, newTeamBPoints);
        break;
      case 'Reverse Turn':
        break;
      case 'Skip Round':
        _handleSkipQuestion();
        return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$card activated!'),
        backgroundColor: Colors.purple,
      ),
    );
    setState(() {});
  }

  void _handleEndGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(room: widget.room, user: widget.user),
      ),
    );
  }

  // Host starts voting
  void _handleStartVoting() async {
    if (widget.user.id != widget.room.hostId) return;

    await _firebaseService.startVoting(widget.room.code);
    setState(() {
      widget.room.votingInProgress = true;
      _selectedAnswerIndex = -1;
      _remainingTime = 60;
      _isTimerRunning = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voting started! Teams can now submit answers.'),
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
          'Answer revealed! Team A: +$correctA, Team B: +$correctB',
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingQuestions) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('DORAK Game'),
        backgroundColor: const Color(0xFFCE1126),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (widget.isHost)
            IconButton(
              tooltip: 'Host Controls',
              icon: const Icon(Icons.tune),
              onPressed: _openHostMenu,
            ),
        ],
      ),
      body: Column(
        children: [
          _buildGameHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildQuestionCard(currentQuestion),
                  const SizedBox(height: 20),
                  _buildAnswerOptions(currentQuestion),
                  const SizedBox(height: 20),
                  if (!widget.isHost) _buildVoteButton(),
                  if (widget.isHost) _buildVotesDisplay(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Host controls moved to AppBar menu
        ],
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
            room: widget.room,
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

  Widget _buildGameHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('Team A',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFCE1126))),
                Text('$_displayPointsA',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text('${widget.room.teamA.length} players',
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            children: [
              const Text('TIME',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold)),
              Text('$_remainingTime',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCE1126))),
              const Text('seconds',
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                const Text('Team B',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF007A3D))),
                Text('$_displayPointsB',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text('${widget.room.teamB.length} players',
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
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
                question['category'] ?? 'General Knowledge',
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
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(Map<String, dynamic> question) {
    final options = List<String>.from(question['options'] ?? []);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Select your answer:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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

  Widget _buildVoteButton() {
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
        child: const Text('SUBMIT VOTE',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildVotesDisplay() {
    final totalVotesA = widget.room.getTotalVotesForTeam('A');
    final totalVotesB = widget.room.getTotalVotesForTeam('B');
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text('Team Votes',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  const Text('Team A',
                      style: TextStyle(
                          color: Color(0xFFCE1126),
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  Text('$totalVotesA votes',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
                Column(children: [
                  const Text('Team B',
                      style: TextStyle(
                          color: Color(0xFF007A3D),
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  Text('$totalVotesB votes',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.room.votingInProgress
                  ? 'Voting in progress...'
                  : 'Waiting for host...',
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
}
