import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service to fetch questions from OpenTrivia Database
/// API Documentation: https://opentdb.com/api_config.php
class OpenTriviaService {
  static const String _baseUrl = 'https://opentdb.com/api.php';

  // OpenTrivia category IDs mapped to DORAK categories
  static const Map<String, int> categoryMapping = {
    '1': 9, // General Knowledge → General Knowledge
    '2': 22, // Geography (for Family/Culture)
    '3': 23, // History (for Gulf Culture)
    '4': 11, // Film → Movies
    '5': 12, // Music → Music
    '6': 14, // Television (entertainment)
    '7': 15, // Video Games (for Kids)
    '8': 17, // Science (Quick Thinking)
  };

  /// Fetch questions from OpenTrivia DB
  ///
  /// Parameters:
  /// - [amount]: Number of questions (max 50 per request)
  /// - [categoryId]: DORAK category ID (1-8)
  /// - [difficulty]: 'easy', 'medium', 'hard', or null for mixed
  ///
  /// Returns: List of question maps
  Future<List<Map<String, dynamic>>> fetchQuestions({
    required int amount,
    String? categoryId,
    String? difficulty,
  }) async {
    try {
      // Limit to 50 questions per request (API limitation)
      final requestAmount = amount > 50 ? 50 : amount;

      // Build URL with parameters
      final params = {
        'amount': requestAmount.toString(),
        'type': 'multiple', // Multiple choice questions only
      };

      // Add category if specified
      if (categoryId != null && categoryMapping.containsKey(categoryId)) {
        params['category'] = categoryMapping[categoryId]!.toString();
      }

      // Add difficulty if specified
      if (difficulty != null && difficulty != 'all') {
        params['difficulty'] = difficulty.toLowerCase();
      }

      // Make API request
      final uri = Uri.parse(_baseUrl).replace(queryParameters: params);
      print('🌐 Fetching from OpenTrivia: $uri');

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('OpenTrivia API error: ${response.statusCode}');
      }

      final data = json.decode(response.body);

      // Check response code
      final responseCode = data['response_code'];
      if (responseCode != 0) {
        throw Exception('OpenTrivia response code: $responseCode');
      }

      final results = data['results'] as List;

      print('✅ Fetched ${results.length} questions from OpenTrivia');

      // Convert to DORAK format
      return results.map((q) => _convertToDorakFormat(q, categoryId)).toList();
    } catch (e) {
      print('❌ Error fetching from OpenTrivia: $e');
      return [];
    }
  }

  /// Fetch multiple batches if amount > 50
  Future<List<Map<String, dynamic>>> fetchQuestionsLarge({
    required int amount,
    String? categoryId,
    String? difficulty,
  }) async {
    final allQuestions = <Map<String, dynamic>>[];
    int remaining = amount;

    while (remaining > 0) {
      final batchSize = remaining > 50 ? 50 : remaining;

      final batch = await fetchQuestions(
        amount: batchSize,
        categoryId: categoryId,
        difficulty: difficulty,
      );

      allQuestions.addAll(batch);
      remaining -= batch.length;

      // Avoid rate limiting - wait 5 seconds between requests
      if (remaining > 0) {
        print('⏳ Waiting 5s before next batch...');
        await Future.delayed(const Duration(seconds: 5));
      }
    }

    print('✅ Total fetched: ${allQuestions.length} questions');
    return allQuestions;
  }

  /// Convert OpenTrivia question format to DORAK format
  Map<String, dynamic> _convertToDorakFormat(
    Map<String, dynamic> openTriviaQuestion,
    String? categoryId,
  ) {
    // Decode HTML entities in question and answers
    final question = _decodeHtml(openTriviaQuestion['question']);
    final correctAnswer = _decodeHtml(openTriviaQuestion['correct_answer']);
    final incorrectAnswers = (openTriviaQuestion['incorrect_answers'] as List)
        .map((a) => _decodeHtml(a))
        .toList();

    // Combine and shuffle answers
    final allAnswers = [correctAnswer, ...incorrectAnswers];
    allAnswers.shuffle();

    // Find correct answer index
    final correctIndex = allAnswers.indexOf(correctAnswer);

    // Map difficulty
    final difficulty =
        openTriviaQuestion['difficulty']?.toLowerCase() ?? 'easy';

    return {
      'id':
          'opentrivia_${DateTime.now().millisecondsSinceEpoch}_${question.hashCode}',
      'question_en': question,
      'options_en': allAnswers,
      'correctAnswer': correctIndex,
      'difficulty': difficulty,
      'source': 'opentrivia',
      'categoryId': categoryId,
      'imported_at': DateTime.now().toIso8601String(),
    };
  }

  /// Decode HTML entities (OpenTrivia returns HTML-encoded text)
  String _decodeHtml(dynamic text) {
    if (text == null) return '';
    String decoded = text.toString();

    // Common HTML entities
    decoded = decoded
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&apos;', "'")
        .replaceAll('&rsquo;', "'")
        .replaceAll('&ldquo;', '"')
        .replaceAll('&rdquo;', '"')
        .replaceAll('&ndash;', '–')
        .replaceAll('&mdash;', '—')
        .replaceAll('&hellip;', '…');

    return decoded;
  }

  /// Get available categories from OpenTrivia
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://opentdb.com/api_category.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['trivia_categories']);
      }

      return [];
    } catch (e) {
      print('❌ Error fetching categories: $e');
      return [];
    }
  }

  /// Check API availability
  Future<bool> isApiAvailable() async {
    try {
      final response = await http
          .get(
            Uri.parse(_baseUrl).replace(queryParameters: {'amount': '1'}),
          )
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

/// OpenTrivia category information
class OpenTriviaCategory {
  final int id;
  final String name;

  OpenTriviaCategory({required this.id, required this.name});

  factory OpenTriviaCategory.fromJson(Map<String, dynamic> json) {
    return OpenTriviaCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}
