// screens/category_selection_screen.dart
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../data/default_categories.dart';
import '../services/question_service.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import 'game_screen.dart';
import '../services/lobby_service.dart';
import 'dart:async';
import 'package:DORAK/l10n/app_localizations.dart';

class CategorySelectionScreen extends StatefulWidget {
  final GameRoom room;
  final UserModel user;

  const CategorySelectionScreen({
    super.key,
    required this.room,
    required this.user,
  });

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final LobbyService _lobbyService = LobbyService();
  StreamSubscription<GameRoom?>? _roomSub;
  bool _navigatedToGame = false;
  // Will be populated from Firestore (localized). Fallback to defaults if empty
  List<Category> _availableCategories = [];
  final QuestionService _questionService = QuestionService();

  final List<Category> _selectedCategories = [];
  final Set<String> _selectedIds = <String>{};
  Map<String, Category> _catalogById = {};
  String _difficulty = 'all'; // 'all','easy','medium','hard'
  int _questionCount = 10; // host-chosen count

  bool get _isHost => widget.user.id == widget.room.hostId;

  @override
  void initState() {
    super.initState();
    // Best-effort: ensure categories exist in Firestore
    // ignore: unawaited_futures
    _questionService.seedDefaultsIfEmpty();
    _catalogById = {};
    // Start with any existing selections (dedup by id)
    _selectedIds.addAll(widget.room.selectedCategories.map((c) => c.id));
    _selectedCategories
      ..clear()
      ..addAll(
          _selectedIds.map((id) => _catalogById[id]).whereType<Category>());
    // Everyone listens: host and joiners
    _roomSub = _lobbyService.getRoomStream(widget.room.code).listen((room) {
      if (!mounted || room == null) return;
      // Reflect live selections from host (by id)
      setState(() {
        _selectedIds
          ..clear()
          ..addAll(room.selectedCategories.map((c) => c.id));
        _selectedCategories
          ..clear()
          ..addAll(
              _selectedIds.map((id) => _catalogById[id]).whereType<Category>());
      });
      // Transition to game for all when host starts
      if (!_navigatedToGame && room.state == GameState.inGame) {
        _navigatedToGame = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(
              room: room,
              user: widget.user,
              isHost: _isHost,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _roomSub?.cancel();
    super.dispose();
  }

  void _toggleCategory(Category category) {
    if (!_isHost) return; // joiners are read-only here
    setState(() {
      if (_selectedIds.contains(category.id)) {
        _selectedIds.remove(category.id);
      } else {
        if (_selectedIds.length < 8) {
          _selectedIds.add(category.id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.maxCategoriesWarning)),
          );
        }
      }
      _selectedCategories
        ..clear()
        ..addAll(
            _selectedIds.map((id) => _catalogById[id]).whereType<Category>());
    });
    // Broadcast live selection so joiners can see
    _lobbyService.updateSelectedCategories(
        widget.room.code, List<Category>.from(_selectedCategories));
  }

  void _startGame() {
    if (!_isHost) return;
    if (_selectedIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                AppLocalizations.of(context)!.pleaseSelectAtLeastOneCategory)),
      );
      return;
    }
    // Prepare questions with host settings; listeners will navigate
    _lobbyService.prepareQuestionsAndStart(
      roomCode: widget.room.code,
      categories: List<Category>.from(_selectedCategories),
      difficulty: _difficulty,
      count: _questionCount,
      langCode: Localizations.localeOf(context).languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(loc.selectCategoriesTitle),
        backgroundColor: const Color(0xFFCE1126),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  loc.selectCountLabel,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryBlack,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loc.selectedCountStatus(_selectedCategories.length),
                  style: TextStyle(
                    color: _selectedCategories.length >= 5
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Categories Grid
          if (_isHost)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _difficulty,
                      items: [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text(loc.difficultyAll),
                        ),
                        DropdownMenuItem(
                          value: 'easy',
                          child: Text(loc.difficultyEasy),
                        ),
                        DropdownMenuItem(
                          value: 'medium',
                          child: Text(loc.difficultyMedium),
                        ),
                        DropdownMenuItem(
                          value: 'hard',
                          child: Text(loc.difficultyHard),
                        ),
                      ],
                      onChanged: (v) =>
                          setState(() => _difficulty = v ?? 'all'),
                      decoration:
                          InputDecoration(labelText: loc.difficultyLabel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: _questionCount,
                      items: [5, 10, 15, 20]
                          .map((n) => DropdownMenuItem(
                              value: n,
                              child: Text(
                                  '${n} ${loc.questionsLabel.toLowerCase()}')))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _questionCount = v ?? 10),
                      decoration:
                          InputDecoration(labelText: loc.questionsLabel),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: StreamBuilder<List<Category>>(
              stream: _questionService.watchCategories(),
              builder: (context, snap) {
                final cats = (snap.data ?? []);
                // Fallback to bundled defaults if Firestore empty
                final effective = cats.isNotEmpty ? cats : defaultCategories();
                _availableCategories = effective;
                _catalogById = {for (final c in effective) c.id: c};
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    // Fix overflow: slightly reduce aspect ratio for better fit
                    childAspectRatio: 0.90,
                  ),
                  itemCount: effective.length,
                  itemBuilder: (context, index) {
                    final category = effective[index];
                    final isSelected = _selectedIds.contains(category.id);
                    return _buildCategoryCard(category, isSelected, loc);
                  },
                );
              },
            ),
          ),

          // Start Game Button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: _isHost
                  ? ElevatedButton(
                      onPressed: _selectedIds.length >= 5 ? _startGame : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007A3D),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        loc.startGameButton(_selectedIds.length),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Text(
                      loc.waitingForHost,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      Category category, bool isSelected, AppLocalizations loc) {
    String _nameFor(Category c) {
      final lang = Localizations.localeOf(context).languageCode;
      // If current locale is English, just show what we have
      if (lang == 'en') return c.name;
      // If Firestore already localized it (not equal to default EN), use it
      final defaultEnName =
          {for (final cat in defaultCategories()) cat.id: cat.name}[c.id];
      if (c.name.isNotEmpty && c.name != (defaultEnName ?? '')) return c.name;
      // Fallback to ARB keys for defaults
      try {
        switch (c.id) {
          case '1':
            return (loc as dynamic).cat_1Name as String;
          case '2':
            return (loc as dynamic).cat_2Name as String;
          case '3':
            return (loc as dynamic).cat_3Name as String;
          case '4':
            return (loc as dynamic).cat_4Name as String;
          case '5':
            return (loc as dynamic).cat_5Name as String;
          case '6':
            return (loc as dynamic).cat_6Name as String;
          case '7':
            return (loc as dynamic).cat_7Name as String;
          case '8':
            return (loc as dynamic).cat_8Name as String;
        }
      } catch (_) {}
      return c.name;
    }

    String _descFor(Category c) {
      final lang = Localizations.localeOf(context).languageCode;
      if (lang == 'en') return c.description;
      final defaultEnDesc = {
        for (final cat in defaultCategories()) cat.id: cat.description
      }[c.id];
      if (c.description.isNotEmpty && c.description != (defaultEnDesc ?? '')) {
        return c.description;
      }
      try {
        switch (c.id) {
          case '1':
            return (loc as dynamic).cat_1Desc as String;
          case '2':
            return (loc as dynamic).cat_2Desc as String;
          case '3':
            return (loc as dynamic).cat_3Desc as String;
          case '4':
            return (loc as dynamic).cat_4Desc as String;
          case '5':
            return (loc as dynamic).cat_5Desc as String;
          case '6':
            return (loc as dynamic).cat_6Desc as String;
          case '7':
            return (loc as dynamic).cat_7Desc as String;
          case '8':
            return (loc as dynamic).cat_8Desc as String;
        }
      } catch (_) {}
      return c.description;
    }

    Color getCategoryColor(CategoryType type) {
      switch (type) {
        case CategoryType.trivia:
          return Colors.blue;
        case CategoryType.physical:
          return Colors.orange;
        case CategoryType.karaoke:
          return Colors.purple;
        case CategoryType.miniGame:
          return Colors.green;
      }
    }

    return GestureDetector(
      onTap: () => _toggleCategory(category),
      child: Card(
        color: isSelected
            ? getCategoryColor(category.type).withOpacity(0.2)
            : Colors.white,
        elevation: 2,
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(
                    color: getCategoryColor(category.type),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              // Don't use MainAxisAlignment.center, let content expand naturally then clip/ellipsis
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image display for category
                SizedBox(
                  height: 100,
                  width: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      category.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _nameFor(category),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryBlack,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _descFor(category),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // If you want an informational icon at the top-right in future, can add as Stack
              ],
            ),
          ),
        ),
      ),
    );
  }
}
