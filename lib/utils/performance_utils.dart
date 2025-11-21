import 'dart:async';
import 'package:flutter/foundation.dart';

/// Performance utilities for optimizing DORAK app
class PerformanceUtils {
  // Cache for images
  static final Map<String, dynamic> _imageCache = {};
  
  // Debounce timer cache
  static final Map<String, Timer> _debounceTimers = {};

  /// Debounce function calls (prevent rapid repeated calls)
  static void debounce(
    String key,
    Function() action, {
    Duration delay = const Duration(milliseconds: 500),
  }) {
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(delay, action);
  }

  /// Throttle function calls (limit frequency)
  static DateTime? _lastThrottleTime;
  static void throttle(
    Function() action, {
    Duration delay = const Duration(milliseconds: 1000),
  }) {
    final now = DateTime.now();
    if (_lastThrottleTime == null ||
        now.difference(_lastThrottleTime!) > delay) {
      _lastThrottleTime = now;
      action();
    }
  }

  /// Log performance metrics in debug mode
  static void logPerformance(String operation, Function() action) {
    if (kDebugMode) {
      final stopwatch = Stopwatch()..start();
      action();
      stopwatch.stop();
      print('⏱️ $operation took: ${stopwatch.elapsedMilliseconds}ms');
    } else {
      action();
    }
  }

  /// Dispose cached resources
  static void clearCache() {
    _imageCache.clear();
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
  }
}

/// Memory optimization helpers
class MemoryOptimizer {
  /// Limit list size for UI performance
  static List<T> limitListSize<T>(List<T> list, {int maxSize = 100}) {
    if (list.length <= maxSize) return list;
    return list.sublist(0, maxSize);
  }

  /// Paginate large lists
  static List<T> paginate<T>(List<T> list, int page, {int pageSize = 20}) {
    final start = page * pageSize;
    if (start >= list.length) return [];
    final end = (start + pageSize).clamp(0, list.length);
    return list.sublist(start, end);
  }
}

/// Network optimization
class NetworkOptimizer {
  static final Map<String, dynamic> _queryCache = {};
  static final Map<String, DateTime> _cacheTimestamps = {};

  /// Cache Firestore query results
  static T? getCachedQuery<T>(String key, {Duration maxAge = const Duration(minutes: 5)}) {
    if (!_queryCache.containsKey(key)) return null;

    final timestamp = _cacheTimestamps[key];
    if (timestamp == null) return null;

    if (DateTime.now().difference(timestamp) > maxAge) {
      _queryCache.remove(key);
      _cacheTimestamps.remove(key);
      return null;
    }

    return _queryCache[key] as T?;
  }

  /// Set cache for query
  static void setCachedQuery(String key, dynamic value) {
    _queryCache[key] = value;
    _cacheTimestamps[key] = DateTime.now();
  }

  /// Clear old cache entries
  static void clearOldCache({Duration maxAge = const Duration(minutes: 10)}) {
    final now = DateTime.now();
    final keysToRemove = <String>[];

    _cacheTimestamps.forEach((key, timestamp) {
      if (now.difference(timestamp) > maxAge) {
        keysToRemove.add(key);
      }
    });

    for (final key in keysToRemove) {
      _queryCache.remove(key);
      _cacheTimestamps.remove(key);
    }
  }
}

