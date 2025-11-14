import 'package:flutter/material.dart';
import '../../services/question_service.dart';
import '../../models/category_model.dart';
import '../admin/category_editor.dart';
import '../admin/challenge_list.dart';
import '../admin/challenge_editor.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final QuestionService _qs = QuestionService();
  bool _isAdmin = false;
  bool _checked = false;
  List<Category> _cats = const [];

  @override
  void initState() {
    super.initState();
    _qs.isAdmin().then((v) => setState(() {
          _isAdmin = v;
          _checked = true;
        }));
    // Seed defaults in the background (safe if already present)
    _qs.seedDefaultsIfEmpty().then((_) => _qs.seedDefaultQuestionsIfEmpty());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Categories'),
        actions: [
          if (_isAdmin)
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: _openAdminMenu,
              tooltip: 'Admin Menu',
            ),
        ],
      ),
      body: !_checked
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Category>>(
              stream: _qs.watchCategories(),
              builder: (context, snap) {
                if (snap.hasError) {
                  return Center(child: Text('Error: ${snap.error}'));
                }
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final cats = snap.data!;
                _cats = cats; // keep a local copy for the menu pickers
                if (cats.isEmpty) {
                  return const Center(child: Text('No categories yet'));
                }
                return ListView.separated(
                  itemCount: cats.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final c = cats[i];
                    return ListTile(
                      title: Text(c.name),
                      subtitle: Text(c.description),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ChallengeList(category: c, canEdit: _isAdmin),
                        ),
                      ),
                      trailing: _isAdmin
                          ? IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryEditor(category: c),
                                ),
                              ),
                            )
                          : null,
                    );
                  },
                );
              },
            ),
      floatingActionButton: _isAdmin
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoryEditor()),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _openAdminMenu() async {
    if (!_isAdmin) return;
    final rootContext =
        context; // keep a stable context for navigation/snackbars
    await showModalBottomSheet(
      context: rootContext,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Add Category'),
              onTap: () {
                Navigator.pop(sheetContext);
                Navigator.push(
                  rootContext,
                  MaterialPageRoute(builder: (_) => const CategoryEditor()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.download_for_offline),
              title: const Text('Sync Default Questions (merge)'),
              onTap: () async {
                Navigator.pop(sheetContext);
                final count = await _qs.syncDefaultQuestionsMerge();
                if (!mounted) return;
                ScaffoldMessenger.of(rootContext).showSnackBar(
                  SnackBar(
                      content: Text(count == 0
                          ? 'Default questions are up to date.'
                          : 'Added $count default questions.')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Manage Questions'),
              onTap: () async {
                Navigator.pop(sheetContext);
                final cat = await _pickCategory('Select Category');
                if (cat != null) {
                  // Navigate to questions list for this category
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    rootContext,
                    MaterialPageRoute(
                      builder: (_) =>
                          ChallengeList(category: cat, canEdit: _isAdmin),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Add Question'),
              onTap: () async {
                Navigator.pop(sheetContext);
                final cat = await _pickCategory('Select Category');
                if (cat != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    rootContext,
                    MaterialPageRoute(
                      builder: (_) => ChallengeEditor(categoryId: cat.id),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Category?> _pickCategory(String title) async {
    if (_cats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No categories available. Add one first.')),
      );
      return null;
    }
    return showModalBottomSheet<Category>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _cats.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(_cats[i].name),
                  subtitle: Text(_cats[i].description),
                  onTap: () => Navigator.pop(context, _cats[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
