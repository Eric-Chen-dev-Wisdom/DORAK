import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import '../services/firebase_service.dart';

class ResultScreen extends StatelessWidget {
  final GameRoom room;
  final UserModel? user;
  const ResultScreen({super.key, required this.room, this.user});

  @override
  Widget build(BuildContext context) {
    final fs = FirebaseService();
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: fs.getRoomStream(room.code),
      builder: (context, snap) {
        int a = room.teamAPoints;
        int b = room.teamBPoints;
        List<dynamic> teamA = room.teamA;
        List<dynamic> teamB = room.teamB;
        if (snap.hasData && snap.data!.data() != null) {
          final data = snap.data!.data()!;
          final scores = data['scores'] as Map<String, dynamic>?;
          if (scores != null) {
            a = (scores['teamA'] as num?)?.toInt() ?? a;
            b = (scores['teamB'] as num?)?.toInt() ?? b;
          }
          try {
            final parsed = GameRoom.fromJson(data);
            teamA = parsed.teamA;
            teamB = parsed.teamB;
          } catch (_) {}
        }

        final teamAWon = a > b;
        final teamBWon = b > a;
        final isTie = a == b;

        // Determine user's team robustly: try id, then fallback to displayName for host
        String? idOf(dynamic u) {
          try {
            if (u is Map) return u['id'] as String?;
            return (u as dynamic).id as String?;
          } catch (_) {
            return null;
          }
        }

        String nameOf(dynamic u) {
          try {
            if (u is Map) return (u['displayName'] as String?) ?? '';
            return (u as dynamic).displayName as String? ?? '';
          } catch (_) {
            return '';
          }
        }

        bool inA = teamA.any((u) => idOf(u) == user?.id);
        bool inB = teamB.any((u) => idOf(u) == user?.id);
        if (!inA && !inB && user?.id == room.hostId) {
          // Host may have been stored with a guest id initially; match by name.
          inA = teamA.any((u) => nameOf(u) == user?.displayName);
          inB = teamB.any((u) => nameOf(u) == user?.displayName);
        }
        final isUserTeamA = inA && !inB ? true : (!inA && inB ? false : true);
        final userWon = isTie ? false : (isUserTeamA ? teamAWon : teamBWon);
        final bannerImage =
            userWon ? 'assets/images/winner.png' : 'assets/images/loser.png';

        return Scaffold(
          backgroundColor: AppConstants.backgroundColor,
          appBar: AppBar(
            title: const Text('Game Results'),
            backgroundColor: const Color(0xFFCE1126),
          ),
          body: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  bannerImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(160, 0, 0, 0),
                        Color.fromARGB(40, 0, 0, 0),
                        Color(0x00FFFFFF),
                      ],
                    ),
                  ),
                ),
              ),
              // All content (Results) aligned to the bottom half
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: 0.55,
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          isTie
                              ? "It's a Tie!"
                              : teamAWon
                                  ? '🎉 Team A Wins!'
                                  : '🎉 Team B Wins!',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCE1126),
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 2,
                                offset: Offset(0.8, 0.8),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
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
                                _buildScoreRow('Team A', a, 0xFFCE1126),
                                _buildScoreRow('Team B', b, 0xFF007A3D),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              },
                              icon: const Icon(Icons.home),
                              label: const Text('Back to Home'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFCE1126),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Try Again'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007A3D),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
