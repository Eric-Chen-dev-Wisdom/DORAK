import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../services/question_service.dart';

class ChallengeEditor extends StatefulWidget {
  final String categoryId;
  final Challenge? challenge;
  const ChallengeEditor({super.key, required this.categoryId, this.challenge});

  @override
  State<ChallengeEditor> createState() => _ChallengeEditorState();
}

class _ChallengeEditorState extends State<ChallengeEditor> {
  final _form = GlobalKey<FormState>();
  final _question = TextEditingController();
  final List<TextEditingController> _options =
      List.generate(4, (_) => TextEditingController());
  int _correctIndex = 0;
  ChallengeDifficulty _difficulty = ChallengeDifficulty.easy;
  final _qs = QuestionService();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final q = widget.challenge;
    if (q != null) {
      _question.text = q.question;
      final opts = q.options ?? [];
      for (var i = 0; i < _options.length; i++) {
        _options[i].text = i < opts.length ? opts[i] : '';
      }
      // If correctAnswer provided as string in your model, derive index if present
      _difficulty = q.difficulty;
    }
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final id = widget.challenge?.id ??
          FirebaseFirestore.instance
              .collection('categories/${widget.categoryId}/challenges')
              .doc()
              .id;
      final options = _options
          .map((c) => c.text.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      final q = Challenge(
        id: id,
        question: _question.text.trim(),
        options: options.isEmpty ? null : options,
        // Store correct answer as string value if options exist
        correctAnswer: options.isEmpty
            ? null
            : options[
                _correctIndex.clamp(0, (options.length - 1).clamp(0, 999))],
        difficulty: _difficulty,
      );
      if (widget.challenge == null) {
        await _qs.createChallenge(widget.categoryId, q);
      } else {
        await _qs.upsertChallenge(widget.categoryId, q);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Save failed: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.challenge == null ? 'Add Question' : 'Edit Question')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: _question,
                decoration: const InputDecoration(labelText: 'Question'),
                maxLines: 3,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Options (leave blank for open-ended question)'),
              const SizedBox(height: 8),
              for (var i = 0; i < _options.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _options[i],
                    decoration: InputDecoration(labelText: 'Option ${i + 1}'),
                  ),
                ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                initialValue: _correctIndex,
                items: List.generate(
                    4,
                    (i) => DropdownMenuItem(
                        value: i, child: Text('Correct: Option ${i + 1}'))),
                onChanged: (v) => setState(() => _correctIndex = v ?? 0),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ChallengeDifficulty>(
                initialValue: _difficulty,
                items: ChallengeDifficulty.values
                    .map((d) => DropdownMenuItem(
                        value: d, child: Text(d.toString().split('.').last)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _difficulty = v ?? ChallengeDifficulty.easy),
                decoration: const InputDecoration(labelText: 'Difficulty'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving ? 'Saving...' : 'Save')),
            ],
          ),
        ),
      ),
    );
  }
}
