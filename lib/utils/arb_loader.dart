import 'dart:convert';
import 'package:flutter/services.dart';

/// Load ARB files directly for question translation
class ArbLoader {
  static Map<String, dynamic>? _cachedArabic;
  static Map<String, dynamic>? _cachedEnglish;

  /// Load Arabic ARB file
  static Future<Map<String, dynamic>> loadArabic() async {
    if (_cachedArabic != null) return _cachedArabic!;
    
    try {
      final String content = await rootBundle.loadString('lib/l10n/app_ar.arb');
      _cachedArabic = json.decode(content) as Map<String, dynamic>;
      print('✅ Loaded Arabic ARB: ${_cachedArabic!.length} keys');
      return _cachedArabic!;
    } catch (e) {
      print('❌ Failed to load Arabic ARB: $e');
      return {};
    }
  }

  /// Load English ARB file
  static Future<Map<String, dynamic>> loadEnglish() async {
    if (_cachedEnglish != null) return _cachedEnglish!;
    
    try {
      final String content = await rootBundle.loadString('lib/l10n/app_en.arb');
      _cachedEnglish = json.decode(content) as Map<String, dynamic>;
      print('✅ Loaded English ARB: ${_cachedEnglish!.length} keys');
      return _cachedEnglish!;
    } catch (e) {
      print('❌ Failed to load English ARB: $e');
      return {};
    }
  }

  /// Get question text in specified language
  static Future<String?> getQuestionText(String questionId, String lang) async {
    final arb = lang == 'ar' ? await loadArabic() : await loadEnglish();
    final key = '${questionId}_text';
    return arb[key]?.toString();
  }

  /// Get question options in specified language
  static Future<List<String>> getQuestionOptions(String questionId, String lang) async {
    final arb = lang == 'ar' ? await loadArabic() : await loadEnglish();
    final options = <String>[];
    
    for (int i = 1; i <= 10; i++) {
      final key = '${questionId}_opt$i';
      final value = arb[key];
      if (value != null && value.toString().isNotEmpty) {
        options.add(value.toString());
      } else {
        break;
      }
    }
    
    return options;
  }

  /// Get category name in specified language
  static Future<String?> getCategoryName(String categoryId, String lang) async {
    final arb = lang == 'ar' ? await loadArabic() : await loadEnglish();
    final key = 'cat_${categoryId}Name';
    return arb[key]?.toString();
  }
  
  /// Clear cache (for language switching)
  static void clearCache() {
    _cachedArabic = null;
    _cachedEnglish = null;
  }
}

