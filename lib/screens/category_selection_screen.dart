// screens/category_selection_screen.dart
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../data/default_categories.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import 'game_screen.dart';
import '../services/lobby_service.dart';
import 'dart:async';

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
  final List<Category> _availableCategories = defaultCategories();

  final List<Category> _selectedCategories = [];
  final Set<String> _selectedIds = <String>{};
  late final Map<String, Category> _catalogById;

  bool get _isHost => widget.user.id == widget.room.hostId;

  @override
  void initState() {
    super.initState();
    _catalogById = {for (final c in _availableCategories) c.id: c};
    // Start with any existing selections (dedup by id)
    _selectedIds.addAll(widget.room.selectedCategories.map((c) => c.id));
    _selectedCategories
      ..clear()
      ..addAll(_selectedIds.map((id) => _catalogById[id]).whereType<Category>());
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
          ..addAll(_selectedIds
              .map((id) => _catalogById[id])
              .whereType<Category>());
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
            const SnackBar(content: Text('Maximum 8 categories allowed')),
          );
        }
      }
      _selectedCategories
        ..clear()
        ..addAll(_selectedIds
            .map((id) => _catalogById[id])
            .whereType<Category>());
    });
    // Broadcast live selection so joiners can see
    _lobbyService.updateSelectedCategories(
        widget.room.code, List<Category>.from(_selectedCategories));
  }

  void _startGame() {
    if (!_isHost) return;
    if (_selectedIds.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least 5 categories')),
      );
      return;
    }
    // Persist categories and advance state; listeners will navigate
    _lobbyService.finalizeCategoriesAndStart(
        widget.room.code, List<Category>.from(_selectedCategories));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Select Categories'),
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
                  'Select 5-8 Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryBlack,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_selectedCategories.length} selected (Min: 5, Max: 8)',
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
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                // Fix overflow: slightly reduce aspect ratio for better fit
                childAspectRatio: 0.90,
              ),
              itemCount: _availableCategories.length,
              itemBuilder: (context, index) {
                final category = _availableCategories[index];
                final isSelected = _selectedIds.contains(category.id);
                return _buildCategoryCard(category, isSelected);
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
                        'Start Game (${_selectedIds.length}/5)',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : const Text(
                      'Waiting for host to select categories...',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Category category, bool isSelected) {
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
                  category.name,
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
                  category.description,
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
