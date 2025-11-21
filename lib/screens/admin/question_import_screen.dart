import 'package:flutter/material.dart';
import '../../services/opentrivia_service.dart';
import '../../services/translation_service.dart';
import '../../services/question_service.dart';
import '../../data/default_categories.dart';
import '../../utils/constants.dart';

class QuestionImportScreen extends StatefulWidget {
  const QuestionImportScreen({super.key});

  @override
  State<QuestionImportScreen> createState() => _QuestionImportScreenState();
}

class _QuestionImportScreenState extends State<QuestionImportScreen> {
  final OpenTriviaService _openTrivia = OpenTriviaService();
  final TranslationService _translator = TranslationService();
  final QuestionService _questionService = QuestionService();

  bool _isImporting = false;
  int _totalQuestions = 100;
  String _selectedCategoryId = '1';
  String _selectedDifficulty = 'all';

  int _importedCount = 0;
  int _translatedCount = 0;
  int _savedCount = 0;
  String _statusMessage = '';
  bool _skipTranslation = false; // Option to skip translation

  final List<Map<String, dynamic>> _previewQuestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Questions from OpenTrivia'),
        backgroundColor: AppConstants.primaryRed,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'OpenTrivia DB Question Import',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '• Fetch questions from OpenTrivia Database (FREE)\n'
                      '• Auto-translate English → Arabic\n'
                      '• Save to Firestore for your game\n'
                      '• Max 50 questions per batch (API limit)',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Settings
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Import Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category selector
                    DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      decoration: const InputDecoration(
                        labelText: 'DORAK Category',
                        border: OutlineInputBorder(),
                      ),
                      items: defaultCategories().map((cat) {
                        return DropdownMenuItem(
                          value: cat.id,
                          child: Text(cat.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value ?? '1';
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Difficulty selector
                    DropdownButtonFormField<String>(
                      value: _selectedDifficulty,
                      decoration: const InputDecoration(
                        labelText: 'Difficulty',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'all', child: Text('All (Mixed)')),
                        DropdownMenuItem(
                            value: 'easy', child: Text('Easy Only')),
                        DropdownMenuItem(
                            value: 'medium', child: Text('Medium Only')),
                        DropdownMenuItem(
                            value: 'hard', child: Text('Hard Only')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedDifficulty = value ?? 'all';
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Question count
                    TextFormField(
                      initialValue: _totalQuestions.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Number of Questions',
                        border: OutlineInputBorder(),
                        helperText:
                            'Max 50 per batch. System will fetch multiple batches if needed.',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _totalQuestions = int.tryParse(value) ?? 100;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Progress
            if (_isImporting)
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        _statusMessage,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      if (_importedCount > 0) Text('Imported: $_importedCount'),
                      if (_translatedCount > 0)
                        Text('Translated: $_translatedCount'),
                      if (_savedCount > 0) Text('Saved: $_savedCount'),
                    ],
                  ),
                ),
              ),

            // Import button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isImporting ? null : _startImport,
                icon: const Icon(Icons.download, size: 24),
                label: Text(
                  _isImporting ? 'Importing...' : 'Start Import',
                  style: const TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Preview
            if (_previewQuestions.isNotEmpty) ...[
              const Text(
                'Preview (First 5 Questions)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ..._previewQuestions.take(5).map((q) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EN: ${q['question_en']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          if (q['question_ar'] != null)
                            Text(
                              'AR: ${q['question_ar']}',
                              style: const TextStyle(color: Colors.blue),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            'Difficulty: ${q['difficulty']}',
                            style: TextStyle(
                              color: q['difficulty'] == 'hard'
                                  ? Colors.red
                                  : (q['difficulty'] == 'medium'
                                      ? Colors.orange
                                      : Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _startImport() async {
    setState(() {
      _isImporting = true;
      _importedCount = 0;
      _translatedCount = 0;
      _savedCount = 0;
      _statusMessage = 'Fetching questions from OpenTrivia DB...';
      _previewQuestions.clear();
    });

    try {
      // Step 1: Fetch from OpenTrivia
      final questions = await _openTrivia.fetchQuestionsLarge(
        amount: _totalQuestions,
        categoryId: _selectedCategoryId,
        difficulty: _selectedDifficulty == 'all' ? null : _selectedDifficulty,
      );

      setState(() {
        _importedCount = questions.length;
        _statusMessage = _skipTranslation
            ? 'Preparing questions...'
            : 'Translating questions to Arabic...';
      });

      // Step 2: Translate to Arabic (or skip)
      final translatedQuestions = _skipTranslation
          ? questions.map((q) => _translator.skipTranslation(q)).toList()
          : await _translator.translateQuestionsBatch(
              questions,
              onProgress: (current, total) {
                setState(() {
                  _translatedCount = current;
                  _statusMessage = 'Translating... ($current/$total)';
                });
              },
            );

      setState(() {
        _statusMessage = 'Saving to Firestore...';
        _previewQuestions.addAll(translatedQuestions);
      });

      // Step 3: Save to Firestore
      for (final question in translatedQuestions) {
        await _saveQuestionToFirestore(question);
        setState(() {
          _savedCount++;
          _statusMessage =
              'Saving... ($_savedCount/${translatedQuestions.length})';
        });
      }

      // Success!
      setState(() {
        _isImporting = false;
        _statusMessage = '✅ Import complete!';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Successfully imported $_savedCount questions!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      setState(() {
        _isImporting = false;
        _statusMessage = '❌ Error: $e';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Import failed: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _saveQuestionToFirestore(Map<String, dynamic> question) async {
    // Save directly to Firestore with correct types
    // correctAnswer is stored as int (index) in Firestore
    await _questionService.upsertChallengeData(
      _selectedCategoryId,
      question['id'],
      {
        'question_en': question['question_en'],
        'question_ar': question['question_ar'],
        'options_en': question['options_en'],
        'options_ar': question['options_ar'],
        'correctAnswer': question['correctAnswer'], // int (index)
        'difficulty': question['difficulty'],
        'source': 'opentrivia',
        'imported_at': question['imported_at'],
      },
    );
  }
}
