import 'dart:async'; // ADD THIS IMPORT
import 'package:flutter/material.dart';
import 'package:DORAK/l10n/app_localizations.dart'; // for localization
import '../models/room_model.dart';
import '../services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// No server time offset; rely on host-written timestamps

class HostControlPanel extends StatefulWidget {
  final GameRoom room;
  final Function(int) onPointsAdjust;
  final void Function(int seconds, bool running) onTimerAdjust;
  final Function() onNextQuestion;
  final Function() onSkipQuestion;
  final Function(String) onPowerCardUsed;
  final Function() onEndGame;
  final Function() onStartVoting;
  final Function() onRevealAnswer;
  final Function(String team, int points)? onPhysicalChallengeApprove;

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
    this.onPhysicalChallengeApprove,
  });

  @override
  State<HostControlPanel> createState() => _HostControlPanelState();
}

class _HostControlPanelState extends State<HostControlPanel> {
  static const String _cardDoublePoints = 'double_points';
  static const String _cardStealPoints = 'steal_points';
  static const String _cardReverseTurn = 'reverse_turn';
  static const String _cardSkipRound = 'skip_round';

  int _remainingTime = 60;
  bool _isTimerRunning = false;
  late GameRoom _currentRoom;
  Timer? _timer; // Add this to track the timer
  final FirebaseService _firebaseService = FirebaseService();
  StreamSubscription? _roomSub;
  int? _timerEndAtMs; // authoritative end time derived from Firestore
  int? _lastTimerStampMs;
  int? _lastServerTimer;
  bool? _lastRunning;
  int? _localStartAtMs; // guard against stale false snapshots right after start

  @override
  void initState() {
    super.initState();
    _currentRoom = widget.room;
    _remainingTime = _currentRoom.currentTimer;
    _isTimerRunning = _currentRoom.isTimerRunning;
    if (_isTimerRunning && _remainingTime == 0) {
      _remainingTime =
          60; // Default to 60 seconds if timer is running but time is 0
    }

    // Subscribe to room to mirror GameScreen's timer sync
    _roomSub = _firebaseService.getRoomStream(_currentRoom.code).listen((snap) {
      // Ignore local pending writes; wait for server-resolved data
      if (snap.metadata.hasPendingWrites) return;
      final data = snap.data();
      if (data == null) return;
      final room = GameRoom.fromJson(data); // Re-parse into a GameRoom object
      if (mounted) {
        setState(() {
          _currentRoom = room;
        });
      }
      // Debug timer payload (one line)
      try {
        final rawTs = data['timerUpdatedAt'];
        final ver = data['timerVersion'];
        final ctDbg = data['currentTimer'];
        final runDbg = data['isTimerRunning'];
        // ignore: avoid_print
        print(
            '[Timer][HP] pending=${snap.metadata.hasPendingWrites} cache=${snap.metadata.isFromCache} ver=$ver run=$runDbg ct=$ctDbg ts=$rawTs');
      } catch (_) {}
      final ct = room.currentTimer;
      final running = room.isTimerRunning;
      // Ignore transient snapshot where running is true but timer still 0
      if (running && (ct == 0)) return;
      // Ensure the server timestamp has resolved; skip if raw field is null
      if (data['timerUpdatedAt'] == null) return;
      final updatedAtRaw = data['timerUpdatedAt'];
      final updatedAtMs = updatedAtRaw is Timestamp
          ? updatedAtRaw.millisecondsSinceEpoch
          : (updatedAtRaw is String
              ? (DateTime.tryParse(updatedAtRaw)?.millisecondsSinceEpoch ??
                  DateTime.now().millisecondsSinceEpoch)
              : DateTime.now().millisecondsSinceEpoch);

      // Check for changes to avoid unnecessary setState calls
      final changed = _lastTimerStampMs != updatedAtMs ||
          _lastServerTimer != ct ||
          _lastRunning != running;
      if (!changed) return;

      _lastTimerStampMs = updatedAtMs;
      _lastServerTimer = ct;
      _lastRunning = running;

      // Reset _localStartAtMs after a few seconds to allow new stop signals
      if (_localStartAtMs != null &&
          DateTime.now().millisecondsSinceEpoch > _localStartAtMs! + 5000) {
        _localStartAtMs = null;
      }

      // Ignore stale false snapshot that predates local start IF we haven't reset _localStartAtMs
      if (!running &&
          _localStartAtMs != null &&
          updatedAtMs < _localStartAtMs!) {
        return;
      }

      setState(() {
        _isTimerRunning = running;
        _timerEndAtMs = running ? updatedAtMs + (ct * 1000) : null;
        if (running && _timerEndAtMs != null) {
          final nowMs = DateTime.now().millisecondsSinceEpoch;
          final rem = ((_timerEndAtMs! - nowMs) / 1000).ceil();
          // Ensure remaining time is reasonable - if calculation is way off, use server value
          if (rem > ct + 5 || rem < 0) {
            _remainingTime = ct;
          } else {
            _remainingTime = rem.clamp(0, ct + 5);
          }
        } else {
          _remainingTime = ct;
        }
      });

      if (running && _timerEndAtMs != null) {
        _startTimerCountdown();
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Important: cancel timer when widget disposes
    _roomSub?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isTimerRunning) return; // Prevent multiple starts

    setState(() {
      _isTimerRunning = true;
      if (_remainingTime == 0) _remainingTime = 60; // Ensure not 0 on start
      // Predict end-at immediately for smooth local UI
      final now = DateTime.now().millisecondsSinceEpoch;
      _localStartAtMs = now;
      _timerEndAtMs = now + (_remainingTime * 1000);
    });

    _startTimerCountdown();
    // Start voting when timer starts (synchronization fix)
    widget.onStartVoting();
  }

  void _startTimerCountdown() {
    // Cancel any existing timer first
    _timer?.cancel();

    // Do not run a local ticker when paused or without an end time
    if (_timerEndAtMs == null || !_isTimerRunning) {
      print(
          'HostControlPanel: _startTimerCountdown prevented. _timerEndAtMs: $_timerEndAtMs, _isTimerRunning: $_isTimerRunning');
      return;
    }

    // Create new timer (local UI only; avoid spamming network)
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Check if widget is still mounted
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_timerEndAtMs != null && _isTimerRunning) {
        final nowMs = DateTime.now().millisecondsSinceEpoch;
        final rem = ((_timerEndAtMs! - nowMs) / 1000).ceil();
        setState(() {
          _remainingTime = rem > 0 ? rem : 0;
        });
        if (rem <= 0) {
          setState(() {
            _isTimerRunning = false;
            _timerEndAtMs = null;
          });
          timer.cancel();
          // Do not push a stop here; GameScreen (host) will publish authoritative stop
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.timesUp)),
            );
          }
          return;
        }
      }

      // If we still have time and are running, nothing else to do; UI already updated from prediction
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
    _timer?.cancel(); // Cancel the timer
    _timerEndAtMs = null;
    _localStartAtMs = null; // Reset local start time on stop
    widget.onTimerAdjust(_remainingTime, false);
    // Safety write
    _firebaseService.setTimer(_currentRoom.code, _remainingTime,
        running: false);
  }

  void _resetTimer() {
    _timer?.cancel(); // Cancel any running timer
    setState(() {
      _remainingTime = 60;
      _isTimerRunning = false;
    });
    _timerEndAtMs = null;
    _localStartAtMs = null; // Reset local start time on reset
    widget.onTimerAdjust(_remainingTime, false);
    // Safety write
    _firebaseService.setTimer(_currentRoom.code, _remainingTime,
        running: false);
  }

  void _adjustTimer(int seconds) {
    final wasRunning = _isTimerRunning;
    setState(() {
      _remainingTime += seconds;
      if (_remainingTime < 5) _remainingTime = 5; // Minimum 5 seconds
      if (_remainingTime > 300) _remainingTime = 300; // Maximum 5 minutes

      if (wasRunning) {
        // Keep running and just jump to the new remaining time
        // Restart local countdown to ensure cadence is clean
        _timer?.cancel();
        _timerEndAtMs =
            DateTime.now().millisecondsSinceEpoch + (_remainingTime * 1000);
        _startTimerCountdown();
      } else {
        // Stay paused; do not start the timer
        _isTimerRunning = false;
        _timerEndAtMs = null;
      }
    });

    // Single push to sync new remaining time across clients
    widget.onTimerAdjust(_remainingTime, wasRunning);
    // Safety write
    _firebaseService.setTimer(_currentRoom.code, _remainingTime,
        running: wasRunning);
  }

  Future<void> _adjustPoints(String team, int points) async {
    final previousTeamAPoints = _currentRoom.teamAPoints;
    final previousTeamBPoints = _currentRoom.teamBPoints;

    int currentTeamAPoints = previousTeamAPoints;
    int currentTeamBPoints = previousTeamBPoints;

    if (team == 'A') {
      currentTeamAPoints += points;
      if (currentTeamAPoints < 0) currentTeamAPoints = 0;
    } else {
      currentTeamBPoints += points;
      if (currentTeamBPoints < 0) currentTeamBPoints = 0;
    }

    setState(() {
      _currentRoom = _currentRoom.copyWith(scores: {
        'teamA': currentTeamAPoints,
        'teamB': currentTeamBPoints,
      });
    });

    widget.onPointsAdjust(points);

    final pointsLabel = AppLocalizations.of(context)?.points ?? 'points';

    try {
      await _firebaseService.updateTeamPoints(
        _currentRoom.code,
        currentTeamAPoints,
        currentTeamBPoints,
      );
      // ignore: avoid_print
      print('Team $team: ${points > 0 ? '+' : ''}$points $pointsLabel');
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _currentRoom = _currentRoom.copyWith(scores: {
          'teamA': previousTeamAPoints,
          'teamB': previousTeamBPoints,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to update points. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _awardPoints(String team, int points) {
    _adjustPoints(team, points);
  }

  bool _isPowerCardUsed(String cardId) {
    return _currentRoom.usedPowerCards.contains(cardId);
  }

  String _powerCardTitle(String cardId, AppLocalizations l10n) {
    switch (cardId) {
      case _cardDoublePoints:
        return l10n.doublePoints;
      case _cardStealPoints:
        return l10n.stealPoints;
      case _cardReverseTurn:
        return l10n.reverseTurn;
      case _cardSkipRound:
        return l10n.skipRound;
      default:
        return cardId;
    }
  }

  Future<void> _handlePowerCard(String cardId) async {
    if (_isPowerCardUsed(cardId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Power card already used.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    final title = _powerCardTitle(cardId, l10n);

    // Apply power card effect BEFORE marking as used
    await _applyPowerCardEffect(cardId, l10n);

    widget.onPowerCardUsed(cardId);

    final previousCards = List<String>.from(_currentRoom.usedPowerCards);
    final updatedCards = List<String>.from(previousCards)..add(cardId);

    setState(() {
      _currentRoom = _currentRoom.copyWith(usedPowerCards: updatedCards);
    });

    final cardEffects = {
      _cardDoublePoints: l10n.doublePointsEffect,
      _cardStealPoints: l10n.stealPointsEffect,
      _cardReverseTurn: l10n.reverseTurnEffect,
      _cardSkipRound: l10n.skipRoundEffect,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(cardEffects[cardId] ?? '$title ${l10n.activated}!'),
        backgroundColor: Colors.purple,
        duration: const Duration(seconds: 3),
      ),
    );

    try {
      await _firebaseService.activatePowerCard(
        _currentRoom.code,
        cardId,
      );
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _currentRoom = _currentRoom.copyWith(usedPowerCards: previousCards);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sync power card. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Apply the actual effect of each power card
  Future<void> _applyPowerCardEffect(
      String cardId, AppLocalizations l10n) async {
    switch (cardId) {
      case _cardDoublePoints:
        // Double the points for the next correct answer
        // This is tracked by the card being in usedPowerCards
        // The game logic should check this when awarding points
        break;

      case _cardStealPoints:
        // Steal 2 points from the other team
        // Show dialog to choose which team steals from which
        final result = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.stealPoints),
            content:
                const Text('Which team steals 2 points from the other team?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'A'),
                child: Text('${l10n.teamA} steals from ${l10n.teamB}'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'B'),
                child: Text('${l10n.teamB} steals from ${l10n.teamA}'),
              ),
            ],
          ),
        );

        if (result != null) {
          if (result == 'A') {
            // Team A steals 2 points from Team B
            await _adjustPoints('A', 2);
            await _adjustPoints('B', -2);
          } else {
            // Team B steals 2 points from Team A
            await _adjustPoints('B', 2);
            await _adjustPoints('A', -2);
          }
        }
        break;

      case _cardReverseTurn:
        // This would swap which team answers - implementation depends on game flow
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.reverseTurnEffect),
            backgroundColor: Colors.blue,
          ),
        );
        break;

      case _cardSkipRound:
        // Skip to next question
        widget.onSkipQuestion();
        break;

      default:
        break;
    }
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
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        const Icon(Icons.admin_panel_settings,
            color: Color(0xFFCE1126), size: 24),
        const SizedBox(width: 8),
        Text(
          l10n.hostControls,
          style: const TextStyle(
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
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(l10n.roomCode, style: const TextStyle(fontSize: 12)),
                Text(_currentRoom.code,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text(l10n.gameState, style: const TextStyle(fontSize: 12)),
                Text(
                  _localizedGameState(_currentRoom.state),
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

  String _localizedGameState(GameState state) {
    final l10n = AppLocalizations.of(context)!;
    switch (state) {
      case GameState.waiting:
        return l10n.waiting;
      case GameState.inGame:
        return l10n.inGame;
      case GameState.roundComplete:
        return l10n.roundComplete;
      case GameState.gameComplete:
        return l10n.gameComplete;
      default:
        return '';
    }
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
    final l10n = AppLocalizations.of(context)!;
    // Sync indicator similar to GameScreen
    Color syncColor;
    if (!_isTimerRunning) {
      syncColor = Colors.grey;
    } else if (_timerEndAtMs != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final pred = ((_timerEndAtMs! - now) / 1000).ceil();
      final delta = (pred - _remainingTime).abs();
      syncColor = delta <= 1 ? Colors.green : Colors.redAccent;
    } else {
      syncColor = Colors.amber; // waiting for end-time
    }
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              l10n.timerControl,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 4),
            Container(
              width: 10,
              height: 10,
              decoration:
                  BoxDecoration(color: syncColor, shape: BoxShape.circle),
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
                      Text(_isTimerRunning ? l10n.pause : l10n.start),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.refresh, size: 20),
                      const SizedBox(width: 4),
                      Text(l10n.reset),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(l10n.quickAdjust, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeAdjustButton('-10s', Icons.timer_off,
                    () => _adjustTimer(-10), l10n.minus10s),
                _buildTimeAdjustButton(
                    '-5s', Icons.remove, () => _adjustTimer(-5), l10n.minus5s),
                _buildTimeAdjustButton(
                    '+5s', Icons.add, () => _adjustTimer(5), l10n.plus5s),
                _buildTimeAdjustButton(
                    '+10s', Icons.timer, () => _adjustTimer(10), l10n.plus10s),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeAdjustButton(
      String label, IconData icon, VoidCallback onPressed,
      [String? localizedLabel]) {
    // Allow fallback to label if no translation key provided.
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          color: label.contains('-') ? Colors.red : Colors.green,
        ),
        Text(localizedLabel ?? label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildPointsSection() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              l10n.pointsControl,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            Text(l10n.awardPoints, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAwardButton('A', 1, l10n.correct),
                _buildAwardButton('A', 2, l10n.great),
                _buildAwardButton('B', 1, l10n.correct),
                _buildAwardButton('B', 2, l10n.great),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamPointsControl(String team, Color color, int points) {
    final l10n = AppLocalizations.of(context)!;
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
                  '${l10n.team} $team',
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
                  '${team == 'A' ? _currentRoom.teamA.length : _currentRoom.teamB.length} ${l10n.players}',
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
      IconData icon, Color color, Future<void> Function() onPressed) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        onPressed: () {
          onPressed();
        },
        icon: Icon(icon, size: 16),
        color: color,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildAwardButton(String team, int points, String label) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(
          width: 36,
          height: 36,
          child: FloatingActionButton(
            onPressed: () {
              _awardPoints(team, points);
            },
            backgroundColor:
                team == 'A' ? Color(0xFFCE1126) : Color(0xFF007A3D),
            foregroundColor: Colors.white,
            mini: true,
            child: Text('+$points', style: const TextStyle(fontSize: 12)),
          ),
        ),
        const SizedBox(height: 2),
        Text('${l10n.team} $team', style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildVotingSection() {
    final l10n = AppLocalizations.of(context)!;
    final totalVotesA = _currentRoom.getTotalVotesForTeam('A');
    final totalVotesB = _currentRoom.getTotalVotesForTeam('B');

    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              l10n.votingStatus,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('${l10n.teamA} ${l10n.votes}',
                        style: const TextStyle(fontSize: 12)),
                    Text('$totalVotesA',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Text('${l10n.teamB} ${l10n.votes}',
                        style: const TextStyle(fontSize: 12)),
                    Text('$totalVotesB',
                        style: const TextStyle(
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
                  child: Text(l10n.startVoting),
                ),
                ElevatedButton(
                  onPressed: widget.onRevealAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(l10n.revealAnswer),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Jackpot toggle
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _toggleJackpot,
                icon: Icon(
                  _currentRoom.isJackpotQuestion
                      ? Icons.star
                      : Icons.star_outline,
                  color: Colors.amber,
                ),
                label: Text(
                  _currentRoom.isJackpotQuestion
                      ? '🎁 Jackpot Active! (${_currentRoom.jackpotPoints ?? "?"}pts)'
                      : '🎁 Enable Jackpot',
                  style: TextStyle(
                    fontWeight: _currentRoom.isJackpotQuestion
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.amber[800],
                  side: BorderSide(
                    color: _currentRoom.isJackpotQuestion
                        ? Colors.amber
                        : Colors.grey,
                    width: _currentRoom.isJackpotQuestion ? 2 : 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionControls() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              l10n.questionControls,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.onNextQuestion,
                    icon: const Icon(Icons.navigate_next, size: 20),
                    label: Text(l10n.nextQuestion),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF007A3D),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showPhysicalChallengeApproval,
                    icon: const Icon(Icons.sports_martial_arts, size: 20),
                    label: const Text('Approve Challenge'),
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
  
  void _showPhysicalChallengeApproval() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.sports_martial_arts, color: Colors.orange),
            SizedBox(width: 8),
            Text('💪 Physical Challenge'),
          ],
        ),
        content: const Text(
          'Which team successfully completed the challenge?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _approvePhysicalChallenge('A');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCE1126),
            ),
            child: Text('${l10n.teamA} ✅'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _approvePhysicalChallenge('B');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007A3D),
            ),
            child: Text('${l10n.teamB} ✅'),
          ),
        ],
      ),
    );
  }
  
  Future<void> _approvePhysicalChallenge(String winningTeam) async {
    final l10n = AppLocalizations.of(context)!;
    
    // Award points based on current room difficulty setting
    // For physical challenges, use 100 pts as base
    final basePoints = 100;
    final teamSize = winningTeam == 'A' 
        ? _currentRoom.teamA.length 
        : _currentRoom.teamB.length;
    final totalPoints = basePoints * teamSize;
    
    // Mark as approved in Firebase so all players see it
    await _firebaseService.updateRoomField(
      _currentRoom.code,
      'physicalChallengeApproved',
      winningTeam,
    );
    
    // Call parent callback if provided
    if (widget.onPhysicalChallengeApprove != null) {
      widget.onPhysicalChallengeApprove!(winningTeam, totalPoints);
    } else {
      // Fallback: adjust points directly
      await _adjustPoints(winningTeam, totalPoints);
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ ${l10n.team} $winningTeam completed challenge! +$totalPoints pts ($basePoints × $teamSize players)',
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildPowerCardsSection() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              l10n.powerCards,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                _buildPowerCardButton(
                  _cardDoublePoints,
                  l10n.doublePoints,
                  Icons.attach_money,
                  Colors.amber,
                  l10n.doubleNextPoints,
                  _isPowerCardUsed(_cardDoublePoints),
                ),
                _buildPowerCardButton(
                  _cardStealPoints,
                  l10n.stealPoints,
                  Icons.currency_exchange,
                  Colors.purple,
                  l10n.steal2Points,
                  _isPowerCardUsed(_cardStealPoints),
                ),
                _buildPowerCardButton(
                  _cardReverseTurn,
                  l10n.reverseTurn,
                  Icons.swap_horiz,
                  Colors.blue,
                  l10n.reverseQuestion,
                  _isPowerCardUsed(_cardReverseTurn),
                ),
                _buildPowerCardButton(
                  _cardSkipRound,
                  l10n.skipRound,
                  Icons.fast_forward,
                  Colors.orange,
                  l10n.skipQuestion,
                  _isPowerCardUsed(_cardSkipRound),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPowerCardButton(
    String cardId,
    String title,
    IconData icon,
    Color color,
    String description,
    bool used,
  ) {
    return Tooltip(
      message: description,
      child: ElevatedButton(
        onPressed: used ? null : () => _handlePowerCard(cardId),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              used ? Colors.grey.withOpacity(0.2) : color.withOpacity(0.1),
          foregroundColor: used ? Colors.grey : color,
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
                used ? '$title ✓' : title,
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
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _showEndGameConfirmation,
            icon: const Icon(Icons.stop, size: 20),
            label: Text(l10n.endGame),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.endGameQ), // "End Game?"
        content: Text(l10n
            .endGameWarning), // "Are you sure you want to end the current game? This cannot be undone."
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onEndGame();
            },
            child:
                Text(l10n.endGame, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _toggleJackpot() async {
    final l10n = AppLocalizations.of(context)!;

    if (_currentRoom.isJackpotQuestion) {
      // Disable jackpot
      await _firebaseService.updateRoomField(
        _currentRoom.code,
        'isJackpotQuestion',
        false,
      );
      setState(() {
        _currentRoom = _currentRoom.copyWith(
          isJackpotQuestion: false,
          jackpotPoints: null,
          jackpotAccepted: false,
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎁 Jackpot disabled'),
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Enable jackpot with random points
      final jackpotValue =
          200 + (DateTime.now().millisecondsSinceEpoch % 401); // Random 200-600

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  '🎁 Jackpot Question',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enable Jackpot for this question?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('✅', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Correct answer = +$jackpotValue points',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('❌', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Wrong answer = -$jackpotValue points',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Teams must accept the risk!',
                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _enableJackpot(jackpotValue);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
              child: const Text('Enable Jackpot'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _enableJackpot(int points) async {
    await _firebaseService.updateRoomField(
      _currentRoom.code,
      'isJackpotQuestion',
      true,
    );
    await _firebaseService.updateRoomField(
      _currentRoom.code,
      'jackpotPoints',
      points,
    );
    await _firebaseService.updateRoomField(
      _currentRoom.code,
      'jackpotAccepted',
      false, // Teams haven't accepted yet
    );

    setState(() {
      _currentRoom = _currentRoom.copyWith(
        isJackpotQuestion: true,
        jackpotPoints: points,
        jackpotAccepted: false,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎁 Jackpot enabled! Worth $points points!'),
        backgroundColor: Colors.amber,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
