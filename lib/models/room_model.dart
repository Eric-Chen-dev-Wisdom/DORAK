import 'user_model.dart';
import 'category_model.dart';

class GameRoom {
  final String code;
  final String hostId;
  final List<UserModel> teamA;
  final List<UserModel> teamB;
  final List<Category> selectedCategories;
  final GameState state;
  final DateTime createdAt;
  final int currentRound;
  final Map<String, int> scores;

  GameRoom({
    required this.code,
    required this.hostId,
    required this.teamA,
    required this.teamB,
    required this.selectedCategories,
    required this.state,
    required this.createdAt,
    this.currentRound = 0,
    this.scores = const {},
  });

  factory GameRoom.create(String hostId, String code) {
    return GameRoom(
      code: code,
      hostId: hostId,
      teamA: [],
      teamB: [],
      selectedCategories: [],
      state: GameState.waiting,
      createdAt: DateTime.now(),
      scores: {'teamA': 0, 'teamB': 0},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'hostId': hostId,
      'teamA': teamA.map((user) => user.toJson()).toList(),
      'teamB': teamB.map((user) => user.toJson()).toList(),
      'selectedCategories': selectedCategories.map((cat) => cat.toJson()).toList(),
      'state': state.toString(),
      'createdAt': createdAt.toIso8601String(),
      'currentRound': currentRound,
      'scores': scores,
    };
  }
}

enum GameState {
  waiting,
  categorySelection,
  inGame,
  roundComplete,
  gameComplete,
}