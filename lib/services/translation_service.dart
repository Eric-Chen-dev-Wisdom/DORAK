import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for translating text from English to Arabic
/// Using MyMemory Translation API (FREE - 1000 words/day)
class TranslationService {
  // MyMemory API (FREE, no API key required)
  static const String _baseUrl = 'https://api.mymemory.translated.net/get';
  
  /// Translate text from English to Arabic
  Future<String> translateToArabic(String englishText) async {
    if (englishText.isEmpty) return '';
    
    try {
      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'q': englishText,
        'langpair': 'en|ar',
      });
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final translatedText = data['responseData']['translatedText'];
        return translatedText ?? englishText;
      }
      
      print('⚠️ Translation failed, using original: ${response.statusCode}');
      return englishText; // Fallback to English
      
    } catch (e) {
      print('❌ Translation error: $e');
      return englishText; // Fallback to English
    }
  }
  
  /// Translate a list of strings (for options/answers)
  Future<List<String>> translateList(List<String> englishTexts) async {
    final arabicTexts = <String>[];
    
    for (final text in englishTexts) {
      final translated = await translateToArabic(text);
      arabicTexts.add(translated);
      
      // Small delay to avoid rate limiting (MyMemory is free)
      await Future.delayed(const Duration(milliseconds: 500));
    }
    
    return arabicTexts;
  }
  
  /// Translate a complete question with all options
  Future<Map<String, dynamic>> translateQuestion(
    Map<String, dynamic> questionData,
  ) async {
    print('🔄 Translating question...');
    
    // Translate question text
    final questionEn = questionData['question_en'] ?? '';
    final questionAr = await translateToArabic(questionEn);
    
    // Translate options if present
    List<String> optionsAr = [];
    if (questionData['options_en'] != null) {
      final optionsEn = List<String>.from(questionData['options_en']);
      optionsAr = await translateList(optionsEn);
    }
    
    print('✅ Translation complete');
    
    return {
      ...questionData,
      'question_ar': questionAr,
      'options_ar': optionsAr,
      'translated_at': DateTime.now().toIso8601String(),
    };
  }
  
  /// Batch translate multiple questions
  /// Returns progress callback for UI updates
  Future<List<Map<String, dynamic>>> translateQuestionsBatch(
    List<Map<String, dynamic>> questions, {
    Function(int current, int total)? onProgress,
  }) async {
    final translatedQuestions = <Map<String, dynamic>>[];
    
    for (int i = 0; i < questions.length; i++) {
      final translated = await translateQuestion(questions[i]);
      translatedQuestions.add(translated);
      
      // Report progress
      if (onProgress != null) {
        onProgress(i + 1, questions.length);
      }
      
      // Delay to respect rate limits (MyMemory: 1000 words/day free)
      if (i < questions.length - 1) {
        await Future.delayed(const Duration(milliseconds: 800));
      }
    }
    
    return translatedQuestions;
  }
  
  /// Check if translation API is available
  Future<bool> isApiAvailable() async {
    try {
      final result = await translateToArabic('test');
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}

/// Alternative: LibreTranslate (FREE, self-hosted or public instance)
class LibreTranslateService {
  static const String _baseUrl = 'https://libretranslate.de/translate';
  
  Future<String> translateToArabic(String text) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'q': text,
          'source': 'en',
          'target': 'ar',
          'format': 'text',
        }),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['translatedText'] ?? text;
      }
      
      return text;
    } catch (e) {
      print('❌ LibreTranslate error: $e');
      return text;
    }
  }
}

