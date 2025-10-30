// screens/category_selection_screen.dart
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import 'game_screen.dart';

class CategorySelectionScreen extends StatefulWidget {
  final GameRoom room;
  final UserModel user;

  const CategorySelectionScreen({
    super.key,
    required this.room,
    required this.user,
  });

  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final List<Category> _availableCategories = [
    Category(
      id: '1',
      name: 'General Knowledge',
      description: 'Test your general knowledge',
      type: CategoryType.trivia,
      challenges: [],
    ),
    Category(
      id: '2',
      name: 'Family Life',
      description: 'Fun questions about family',
      type: CategoryType.trivia,
      challenges: [],
    ),
    Category(
      id: '3', 
      name: 'Gulf Culture',
      description: 'Questions about Gulf traditions',
      type: CategoryType.trivia,
      challenges: [],
    ),
    Category(
      id: '4',
      name: 'Movies & TV',
      description: 'Guess movies and TV shows',
      type: CategoryType.trivia, 
      challenges: [],
    ),
    Category(
      id: '5',
      name: 'Music',
      description: 'Music trivia and karaoke',
      type: CategoryType.karaoke,
      challenges: [],
    ),
    Category(
      id: '6',
      name: 'Funny Challenges',
      description: 'Hilarious physical challenges',
      type: CategoryType.physical,
      challenges: [],
    ),
    Category(
      id: '7',
      name: 'Kids Corner',
      description: 'Fun for the little ones',
      type: CategoryType.trivia,
      challenges: [],
    ),
    Category(
      id: '8',
      name: 'Quick Thinking',
      description: 'Fast-paced brain teasers',
      type: CategoryType.trivia,
      challenges: [],
    ),
  ];

  final List<Category> _selectedCategories = [];

  void _toggleCategory(Category category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        if (_selectedCategories.length < 8) {
          _selectedCategories.add(category);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Maximum 8 categories allowed')),
          );
        }
      }
    });
  }

  void _startGame() {
    if (_selectedCategories.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least 5 categories')),
      );
      return;
    }

    // Update room with selected categories
    final updatedRoom = GameRoom(
      code: widget.room.code,
      hostId: widget.room.hostId,
      teamA: widget.room.teamA,
      teamB: widget.room.teamB,
      selectedCategories: _selectedCategories,
      state: GameState.inGame,
      createdAt: widget.room.createdAt,
      maxPlayers: widget.room.maxPlayers,
      currentRound: 0,
      scores: widget.room.scores,
      currentTimer: 60,
      currentQuestionId: '',
      isTimerRunning: false,
      usedPowerCards: [],
      teamVotes: {'A': {}, 'B': {}},
      voteHistory: {'A': [], 'B': []},
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          room: updatedRoom,
          user: widget.user,
          isHost: true,
        ),
      ),
    );
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
                    color: _selectedCategories.length >= 5 ? Colors.green : Colors.orange,
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
                childAspectRatio: 1.2,
              ),
              itemCount: _availableCategories.length,
              itemBuilder: (context, index) {
                final category = _availableCategories[index];
                final isSelected = _selectedCategories.contains(category);
                
                return _buildCategoryCard(category, isSelected);
              },
            ),
          ),

          // Start Game Button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedCategories.length >= 5 ? _startGame : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007A3D),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Start Game (${_selectedCategories.length}/5)',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Category category, bool isSelected) {
    IconData getCategoryIcon(CategoryType type) {
      switch (type) {
        case CategoryType.trivia:
          return Icons.quiz;
        case CategoryType.physical:
          return Icons.fitness_center;
        case CategoryType.karaoke:
          return Icons.music_note;
        case CategoryType.miniGame:
          return Icons.videogame_asset;
      }
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
        color: isSelected ? getCategoryColor(category.type).withOpacity(0.2) : Colors.white,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  getCategoryIcon(category.type),
                  color: getCategoryColor(category.type),
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryBlack,
                  ),
                  maxLines: 2,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}