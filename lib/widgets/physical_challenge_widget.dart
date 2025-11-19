import 'package:flutter/material.dart';
import 'dart:async';
import '../services/physical_challenge_service.dart';

class PhysicalChallengeWidget extends StatefulWidget {
  final String challengeType; // 'shake', 'tilt', 'verbal'
  final String description;
  final Function() onChallengeComplete;
  final int timeLimit; // seconds

  const PhysicalChallengeWidget({
    super.key,
    required this.challengeType,
    required this.description,
    required this.onChallengeComplete,
    this.timeLimit = 20,
  });

  @override
  State<PhysicalChallengeWidget> createState() =>
      _PhysicalChallengeWidgetState();
}

class _PhysicalChallengeWidgetState extends State<PhysicalChallengeWidget>
    with SingleTickerProviderStateMixin {
  final PhysicalChallengeService _sensorService = PhysicalChallengeService();
  bool _challengeStarted = false;
  bool _challengeCompleted = false;
  int _remainingTime = 0;
  Timer? _countdownTimer;
  late AnimationController _pulseController;
  String _currentInstruction = '';

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.timeLimit;
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _sensorService.dispose();
    _countdownTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startChallenge() {
    setState(() {
      _challengeStarted = true;
      _remainingTime = widget.timeLimit;
    });

    // Start countdown
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      if (_remainingTime <= 0) {
        timer.cancel();
        _failChallenge();
      }
    });

    // Start appropriate sensor detection
    switch (widget.challengeType.toLowerCase()) {
      case 'shake':
        _currentInstruction = 'Shake your phone vigorously!';
        _sensorService.startShakeDetection(
          onShakeDetected: _completeChallenge,
          requiredShakes: 5,
        );
        break;

      case 'tilt':
        _currentInstruction = 'Tilt your phone left, right, forward, backward!';
        int tilts = 0;
        _sensorService.startTiltDetection(
          onTiltDetected: (direction) {
            tilts++;
            setState(() {
              _currentInstruction = 'Tilt detected: $direction ($tilts/4)';
            });
            if (tilts >= 4) {
              _completeChallenge();
            }
          },
        );
        break;

      case 'verbal':
      default:
        _currentInstruction = widget.description;
        // Verbal challenges are manually completed by host
        break;
    }
  }

  void _completeChallenge() {
    if (_challengeCompleted) return;

    setState(() {
      _challengeCompleted = true;
      _currentInstruction = '✅ Challenge Complete!';
    });

    _countdownTimer?.cancel();
    _sensorService.dispose();

    // Notify parent
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        widget.onChallengeComplete();
      }
    });
  }

  void _failChallenge() {
    if (_challengeCompleted) return;

    setState(() {
      _currentInstruction = '❌ Time\'s up!';
    });

    _sensorService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade600,
              Colors.deepOrange.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Challenge icon
            ScaleTransition(
              scale: Tween(begin: 0.9, end: 1.1).animate(_pulseController),
              child: Icon(
                _getChallengeIcon(),
                size: 80,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Challenge title
            Text(
              '💪 PHYSICAL CHALLENGE!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            if (_challengeStarted) ...[
              // Live instruction
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _currentInstruction,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // Timer
              Text(
                '$_remainingTime',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'seconds left',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ] else ...[
              // Start button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startChallenge,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'START CHALLENGE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getChallengeIcon() {
    switch (widget.challengeType.toLowerCase()) {
      case 'shake':
        return Icons.vibration;
      case 'tilt':
        return Icons.screen_rotation;
      case 'verbal':
        return Icons.record_voice_over;
      default:
        return Icons.sports_martial_arts;
    }
  }
}
