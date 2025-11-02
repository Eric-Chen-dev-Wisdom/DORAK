import 'package:flutter/material.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../widgets/host_control_panel.dart';
import '../utils/constants.dart';

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

  // Sample questions for testing
  final List<Map<String, dynamic>> _sampleQuestions = [
    {
      'id': '1',
      'question': 'Which animal is known as the "Ship of the Desert"?',
      'options': ['Elephant', 'Camel', 'Horse', 'Lion'],
      'correctAnswer': 1,
      'category': 'Animals',
    },
    {
      'id': '2',
      'question': 'What is the capital of France?',
      'options': ['London', 'Berlin', 'Paris', 'Madrid'],
      'correctAnswer': 2,
      'category': 'Geography',
    },
  ];

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.room.currentTimer;
    _isTimerRunning = widget.room.isTimerRunning;

    // Ensure voting is properly initialized
    if (!widget.room.votingInProgress) {
      widget.room.startVoting();
    }
  }

  void _handleAnswerSelect(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  void _handleVoteSubmit() {
    if (_selectedAnswerIndex == -1) return;

    final userTeam =
        widget.room.teamA.any((user) => user.id == widget.user.id) ? 'A' : 'B';

    // Use the GameRoom's voting system
    widget.room.submitVote(userTeam, _selectedAnswerIndex, widget.user.id);

    setState(() {
      // Update local state to reflect the vote
      _teamVotes[userTeam] = widget.room.getTotalVotesForTeam(userTeam);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('Vote submitted for option ${_selectedAnswerIndex + 1}')),
    );
  }

  void _handlePointsAdjust(int points) {
    // The points are already updated in the GameRoom by the host control panel
    // Just refresh the UI to show the new scores
    setState(() {});
    print(
        'UI refreshed - Team A: ${widget.room.teamAPoints}, Team B: ${widget.room.teamBPoints}');
  }

  void _handleTimerAdjust(int seconds) {
    setState(() {
      _remainingTime = seconds;
      widget.room.updateTimer(seconds);
    });
    print('Timer adjusted to: $seconds seconds');
  }

  void _handleNextQuestion() {
    setState(() {
      _currentQuestionIndex =
          (_currentQuestionIndex + 1) % _sampleQuestions.length;
      _selectedAnswerIndex = -1;
      _remainingTime = 60;
      _teamVotes = {'A': 0, 'B': 0};
      widget.room.startVoting(); // Automatically start voting for next question
      _isTimerRunning = true;
    });

    final nextQuestion = _sampleQuestions[_currentQuestionIndex];
    print('Next question: ${nextQuestion['question']}');
  }

  void _handleSkipQuestion() {
    setState(() {
      _currentQuestionIndex =
          (_currentQuestionIndex + 1) % _sampleQuestions.length;
      _selectedAnswerIndex = -1;
      _remainingTime = 60;
      _teamVotes = {'A': 0, 'B': 0};
      widget.room.startVoting(); // Start voting for skipped question
      _isTimerRunning = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Question skipped!'), backgroundColor: Colors.orange),
    );
    print('Question skipped');
  }

  void _handlePowerCardUsed(String card) {
    widget.room.usePowerCard(card);

    // Handle different power card effects
    switch (card) {
      case 'Double Points':
        // Implement double points logic
        break;
      case 'Steal Points':
        // Steal 2 points from other team
        final stolenPoints = 2;
        final newTeamAPoints = widget.room.teamAPoints + stolenPoints;
        final newTeamBPoints = widget.room.teamBPoints - stolenPoints;
        widget.room.updatePoints(newTeamAPoints, newTeamBPoints);
        break;
      case 'Reverse Turn':
        // Reverse question to other team logic
        break;
      case 'Skip Round':
        _handleSkipQuestion();
        return; // Skip the snackbar below since we already show one
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('$card activated!'), backgroundColor: Colors.purple),
    );
    setState(() {});
    print('Power card used: $card');
  }

  void _handleEndGame() {
    Navigator.pop(context);
    print('Game ended');
  }

  // Add these missing methods:
  void _handleStartVoting() {
    setState(() {
      widget.room.startVoting();
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
    print('Voting started for all teams');
  }

  void _handleRevealAnswer() {
    final currentQuestion = _sampleQuestions[_currentQuestionIndex];
    final correctAnswerIndex = currentQuestion['correctAnswer'] as int;
    final correctAnswer = currentQuestion['options'][correctAnswerIndex];

    // Get team final answers
    final teamAnswers = widget.room.getTeamFinalAnswers();

    // Calculate points based on correct answers
    int pointsToAwardA = 0;
    int pointsToAwardB = 0;

    if (teamAnswers['A'] == correctAnswerIndex) {
      pointsToAwardA = 1;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('✅ Team A answered correctly!'),
            backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('❌ Team A answered incorrectly'),
            backgroundColor: Colors.red),
      );
    }

    if (teamAnswers['B'] == correctAnswerIndex) {
      pointsToAwardB = 1;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('✅ Team B answered correctly!'),
            backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('❌ Team B answered incorrectly'),
            backgroundColor: Colors.red),
      );
    }

    // Update scores
    widget.room.updatePoints(
      widget.room.teamAPoints + pointsToAwardA,
      widget.room.teamBPoints + pointsToAwardB,
    );

    setState(() {
      _isTimerRunning = false;
      widget.room.votingInProgress = false;
    });

    print('Answer revealed: $correctAnswer');
    print(
        'Team A answer: ${teamAnswers['A']}, Team B answer: ${teamAnswers['B']}');
    print('Points awarded - A: $pointsToAwardA, B: $pointsToAwardB');
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _sampleQuestions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('DORAK Game'),
        backgroundColor: const Color(0xFFCE1126),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Game Header with Scores and Timer
          _buildGameHeader(),

          // Main Content Area - Made scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Question Card
                  _buildQuestionCard(currentQuestion),

                  const SizedBox(height: 20),

                  // Answer Options
                  _buildAnswerOptions(currentQuestion),

                  const SizedBox(height: 20),

                  // Vote Button (for players)
                  if (!widget.isHost) _buildVoteButton(),

                  // Team Votes Display (for host)
                  if (widget.isHost) _buildVotesDisplay(),

                  // Add some bottom padding for scroll
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Host Controls (only for host) - Fixed height
          if (widget.isHost)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5, // Fixed height
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
            ),
        ],
      ),
    );
  }

  Widget _buildGameHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Team A Score
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Team A',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCE1126),
                  ),
                ),
                Text(
                  '${widget.room.teamAPoints}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.room.teamA.length} players',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Timer
          Column(
            children: [
              const Text(
                'TIME',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$_remainingTime',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCE1126),
                ),
              ),
              const Text(
                'seconds',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          // Team B Score
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Team B',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF007A3D),
                  ),
                ),
                Text(
                  '${widget.room.teamBPoints}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.room.teamB.length} players',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
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
            // Category Badge
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
                  fontSize: 10,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Question Text
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Question Progress
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_sampleQuestions.length}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
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
        const Text(
          'Select your answer:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // Answer Options Grid - More compact
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.2,
          ),
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
            color: isSelected ? const Color(0xFF007A3D) : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'SUBMIT VOTE',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildVotesDisplay() {
    // Get real vote counts from GameRoom
    final totalVotesA = widget.room.getTotalVotesForTeam('A');
    final totalVotesB = widget.room.getTotalVotesForTeam('B');

    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              'Team Votes',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Team A',
                      style: TextStyle(
                        color: Color(0xFFCE1126),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '$totalVotesA votes',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Team B',
                      style: TextStyle(
                        color: Color(0xFF007A3D),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '$totalVotesB votes',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Add voting status
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
