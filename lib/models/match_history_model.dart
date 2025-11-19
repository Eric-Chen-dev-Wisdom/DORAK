import 'package:cloud_firestore/cloud_firestore.dart';

class MatchHistory {
  final String id;
  final String roomCode;
  final DateTime completedAt;
  final int teamAScore;
  final int teamBScore;
  final String winner; // 'A', 'B', or 'tie'
  final List<String> teamAPlayerNames;
  final List<String> teamBPlayerNames;
  final List<String> categories;
  final int totalQuestions;
  final int duration; // in seconds
  final Map<String, dynamic> bonusStats; // Track bonuses earned

  MatchHistory({
    required this.id,
    required this.roomCode,
    required this.completedAt,
    required this.teamAScore,
    required this.teamBScore,
    required this.winner,
    required this.teamAPlayerNames,
    required this.teamBPlayerNames,
    required this.categories,
    required this.totalQuestions,
    required this.duration,
    required this.bonusStats,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomCode': roomCode,
      'completedAt': completedAt.toIso8601String(),
      'teamAScore': teamAScore,
      'teamBScore': teamBScore,
      'winner': winner,
      'teamAPlayerNames': teamAPlayerNames,
      'teamBPlayerNames': teamBPlayerNames,
      'categories': categories,
      'totalQuestions': totalQuestions,
      'duration': duration,
      'bonusStats': bonusStats,
    };
  }

  factory MatchHistory.fromJson(Map<String, dynamic> json) {
    return MatchHistory(
      id: json['id'] ?? '',
      roomCode: json['roomCode'] ?? '',
      completedAt: json['completedAt'] is Timestamp
          ? (json['completedAt'] as Timestamp).toDate()
          : DateTime.tryParse(json['completedAt'] ?? '') ?? DateTime.now(),
      teamAScore: (json['teamAScore'] as num?)?.toInt() ?? 0,
      teamBScore: (json['teamBScore'] as num?)?.toInt() ?? 0,
      winner: json['winner'] ?? 'tie',
      teamAPlayerNames: List<String>.from(json['teamAPlayerNames'] ?? []),
      teamBPlayerNames: List<String>.from(json['teamBPlayerNames'] ?? []),
      categories: List<String>.from(json['categories'] ?? []),
      totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      bonusStats: Map<String, dynamic>.from(json['bonusStats'] ?? {}),
    );
  }
}
