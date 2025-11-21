import 'package:cloud_firestore/cloud_firestore.dart';

/// Analytics data model for tracking game metrics
class GameAnalytics {
  final String id;
  final String roomCode;
  final DateTime timestamp;
  final int totalPlayers;
  final int questionsAnswered;
  final int gameDuration; // seconds
  final Map<String, int> categoryUsage; // categoryId: question count
  final Map<String, int> difficultyBreakdown; // easy/medium/hard: count
  final Map<String, dynamic> bonusStats; // streaks, speed bonuses
  final List<String> powerCardsUsed;
  final String winningTeam;

  GameAnalytics({
    required this.id,
    required this.roomCode,
    required this.timestamp,
    required this.totalPlayers,
    required this.questionsAnswered,
    required this.gameDuration,
    required this.categoryUsage,
    required this.difficultyBreakdown,
    required this.bonusStats,
    required this.powerCardsUsed,
    required this.winningTeam,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomCode': roomCode,
      'timestamp': timestamp.toIso8601String(),
      'totalPlayers': totalPlayers,
      'questionsAnswered': questionsAnswered,
      'gameDuration': gameDuration,
      'categoryUsage': categoryUsage,
      'difficultyBreakdown': difficultyBreakdown,
      'bonusStats': bonusStats,
      'powerCardsUsed': powerCardsUsed,
      'winningTeam': winningTeam,
    };
  }

  factory GameAnalytics.fromJson(Map<String, dynamic> json) {
    return GameAnalytics(
      id: json['id'] ?? '',
      roomCode: json['roomCode'] ?? '',
      timestamp: json['timestamp'] is Timestamp
          ? (json['timestamp'] as Timestamp).toDate()
          : DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      totalPlayers: (json['totalPlayers'] as num?)?.toInt() ?? 0,
      questionsAnswered: (json['questionsAnswered'] as num?)?.toInt() ?? 0,
      gameDuration: (json['gameDuration'] as num?)?.toInt() ?? 0,
      categoryUsage: Map<String, int>.from(json['categoryUsage'] ?? {}),
      difficultyBreakdown: Map<String, int>.from(json['difficultyBreakdown'] ?? {}),
      bonusStats: Map<String, dynamic>.from(json['bonusStats'] ?? {}),
      powerCardsUsed: List<String>.from(json['powerCardsUsed'] ?? []),
      winningTeam: json['winningTeam'] ?? '',
    );
  }
}

/// Daily aggregated statistics
class DailyStats {
  final DateTime date;
  final int totalGames;
  final int totalPlayers;
  final int totalQuestions;
  final Map<String, int> popularCategories;
  final double avgGameDuration;

  DailyStats({
    required this.date,
    required this.totalGames,
    required this.totalPlayers,
    required this.totalQuestions,
    required this.popularCategories,
    required this.avgGameDuration,
  });
}

