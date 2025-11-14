import '../models/category_model.dart';

// Default categories bundled with the app (no challenges yet)
List<Category> defaultCategories() => [
      Category(
        id: '1',
        name: 'General Knowledge',
        description: 'Test your general knowledge',
        type: CategoryType.trivia,
        challenges: const [],
        imageAsset: 'assets/images/general_knowledge.png',
      ),
      Category(
        id: '2',
        name: 'Family Life',
        description: 'Fun questions about family',
        type: CategoryType.trivia,
        challenges: const [],
        imageAsset: 'assets/images/family.png',
      ),
      Category(
        id: '3',
        name: 'Gulf Culture',
        description: 'Questions about Gulf traditions',
        type: CategoryType.trivia,
        challenges: const [],
        imageAsset: 'assets/images/gulf.png',
      ),
      Category(
        id: '4',
        name: 'Movies & TV',
        description: 'Guess movies and TV shows',
        type: CategoryType.trivia,
        challenges: const [],
        imageAsset: 'assets/images/movie.png',
      ),
      Category(
        id: '5',
        name: 'Music',
        description: 'Music trivia and karaoke',
        type: CategoryType.karaoke,
        challenges: const [],
        imageAsset: 'assets/images/music.png',
      ),
      Category(
        id: '6',
        name: 'Funny Challenges',
        description: 'Hilarious physical challenges',
        type: CategoryType.physical,
        challenges: const [],
        imageAsset: 'assets/images/funny_challenge.png',
      ),
      Category(
        id: '7',
        name: 'Kids Corner',
        description: 'Fun for the little ones',
        type: CategoryType.trivia,
        challenges: const [],
        imageAsset: 'assets/images/kids_corner.png',
      ),
      Category(
        id: '8',
        name: 'Quick Thinking',
        description: 'Fast-paced brain teasers',
        type: CategoryType.trivia,
        challenges: const [],
        imageAsset: 'assets/images/quick_thinking.png',
      ),
    ];
