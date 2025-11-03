import 'package:flutter/material.dart';
import '../models/room_model.dart';
import '../utils/constants.dart';

class ResultScreen extends StatelessWidget {
  final GameRoom room;

  const ResultScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final teamAWon = room.teamAPoints > room.teamBPoints;
    final teamBWon = room.teamBPoints > room.teamAPoints;
    final isTie = room.teamAPoints == room.teamBPoints;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Game Results'),
        backgroundColor: const Color(0xFFCE1126),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // 🏆 Title
            Text(
              isTie
                  ? 'It’s a Tie!'
                  : teamAWon
                      ? '🎉 Team A Wins!'
                      : '🎉 Team B Wins!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCE1126),
              ),
            ),
            const SizedBox(height: 30),

            // 🧮 Score Summary
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Final Scores',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    _buildScoreRow('Team A', room.teamAPoints, 0xFFCE1126),
                    _buildScoreRow('Team B', room.teamBPoints, 0xFF007A3D),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🧑‍🤝‍🧑 Player list
            Expanded(
              child: ListView(
                children: [
                  _buildTeamList('Team A', room.teamA, 0xFFCE1126),
                  const SizedBox(height: 20),
                  _buildTeamList('Team B', room.teamB, 0xFF007A3D),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🏁 Play again or exit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Back to Home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCE1126),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(String team, int score, int colorHex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            team,
            style: TextStyle(
              color: Color(colorHex),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '$score pts',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamList(String teamName, List<dynamic> members, int colorHex) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              teamName,
              style: TextStyle(
                color: Color(colorHex),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            for (var user in members)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 18, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(user.displayName ?? 'Unknown Player'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
