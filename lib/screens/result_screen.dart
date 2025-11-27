import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import '../services/firebase_service.dart';
import 'package:DORAK/l10n/app_localizations.dart';
import 'match_history_screen.dart';

class ResultScreen extends StatelessWidget {
  final GameRoom room;
  final UserModel? user;
  const ResultScreen({super.key, required this.room, this.user});

  @override
  Widget build(BuildContext context) {
    final fs = FirebaseService();
    final loc = AppLocalizations.of(context)!;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: fs.getRoomStream(room.code),
      builder: (context, snap) {
        int a = room.teamAPoints;
        int b = room.teamBPoints;
        List<dynamic> teamA = room.teamA;
        List<dynamic> teamB = room.teamB;
        
        // Always get latest scores from Firebase stream
        if (snap.hasData && snap.data!.data() != null) {
          final data = snap.data!.data()!;
          
          // Debug: print raw scores
          print('🏆 Result Screen - Raw Firebase data: ${data['scores']}');
          
          final scores = data['scores'] as Map<String, dynamic>?;
          if (scores != null) {
            a = (scores['teamA'] as num?)?.toInt() ?? a;
            b = (scores['teamB'] as num?)?.toInt() ?? b;
            print('🏆 Result Screen - Parsed scores: A=$a, B=$b');
          }
          try {
            final parsed = GameRoom.fromJson(data);
            teamA = parsed.teamA;
            teamB = parsed.teamB;
            // Also update scores from parsed room to ensure we have latest
            a = parsed.teamAPoints;
            b = parsed.teamBPoints;
            print('🏆 Result Screen - From parsed room: A=$a, B=$b');
          } catch (e) {
            print('❌ Error parsing room in results: $e');
          }
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
            userWon ? loc.winnerBannerPath : loc.loserBannerPath;

        return Scaffold(
          backgroundColor: AppConstants.backgroundColor,
          appBar: AppBar(
            title: Text(loc.gameResultsTitle),
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
                  heightFactor: 0.6,
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            isTie
                                ? loc.itsATie
                                : teamAWon
                                    ? loc.teamAWins
                                    : loc.teamBWins,
                            style: const TextStyle(
                              fontSize: 26,
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
                          const SizedBox(height: 20),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  loc.finalScores,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(),
                                _buildScoreRow(
                                    context, loc.teamA, a, 0xFFCE1126),
                                _buildScoreRow(
                                    context, loc.teamB, b, 0xFF007A3D),
                              ],
                            ),
                          ),
                        ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.popUntil(
                                            context, (route) => route.isFirst);
                                      },
                                      icon: const Icon(Icons.home, size: 20),
                                      label: Text(loc.backToHome),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFCE1126),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // Navigate to lobby for all players (host and non-host)
                                        Navigator.popUntil(context, (route) => route.isFirst);
                                        Navigator.pushNamed(
                                          context,
                                          '/lobby',
                                          arguments: user,
                                        );
                                      },
                                      icon: const Icon(Icons.refresh, size: 20),
                                      label: Text(loc.tryAgain),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF007A3D),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MatchHistoryScreen(roomCode: room.code),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.history, size: 20),
                                label: Text(loc.viewMatchHistory),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFCE1126),
                                  side: const BorderSide(color: Color(0xFFCE1126)),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ],
                          ),
                        ],
                      ),
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

  Widget _buildScoreRow(
      BuildContext context, String team, int score, int colorHex) {
    final loc = AppLocalizations.of(context)!;
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
            loc.pointsAbbreviation(score),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

}
