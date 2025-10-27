import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String winningTeam;
  final int teamAScore;
  final int teamBScore;

  const ResultsScreen({
    super.key,
    required this.winningTeam,
    required this.teamAScore,
    required this.teamBScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // HEADER
              const Text(
                '🏆 RESULTS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 40),

              // WINNER ANNOUNCEMENT
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF59E0B), width: 3),
                ),
                child: Column(
                  children: [
                    Text(
                      '$winningTeam WINS! 🎉',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF92400E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Icon(
                      Icons.celebration,
                      size: 60,
                      color: Color(0xFFD97706),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // FINAL SCORES
              const Text(
                'Final Scores:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildScoreRow('Team A', teamAScore, winningTeam == 'Team A'),
                    const SizedBox(height: 12),
                    _buildScoreRow('Team B', teamBScore, winningTeam == 'Team B'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // MVP SECTION
              const Text(
                '🏅 MVP Players',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 16),
              _buildMVPPlayer('Player 1', 120),
              const SizedBox(height: 8),
              _buildMVPPlayer('Player 2', 110),
              const SizedBox(height: 8),
              _buildMVPPlayer('Player 3', 95),

              const Spacer(),

              // ACTION BUTTONS
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Play Again pressed');
                        // This will go back to gameplay
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'PLAY AGAIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        print('New Lobby pressed');
                        // This will go back to lobby
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Color(0xFF4F46E5)),
                      ),
                      child: const Text(
                        'NEW LOBBY',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreRow(String teamName, int score, bool isWinner) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isWinner ? const Color(0xFFDCFCE7) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isWinner ? const Color(0xFF22C55E) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            teamName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isWinner ? const Color(0xFF166534) : const Color(0xFF2D3748),
            ),
          ),
          Text(
            '$score points',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isWinner ? const Color(0xFF166534) : const Color(0xFF4F46E5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMVPPlayer(String playerName, int points) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events, color: Color(0xFFF59E0B), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              playerName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
          Text(
            '$points pts',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F46E5),
            ),
          ),
        ],
      ),
    );
  }
}