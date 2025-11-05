import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/category_model.dart';
import '../data/default_categories.dart';
import '../data/default_questions.dart';

class QuestionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Admin check: either custom claim or membership in admins collection
  Future<bool> isAdmin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    try {
      final token = await user.getIdTokenResult(true);
      if ((token.claims?['admin'] ?? false) == true) return true;
    } catch (_) {}
    // Dev fallback: treat demo account as admin
    if ((user.email ?? '').toLowerCase() == 'demo@demo.com') return true;
    try {
      final doc = await _db.collection('admins').doc(user.uid).get();
      return doc.exists == true;
    } catch (_) {
      return false;
    }
  }

  // Categories
  Stream<List<Category>> watchCategories() {
    return _db
        .collection('categories')
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Category.fromJson({...?d.data(), 'id': d.id}))
            .toList());
  }

  Future<String> createCategory(Category c) async {
    final doc = _db.collection('categories').doc();
    await doc.set(c.toJson());
    return doc.id;
  }

  Future<void> upsertCategory(Category c) async {
    await _db.collection('categories').doc(c.id).set(c.toJson());
  }

  Future<void> deleteCategory(String categoryId) async {
    await _db.collection('categories').doc(categoryId).delete();
  }

  // Seed default categories if none exist
  Future<void> seedDefaultsIfEmpty() async {
    try {
      final snap = await _db.collection('categories').limit(1).get();
      if (snap.docs.isNotEmpty) return;
      final batch = _db.batch();
      for (final c in defaultCategories()) {
        final ref = _db.collection('categories').doc(c.id);
        batch.set(ref, c.toJson());
      }
      await batch.commit();
      // Optional: add a sample question per category later
    } catch (e) {
      // Best-effort; ignore errors here
    }
  }

  // Seed default questions for each default category if that category has none
  Future<void> seedDefaultQuestionsIfEmpty() async {
    try {
      final defs = defaultQuestionsByCategory();
      for (final entry in defs.entries) {
        final catId = entry.key;
        final qCol = _db
            .collection('categories')
            .doc(catId)
            .collection('challenges');
        final existing = await qCol.limit(1).get();
        if (existing.docs.isNotEmpty) {
          continue; // already has questions
        }
        final batch = _db.batch();
        for (final q in entry.value) {
          final ref = qCol.doc(q.id);
          final data = q.toJson();
          data['updatedAt'] = FieldValue.serverTimestamp();
          batch.set(ref, data);
        }
        await batch.commit();
      }
    } catch (_) {
      // ignore best-effort seed failures
    }
  }

  // Merge any new defaults that were added to default_questions.dart
  // Adds missing questions by id without touching existing ones.
  Future<int> syncDefaultQuestionsMerge() async {
    int added = 0;
    try {
      final defs = defaultQuestionsByCategory();
      for (final entry in defs.entries) {
        final catId = entry.key;
        final qCol = _db
            .collection('categories')
            .doc(catId)
            .collection('challenges');

        // Read existing ids
        final existingSnap = await qCol.get();
        final existingIds = existingSnap.docs.map((d) => d.id).toSet();

        // Add only missing ones
        final batch = _db.batch();
        for (final q in entry.value) {
          if (existingIds.contains(q.id)) continue;
          final ref = qCol.doc(q.id);
          final data = q.toJson();
          data['updatedAt'] = FieldValue.serverTimestamp();
          batch.set(ref, data);
          added++;
        }
        // Commit only if we staged something
        if (added > 0) {
          await batch.commit();
        }
      }
    } catch (_) {
      // ignore; surface count regardless
    }
    return added;
  }

  // Challenges
  Stream<List<Challenge>> watchChallenges(String categoryId) {
    return _db
        .collection('categories')
        .doc(categoryId)
        .collection('challenges')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Challenge.fromJson({...?d.data(), 'id': d.id}))
            .toList());
  }

  Future<String> createChallenge(String categoryId, Challenge q) async {
    final doc = _db
        .collection('categories')
        .doc(categoryId)
        .collection('challenges')
        .doc();
    final data = q.toJson();
    data['updatedAt'] = FieldValue.serverTimestamp();
    await doc.set(data);
    return doc.id;
  }

  Future<void> upsertChallenge(String categoryId, Challenge q) async {
    final data = q.toJson();
    data['updatedAt'] = FieldValue.serverTimestamp();
    await _db
        .collection('categories')
        .doc(categoryId)
        .collection('challenges')
        .doc(q.id)
        .set(data);
  }

  Future<void> deleteChallenge(String categoryId, String challengeId) async {
    await _db
        .collection('categories')
        .doc(categoryId)
        .collection('challenges')
        .doc(challengeId)
        .delete();
  }
}
