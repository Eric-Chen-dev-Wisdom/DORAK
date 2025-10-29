class Category {
  final String id;
  final String name;
  final String description;
  final CategoryType type;
  final List<Challenge> challenges;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.challenges,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.toString(),
      'challenges': challenges.map((challenge) => challenge.toJson()).toList(),
    };
  }

  // Add this missing fromJson factory method
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: CategoryType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => CategoryType.trivia,
      ),
      challenges: (json['challenges'] as List?)
              ?.map((challengeJson) => Challenge.fromJson(challengeJson))
              .toList() ??
          [],
    );
  }
}

enum CategoryType {
  trivia,
  physical,
  karaoke,
  miniGame,
}

class Challenge {
  final String id;
  final String question;
  final List<String>? options;
  final String? correctAnswer;
  final String? mediaUrl;
  final ChallengeDifficulty difficulty;

  Challenge({
    required this.id,
    required this.question,
    this.options,
    this.correctAnswer,
    this.mediaUrl,
    this.difficulty = ChallengeDifficulty.easy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'mediaUrl': mediaUrl,
      'difficulty': difficulty.toString(),
    };
  }

  // Add this missing fromJson factory method
  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      options: (json['options'] as List?)?.cast<String>(),
      correctAnswer: json['correctAnswer'],
      mediaUrl: json['mediaUrl'],
      difficulty: ChallengeDifficulty.values.firstWhere(
        (e) => e.toString() == json['difficulty'],
        orElse: () => ChallengeDifficulty.easy,
      ),
    );
  }
}

enum ChallengeDifficulty {
  easy,
  medium,
  hard,
}