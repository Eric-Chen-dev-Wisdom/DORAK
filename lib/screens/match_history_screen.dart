import 'package:flutter/material.dart';
import '../models/match_history_model.dart';
import '../services/firebase_service.dart';
import '../utils/constants.dart';
import 'package:DORAK/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class MatchHistoryScreen extends StatelessWidget {
  final String? roomCode;

  const MatchHistoryScreen({super.key, this.roomCode});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final fs = FirebaseService();

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(roomCode != null ? 'Room $roomCode History' : 'Match History'),
        backgroundColor: AppConstants.primaryRed,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadMatches(fs, roomCode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final matches = snapshot.data ?? [];

          if (matches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'No match history yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Play some games to see history!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = MatchHistory.fromJson(matches[index]);
              return _buildMatchCard(context, match, loc);
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _loadMatches(
      FirebaseService fs, String? roomCode) async {
    if (roomCode != null) {
      // Load matches for specific room code - use list method instead of stream to avoid index requirement during build
      return await fs.getMatchHistoryList(roomCode);
    } else {
      // Load recent matches
      return await fs.getRecentMatches(limit: 20);
    }
  }

  Widget _buildMatchCard(
      BuildContext context, MatchHistory match, AppLocalizations loc) {
    final isTeamAWinner = match.winner == 'A';
    final isTeamBWinner = match.winner == 'B';
    final isTie = match.winner == 'tie';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with room code and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Room: ${match.roomCode}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryRed,
                    ),
                  ),
                ),
                Text(
                  DateFormat('MMM d, y • HH:mm').format(match.completedAt),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Winner announcement
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isTie ? Icons.handshake : Icons.emoji_events,
                  color: isTie
                      ? Colors.grey
                      : (isTeamAWinner
                          ? AppConstants.primaryRed
                          : AppConstants.primaryGreen),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  isTie
                      ? 'IT\'S A TIE!'
                      : isTeamAWinner
                          ? 'TEAM A WINS!'
                          : 'TEAM B WINS!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isTie
                        ? Colors.grey
                        : (isTeamAWinner
                            ? AppConstants.primaryRed
                            : AppConstants.primaryGreen),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Scores
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTeamScore(
                    'Team A',
                    match.teamAScore,
                    AppConstants.primaryRed,
                    isTeamAWinner,
                  ),
                  Container(
                    width: 2,
                    height: 40,
                    color: Colors.grey[300],
                  ),
                  _buildTeamScore(
                    'Team B',
                    match.teamBScore,
                    AppConstants.primaryGreen,
                    isTeamBWinner,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Game details
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildDetailChip(
                  Icons.quiz,
                  '${match.totalQuestions} Questions',
                  Colors.blue,
                ),
                _buildDetailChip(
                  Icons.timer,
                  '${_formatDuration(match.duration)}',
                  Colors.orange,
                ),
                _buildDetailChip(
                  Icons.category,
                  '${match.categories.length} Categories',
                  Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Categories
            if (match.categories.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: match.categories
                    .map((cat) => Chip(
                          label: Text(
                            cat,
                            style: const TextStyle(fontSize: 11),
                          ),
                          backgroundColor: Colors.grey[200],
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ))
                    .toList(),
              ),

            const SizedBox(height: 12),

            // Players
            Row(
              children: [
                Expanded(
                  child: _buildPlayerList(
                    'Team A',
                    match.teamAPlayerNames,
                    AppConstants.primaryRed,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPlayerList(
                    'Team B',
                    match.teamBPlayerNames,
                    AppConstants.primaryGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamScore(
      String team, int score, Color color, bool isWinner) {
    return Column(
      children: [
        Text(
          team,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$score',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isWinner ? color : Colors.grey,
          ),
        ),
        if (isWinner)
          const Icon(Icons.emoji_events, color: Colors.amber, size: 20),
      ],
    );
  }

  Widget _buildDetailChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerList(String teamName, List<String> players, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teamName,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          ...players.map((name) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 14, color: color),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes > 0) {
      return '${minutes}m ${secs}s';
    }
    return '${secs}s';
  }
}


