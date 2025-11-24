import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/analytics_model.dart';

/// Service for tracking and analyzing gameplay data
class AnalyticsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Save analytics data when game completes
  Future<void> saveGameAnalytics(GameAnalytics analytics) async {
    try {
      await _firestore.collection('analytics').add({
        ...analytics.toJson(),
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('📊 Analytics saved for game: ${analytics.roomCode}');
    } catch (e) {
      print('❌ Error saving analytics: $e');
    }
  }

  /// Get total games played (from analytics collection)
  Future<int> getTotalGames() async {
    try {
      // First try analytics collection (new games)
      final analyticsSnapshot = await _firestore.collection('analytics').count().get();
      final analyticsCount = analyticsSnapshot.count ?? 0;
      
      // Fallback to matchHistory for backward compatibility
      if (analyticsCount == 0) {
        final matchSnapshot = await _firestore.collection('matchHistory').count().get();
        return matchSnapshot.count ?? 0;
      }
      
      return analyticsCount;
    } catch (e) {
      print('❌ Error getting total games: $e');
      // Fallback: try to count matchHistory
      try {
        final snapshot = await _firestore.collection('matchHistory').count().get();
        return snapshot.count ?? 0;
      } catch (e2) {
        return 0;
      }
    }
  }

  /// Get games in date range
  Future<List<GameAnalytics>> getGamesInRange(
      DateTime start, DateTime end) async {
    try {
      final snapshot = await _firestore
          .collection('analytics')
          .where('timestamp', isGreaterThanOrEqualTo: start)
          .where('timestamp', isLessThanOrEqualTo: end)
          .get();

      return snapshot.docs
          .map((doc) => GameAnalytics.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      print('❌ Error getting games in range: $e');
      return [];
    }
  }

  /// Get most popular categories (by usage count)
  Future<Map<String, int>> getPopularCategories({int days = 7}) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      final snapshot = await _firestore
          .collection('analytics')
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .get();

      final categoryCount = <String, int>{};

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final usage = Map<String, int>.from(data['categoryUsage'] ?? {});
        usage.forEach((category, count) {
          categoryCount[category] = (categoryCount[category] ?? 0) + count;
        });
      }

      return categoryCount;
    } catch (e) {
      print('❌ Error getting popular categories: $e');
      return {};
    }
  }

  /// Get average game duration
  Future<double> getAverageGameDuration({int days = 7}) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      final snapshot = await _firestore
          .collection('analytics')
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .get();

      if (snapshot.docs.isEmpty) return 0.0;

      int totalDuration = 0;
      for (final doc in snapshot.docs) {
        totalDuration += ((doc.data()['gameDuration'] as num?) ?? 0).toInt();
      }

      return totalDuration / snapshot.docs.length;
    } catch (e) {
      print('❌ Error getting avg duration: $e');
      return 0.0;
    }
  }

  /// Get power card usage stats
  Future<Map<String, int>> getPowerCardStats({int days = 7}) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      final snapshot = await _firestore
          .collection('analytics')
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .get();

      final cardCount = <String, int>{};

      for (final doc in snapshot.docs) {
        final cards = List<String>.from(doc.data()['powerCardsUsed'] ?? []);
        for (final card in cards) {
          cardCount[card] = (cardCount[card] ?? 0) + 1;
        }
      }

      return cardCount;
    } catch (e) {
      print('❌ Error getting power card stats: $e');
      return {};
    }
  }

  /// Get streak and speed bonus frequency
  Future<Map<String, dynamic>> getBonusStats({int days = 7}) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      final snapshot = await _firestore
          .collection('analytics')
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .get();

      int totalStreaks = 0;
      int totalSpeedBonuses = 0;
      int totalJackpots = 0;

      for (final doc in snapshot.docs) {
        final bonusStats =
            Map<String, dynamic>.from(doc.data()['bonusStats'] ?? {});
        totalStreaks += ((bonusStats['streaksEarned'] as num?) ?? 0).toInt();
        totalSpeedBonuses +=
            ((bonusStats['speedBonuses'] as num?) ?? 0).toInt();
        totalJackpots += ((bonusStats['jackpotsPlayed'] as num?) ?? 0).toInt();
      }

      return {
        'totalStreaks': totalStreaks,
        'totalSpeedBonuses': totalSpeedBonuses,
        'totalJackpots': totalJackpots,
        'avgPerGame': snapshot.docs.isEmpty
            ? 0.0
            : (totalStreaks + totalSpeedBonuses) / snapshot.docs.length,
      };
    } catch (e) {
      print('❌ Error getting bonus stats: $e');
      return {};
    }
  }

  /// Stream of recent games (for real-time dashboard)
  Stream<QuerySnapshot> getRecentGamesStream({int limit = 20}) {
    return _firestore
        .collection('analytics')
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
  }
}
