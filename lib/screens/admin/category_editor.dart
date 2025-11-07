import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../services/question_service.dart';

class CategoryEditor extends StatefulWidget {
  final Category? category;
  const CategoryEditor({super.key, this.category});

  @override
  State<CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends State<CategoryEditor> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _image = TextEditingController();
  CategoryType _type = CategoryType.trivia;
  bool _saving = false;
  final _qs = QuestionService();

  @override
  void initState() {
    super.initState();
    final c = widget.category;
    if (c != null) {
      _name.text = c.name;
      _desc.text = c.description;
      _image.text = c.imageAsset;
      _type = c.type;
    }
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final id = widget.category?.id ??
          FirebaseFirestore.instance.collection('categories').doc().id;
      final cat = Category(
        id: id,
        name: _name.text.trim(),
        description: _desc.text.trim(),
        type: _type,
        challenges: const [],
        imageAsset: _image.text.trim(),
      );
      if (widget.category == null) {
        await _qs.createCategory(cat);
      } else {
        await _qs.upsertCategory(cat);
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
          title:
              Text(widget.category == null ? 'Add Category' : 'Edit Category')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _desc,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<CategoryType>(
                initialValue: _type,
                items: CategoryType.values
                    .map((t) => DropdownMenuItem(
                        value: t, child: Text(t.toString().split('.').last)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _type = v ?? CategoryType.trivia),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _image,
                decoration:
                    const InputDecoration(labelText: 'Image URL or asset path'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saving ? null : _save,
                child: Text(_saving ? 'Saving...' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
