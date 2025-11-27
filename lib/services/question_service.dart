import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/category_model.dart';
import '../data/default_categories.dart';
import '../data/default_questions.dart';
import 'locale_service.dart';

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
  Stream<List<Category>> watchCategories({String? langCode}) {
    return _db.collection('categories').snapshots().map((snap) {
      final lang = langCode ??
          LocaleService.locale.value?.languageCode ??
          ui.PlatformDispatcher.instance.locale.languageCode;
      return snap.docs.map((d) {
        final raw = d.data();
        final localizedName = raw['name_${lang}'] ?? raw['name'] ?? '';
        final localizedDesc =
            raw['description_${lang}'] ?? raw['description'] ?? '';
        return Category.fromJson({
          ...raw,
          'id': d.id,
          // Inject localized fallbacks for model
          'name': localizedName,
          'description': localizedDesc,
        });
      }).toList();
    });
  }

  // Backfill Firestore challenge localization fields from ARB assets.
  // Reads lib/l10n/app_en.arb and app_ar.arb as assets (ensure pubspec lists them).
  // Safe to run multiple times; uses set(merge: true).
  Future<void> backfillQuestionsFromArbAssets() async {
    final en = await _readArbAsset('lib/l10n/app_en.arb');
    final ar = await _readArbAsset('lib/l10n/app_ar.arb');

    final defs = defaultQuestionsByCategory();
    for (final entry in defs.entries) {
      final catId = entry.key;
      final col = _db.collection('categories').doc(catId).collection('challenges');

      final batch = _db.batch();
      for (final q in entry.value) {
        final base = 'q_${q.id}';
        final textEn = (en['${base}_text'] as String?) ?? q.question;
        final textAr = (ar['${base}_text'] as String?) ?? textEn;

        List<String> optsEn = _collectOptions(en, base);
        if (optsEn.isEmpty && q.options != null) optsEn = q.options!;
        List<String> optsAr = _collectOptions(ar, base);
        if (optsAr.isEmpty) optsAr = optsEn;

        // Normalize correct answer to index
        int correctIndex = -1;
        if (q.correctAnswer != null) {
          if (q.correctAnswer is int) correctIndex = q.correctAnswer as int;
          if (q.correctAnswer is String && optsEn.isNotEmpty) {
            final i = optsEn.indexOf(q.correctAnswer as String);
            if (i >= 0) correctIndex = i;
          }
        }

        final ref = col.doc(q.id);
        batch.set(ref, {
          'question_en': textEn,
          'options_en': optsEn,
          'question_ar': textAr,
          'options_ar': optsAr,
          if (correctIndex >= 0) 'correctAnswer': correctIndex,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
      await batch.commit();
    }
  }

  Future<Map<String, dynamic>> _readArbAsset(String path) async {
    try {
      final txt = await rootBundle.loadString(path);
      final m = json.decode(txt);
      if (m is Map<String, dynamic>) return m;
      return <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  List<String> _collectOptions(Map<String, dynamic> arb, String base) {
    final out = <String>[];
    for (var i = 1; i <= 10; i++) {
      final v = arb['${base}_opt$i'];
      if (v is String && v.isNotEmpty) {
        out.add(v);
      } else {
        break;
      }
    }
    return out;
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
        final data = c.toJson();
        // Also seed localized fields; you can replace values with real translations later
        data['name_en'] = c.name;
        data['description_en'] = c.description;
        data['name_ar'] = c.name;
        data['description_ar'] = c.description;
        batch.set(ref, data);
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
        final qCol =
            _db.collection('categories').doc(catId).collection('challenges');
        final existing = await qCol.limit(1).get();
        if (existing.docs.isNotEmpty) {
          continue; // already has questions
        }
        final batch = _db.batch();
        for (final q in entry.value) {
          final ref = qCol.doc(q.id);
          final data = q.toJson();
          // Seed localized fields; replace with real translations later
          data['question_en'] = q.question;
          if (q.options != null) data['options_en'] = q.options;
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
        final qCol =
            _db.collection('categories').doc(catId).collection('challenges');

        // Read existing ids
        final existingSnap = await qCol.get();
        final existingIds = existingSnap.docs.map((d) => d.id).toSet();

        // Add only missing ones
        final batch = _db.batch();
        for (final q in entry.value) {
          if (existingIds.contains(q.id)) continue;
          final ref = qCol.doc(q.id);
          final data = q.toJson();
          data['question_en'] = q.question;
          if (q.options != null) data['options_en'] = q.options;
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
            .map((d) => Challenge.fromJson({...d.data(), 'id': d.id}))
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
  
  // Update challenge with custom data (for imports with int correctAnswer, etc.)
  Future<void> upsertChallengeData(
      String categoryId, String challengeId, Map<String, dynamic> data) async {
    data['updatedAt'] = FieldValue.serverTimestamp();
    await _db
        .collection('categories')
        .doc(categoryId)
        .collection('challenges')
        .doc(challengeId)
        .set(data, SetOptions(merge: true));
  }

  Future<void> deleteChallenge(String categoryId, String challengeId) async {
    await _db
        .collection('categories')
        .doc(categoryId)
        .collection('challenges')
        .doc(challengeId)
        .delete();
  }

  /// Delete all default questions (q_xxx format) - keeps only imported questions
  Future<int> deleteAllDefaultQuestions() async {
    int deletedCount = 0;
    try {
      final categories = await _db.collection('categories').get();
      
      for (final catDoc in categories.docs) {
        final challenges = await _db
            .collection('categories')
            .doc(catDoc.id)
            .collection('challenges')
            .get();
        
        for (final challengeDoc in challenges.docs) {
          // Delete if it's a default question (q_xxx format)
          if (challengeDoc.id.startsWith('q_')) {
            await challengeDoc.reference.delete();
            deletedCount++;
          }
        }
      }
      
      print('✅ Deleted $deletedCount default questions');
      return deletedCount;
    } catch (e) {
      print('❌ Error deleting default questions: $e');
      return deletedCount;
    }
  }

  /// Delete ALL questions (default + imported) - complete reset
  Future<int> deleteAllQuestions() async {
    int deletedCount = 0;
    try {
      final categories = await _db.collection('categories').get();
      
      for (final catDoc in categories.docs) {
        final challenges = await _db
            .collection('categories')
            .doc(catDoc.id)
            .collection('challenges')
            .get();
        
        for (final challengeDoc in challenges.docs) {
          await challengeDoc.reference.delete();
          deletedCount++;
        }
      }
      
      print('✅ Deleted ALL $deletedCount questions');
      return deletedCount;
    } catch (e) {
      print('❌ Error deleting all questions: $e');
      return deletedCount;
    }
  }
}
