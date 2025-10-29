import 'dart:async'; // ADD THIS IMPORT
import 'package:flutter/material.dart';
import '../models/room_model.dart';

class HostControlPanel extends StatefulWidget {
  final GameRoom room;
  final Function(int) onPointsAdjust;
  final Function(int) onTimerAdjust;
  final Function() onNextQuestion;
  final Function() onSkipQuestion;
  final Function(String) onPowerCardUsed;
  final Function() onEndGame;
  final Function() onStartVoting;
  final Function() onRevealAnswer;

  const HostControlPanel({
    super.key,
    required this.room,
    required this.onPointsAdjust,
    required this.onTimerAdjust,
    required this.onNextQuestion,
    required this.onSkipQuestion,
    required this.onPowerCardUsed,
    required this.onEndGame,
    required this.onStartVoting,
    required this.onRevealAnswer,
  });

  @override
  State<HostControlPanel> createState() => _HostControlPanelState();
}

class _HostControlPanelState extends State<HostControlPanel> {
  int _remainingTime = 60;
  bool _isTimerRunning = false;
  late GameRoom _currentRoom;
  Timer? _timer; // Add this to track the timer

  @override
  void initState() {
    super.initState();
    _currentRoom = widget.room;
    _remainingTime = _currentRoom.currentTimer;
    _isTimerRunning = _currentRoom.isTimerRunning;
  }

  @override
  void dispose() {
    _timer?.cancel(); // Important: cancel timer when widget disposes
    super.dispose();
  }

  void _startTimer() {
    if (_isTimerRunning) return; // Prevent multiple starts
    
    setState(() {
      _isTimerRunning = true;
    });
    
    _startTimerCountdown();
    widget.onTimerAdjust(_remainingTime);
  }

  void _startTimerCountdown() {
    // Cancel any existing timer first
    _timer?.cancel();
    
    // Create new timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Check if widget is still mounted
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        widget.onTimerAdjust(_remainingTime);
      } else {
        setState(() {
          _isTimerRunning = false;
        });
        timer.cancel();
        // Auto-stop when time reaches 0
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Time\'s up!')),
          );
        }
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
    _timer?.cancel(); // Cancel the timer
    widget.onTimerAdjust(_remainingTime);
  }

  void _resetTimer() {
    _timer?.cancel(); // Cancel any running timer
    setState(() {
      _remainingTime = 60;
      _isTimerRunning = false;
    });
    widget.onTimerAdjust(_remainingTime);
  }

  void _adjustTimer(int seconds) {
    _timer?.cancel(); // Cancel timer when adjusting time
    setState(() {
      _remainingTime += seconds;
      if (_remainingTime < 5) _remainingTime = 5; // Minimum 5 seconds
      if (_remainingTime > 300) _remainingTime = 300; // Maximum 5 minutes
      _isTimerRunning = false; // Stop timer when adjusting
    });
    widget.onTimerAdjust(_remainingTime);
  }

  void _adjustPoints(String team, int points) {
    // Get current points
    int currentTeamAPoints = _currentRoom.teamAPoints;
    int currentTeamBPoints = _currentRoom.teamBPoints;
    
    // Calculate new points
    if (team == 'A') {
      currentTeamAPoints += points;
      if (currentTeamAPoints < 0) currentTeamAPoints = 0;
    } else {
      currentTeamBPoints += points;
      if (currentTeamBPoints < 0) currentTeamBPoints = 0;
    }
    
    // Update the room
    _currentRoom.updatePoints(currentTeamAPoints, currentTeamBPoints);
    
    // Refresh UI
    setState(() {});
    
    // Call the callback to notify parent
    widget.onPointsAdjust(points);
    
    print('Team $team: ${points > 0 ? '+' : ''}$points points');
  }

  void _awardPoints(String team, int points) {
    // Direct points award (for correct answers)
    _adjustPoints(team, points);
  }

  void _handlePowerCard(String card) {
    widget.onPowerCardUsed(card);

    // Show feedback based on card type
    final cardEffects = {
      'Double Points': 'Next correct answer will be worth double points!',
      'Steal Points': 'Steal 2 points from the other team!',
      'Reverse Turn': 'Question goes to the other team!',
      'Skip Round': 'Skipping to next question!',
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(cardEffects[card] ?? '$card activated!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with collapse functionality
              _buildHeader(),

              const SizedBox(height: 16),

              // Game State Section
              _buildGameStateSection(),

              const SizedBox(height: 16),

              // Timer Control Section
              _buildTimerSection(),

              const SizedBox(height: 16),

              // Points Control Section
              _buildPointsSection(),

              const SizedBox(height: 16),

              // Voting & Answer Section
              _buildVotingSection(),

              const SizedBox(height: 16),

              // Question Control Section
              _buildQuestionControls(),

              const SizedBox(height: 16),

              // Power Cards Section
              _buildPowerCardsSection(),

              const SizedBox(height: 16),

              // Game Controls
              _buildGameControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.admin_panel_settings,
            color: Color(0xFFCE1126), size: 24),
        const SizedBox(width: 8),
        const Text(
          'Host Controls',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFCE1126),
          ),
        ),
        const Spacer(),
        Badge(
          backgroundColor: const Color(0xFFCE1126),
          label:
              Text('${_currentRoom.teamA.length + _currentRoom.teamB.length}'),
          child: const Icon(Icons.people, size: 20),
        ),
      ],
    );
  }

  Widget _buildGameStateSection() {
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text('Room Code', style: TextStyle(fontSize: 12)),
                Text(_currentRoom.code,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                const Text('Game State', style: TextStyle(fontSize: 12)),
                Text(
                  _currentRoom.state.toString().split('.').last,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getStateColor(_currentRoom.state),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStateColor(GameState state) {
    switch (state) {
      case GameState.waiting:
        return Colors.orange;
      case GameState.inGame:
        return Colors.green;
      case GameState.roundComplete:
        return Colors.blue;
      case GameState.gameComplete:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildTimerSection() {
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Timer Control',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$_remainingTime',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _remainingTime <= 10 ? Colors.red : Color(0xFFCE1126),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isTimerRunning ? _stopTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isTimerRunning ? Colors.orange : Color(0xFF007A3D),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_isTimerRunning ? Icons.pause : Icons.play_arrow,
                          size: 20),
                      const SizedBox(width: 4),
                      Text(_isTimerRunning ? 'Pause' : 'Start'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, size: 20),
                      SizedBox(width: 4),
                      Text('Reset'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Quick Adjust:', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeAdjustButton(
                    '-10s', Icons.timer_off, () => _adjustTimer(-10)),
                _buildTimeAdjustButton(
                    '-5s', Icons.remove, () => _adjustTimer(-5)),
                _buildTimeAdjustButton('+5s', Icons.add, () => _adjustTimer(5)),
                _buildTimeAdjustButton(
                    '+10s', Icons.timer, () => _adjustTimer(10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeAdjustButton(
      String label, IconData icon, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          color: label.contains('-') ? Colors.red : Colors.green,
        ),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildPointsSection() {
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Points Control',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Team A Points
            _buildTeamPointsControl(
                'A', Color(0xFFCE1126), _currentRoom.teamAPoints),

            const SizedBox(height: 12),

            // Team B Points
            _buildTeamPointsControl(
                'B', Color(0xFF007A3D), _currentRoom.teamBPoints),

            const SizedBox(height: 8),

            // Quick Award Buttons
            const Text('Award Points:', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAwardButton('A', 1, 'Correct!'),
                _buildAwardButton('A', 2, 'Great!'),
                _buildAwardButton('B', 1, 'Correct!'),
                _buildAwardButton('B', 2, 'Great!'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamPointsControl(String team, Color color, int points) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Team $team',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$points',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${team == 'A' ? _currentRoom.teamA.length : _currentRoom.teamB.length} players',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            children: [
              _buildPointsButton(
                  Icons.add, Colors.green, () => _adjustPoints(team, 1)),
              const SizedBox(height: 4),
              _buildPointsButton(
                  Icons.remove, Colors.red, () => _adjustPoints(team, -1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointsButton(
      IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      width: 32,
      height: 32,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        color: color,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildAwardButton(String team, int points, String label) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          child: FloatingActionButton(
            onPressed: () => _awardPoints(team, points),
            backgroundColor:
                team == 'A' ? Color(0xFFCE1126) : Color(0xFF007A3D),
            foregroundColor: Colors.white,
            mini: true,
            child: Text('+$points', style: TextStyle(fontSize: 12)),
          ),
        ),
        const SizedBox(height: 2),
        Text(team, style: TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildVotingSection() {
    final totalVotesA = _currentRoom.getTotalVotesForTeam('A');
    final totalVotesB = _currentRoom.getTotalVotesForTeam('B');

    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Voting Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Team A Votes', style: TextStyle(fontSize: 12)),
                    Text('$totalVotesA',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Team B Votes', style: TextStyle(fontSize: 12)),
                    Text('$totalVotesB',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: widget.onStartVoting,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Start Voting'),
                ),
                ElevatedButton(
                  onPressed: widget.onRevealAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reveal Answer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionControls() {
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Question Controls',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.onNextQuestion,
                    icon: const Icon(Icons.navigate_next, size: 20),
                    label: const Text('Next Question'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF007A3D),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.onSkipQuestion,
                    icon: const Icon(Icons.skip_next, size: 20),
                    label: const Text('Skip'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPowerCardsSection() {
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Power Cards',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                _buildPowerCardButton('Double Points', Icons.attach_money,
                    Colors.amber, 'Double next points'),
                _buildPowerCardButton('Steal Points', Icons.currency_exchange,
                    Colors.purple, 'Steal 2 points'),
                _buildPowerCardButton('Reverse Turn', Icons.swap_horiz,
                    Colors.blue, 'Reverse question'),
                _buildPowerCardButton('Skip Round', Icons.fast_forward,
                    Colors.orange, 'Skip question'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPowerCardButton(
      String title, IconData icon, Color color, String description) {
    return Tooltip(
      message: description,
      child: ElevatedButton(
        onPressed: () => _handlePowerCard(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameControls() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _showEndGameConfirmation,
            icon: const Icon(Icons.stop, size: 20),
            label: const Text('End Game'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  void _showEndGameConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Game?'),
        content: const Text(
            'Are you sure you want to end the current game? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onEndGame();
            },
            child: const Text('End Game', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}