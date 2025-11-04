import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../models/category_model.dart' as model;
import '../../services/question_service.dart';
import 'challenge_editor.dart';

class ChallengeList extends StatelessWidget {
  final Category category;
  final bool canEdit;
  const ChallengeList({super.key, required this.category, required this.canEdit});

  @override
  Widget build(BuildContext context) {
    final qs = QuestionService();
    return Scaffold(
      appBar: AppBar(title: Text('Questions - ${category.name}')),
      body: StreamBuilder<List<model.Challenge>>(
        stream: qs.watchChallenges(category.id),
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final items = snap.data!;
          if (items.isEmpty) return const Center(child: Text('No questions yet'));
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final q = items[i];
              return ListTile(
                title: Text(q.question),
                subtitle: q.options != null && q.options!.isNotEmpty
                    ? Text('Options: ${q.options!.length}')
                    : const Text('Open-ended'),
                onTap: canEdit
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChallengeEditor(categoryId: category.id, challenge: q),
                          ),
                        )
                    : null,
              );
            },
          );
        },
      ),
      floatingActionButton: canEdit
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChallengeEditor(categoryId: category.id),
                ),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

