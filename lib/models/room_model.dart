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
  final int maxPlayers;
  
  // Add voting properties
  Map<String, Map<int, int>> teamVotes; // team -> {answerIndex -> voteCount}
  bool votingInProgress;
  int? correctAnswerIndex;
  Map<String, List<int>> voteHistory; // team -> list of voted answers

  int currentTimer;
  String currentQuestionId;
  bool isTimerRunning;
  List<String> usedPowerCards;
  
  GameRoom({
    required this.code,
    required this.hostId,
    required this.teamA,
    required this.teamB,
    required this.selectedCategories,
    required this.state,
    required this.createdAt,
    required this.maxPlayers,
    this.currentRound = 0,
    Map<String, int>? scores,
    this.currentTimer = 60,
    this.currentQuestionId = '',
    this.isTimerRunning = false,
    List<String>? usedPowerCards,
    required Map<String, Map<int, int>> teamVotes, // CHANGED: removed ? to make it required
    this.votingInProgress = false,
    this.correctAnswerIndex,
    required Map<String, List<int>> voteHistory, // CHANGED: removed ? to make it required
  }) : scores = scores ?? {'teamA': 0, 'teamB': 0},
       usedPowerCards = usedPowerCards ?? [],
       // FIX: No longer need null check since they're required
       teamVotes = teamVotes,
       voteHistory = voteHistory;

  // REMOVED the problematic factory method - use main constructor instead

  // Get team points from scores map
  int get teamAPoints => scores['teamA'] ?? 0;
  int get teamBPoints => scores['teamB'] ?? 0;

  // Add this method to update points
  void updatePoints(int teamAPoints, int teamBPoints) {
    scores['teamA'] = teamAPoints;
    scores['teamB'] = teamBPoints;
  }

  // Add this method to update timer
  void updateTimer(int timer) {
    currentTimer = timer;
  }

  // Add this method to use power card
  void usePowerCard(String card) {
    usedPowerCards.add(card);
  }

  // Add voting methods
  void startVoting() {
    votingInProgress = true;
    teamVotes = {'A': {}, 'B': {}};
    voteHistory = {'A': [], 'B': []};
    
    // Clear all player votes
    for (var user in teamA) {
      user.clearVote();
    }
    for (var user in teamB) {
      user.clearVote();
    }
  }

  void submitVote(String team, int answerIndex, String userId) {
    if (!votingInProgress) return;

    // Find user and update their vote
    final teamUsers = team == 'A' ? teamA : teamB;
    final user = teamUsers.firstWhere((u) => u.id == userId);
    user.submitVote(answerIndex);

    // Update team votes 
    final currentVotes = teamVotes[team]!; 
    currentVotes[answerIndex] = (currentVotes[answerIndex] ?? 0) + 1;
  }

  Map<String, int> getTeamFinalAnswers() {
    final result = <String, int>{};
    
    for (final team in ['A', 'B']) {
      final votes = teamVotes[team]!;
      if (votes.isEmpty) {
        result[team] = -1; // No votes
        continue;
      }
      
      // Find answer with most votes
      final maxVotes = votes.values.reduce((a, b) => a > b ? a : b);
      final mostVotedAnswers = votes.entries
          .where((entry) => entry.value == maxVotes)
          .map((entry) => entry.key)
          .toList();
      
      // If tie, use the first vote in history as tiebreaker
      if (mostVotedAnswers.length > 1) {
        final teamHistory = voteHistory[team]!; 
        if (teamHistory.isNotEmpty) {
          result[team] = teamHistory.first;
        } else {
          result[team] = mostVotedAnswers.first;
        }
      } else {
        result[team] = mostVotedAnswers.first;
      }
    }
    
    return result;
  }

  int getVoteCountForTeam(String team, int answerIndex) {
    return teamVotes[team]?[answerIndex] ?? 0;
  }

  int getTotalVotesForTeam(String team) {
    final votes = teamVotes[team]!; 
    return votes.values.fold(0, (sum, count) => sum + count);
  }

  double getVotePercentageForTeam(String team, int answerIndex) {
    final totalVotes = getTotalVotesForTeam(team);
    if (totalVotes == 0) return 0.0;
    return (getVoteCountForTeam(team, answerIndex) / totalVotes) * 100;
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
      'maxPlayers': maxPlayers,
      'currentTimer': currentTimer,
      'currentQuestionId': currentQuestionId,
      'isTimerRunning': isTimerRunning,
      'usedPowerCards': usedPowerCards,
      'teamVotes': teamVotes,
      'votingInProgress': votingInProgress,
      'correctAnswerIndex': correctAnswerIndex,
      'voteHistory': voteHistory,
    };
  }

  factory GameRoom.fromJson(Map<String, dynamic> json) {
    return GameRoom(
      code: json['code'] ?? '',
      hostId: json['hostId'] ?? '',
      teamA: (json['teamA'] as List?)?.map((userJson) => UserModel.fromJson(userJson)).toList() ?? [],
      teamB: (json['teamB'] as List?)?.map((userJson) => UserModel.fromJson(userJson)).toList() ?? [],
      selectedCategories: (json['selectedCategories'] as List?)?.map((catJson) => Category.fromJson(catJson)).toList() ?? [],
      state: GameState.values.firstWhere((e) => e.toString() == (json['state'] ?? 'GameState.waiting'), orElse: () => GameState.waiting),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      maxPlayers: json['maxPlayers'] ?? 10,
      currentRound: json['currentRound'] ?? 0,
      scores: Map<String, int>.from(json['scores'] ?? {}),
      currentTimer: json['currentTimer'] ?? 60,
      currentQuestionId: json['currentQuestionId'] ?? '',
      isTimerRunning: json['isTimerRunning'] ?? false,
      usedPowerCards: List<String>.from(json['usedPowerCards'] ?? []),
      teamVotes: Map<String, Map<int, int>>.from(json['teamVotes'] ?? {'A': {}, 'B': {}}), // FIX: Added default
      votingInProgress: json['votingInProgress'] ?? false,
      correctAnswerIndex: json['correctAnswerIndex'],
      voteHistory: Map<String, List<int>>.from(json['voteHistory'] ?? {'A': [], 'B': []}), // FIX: Added default
    );
  }
}

enum GameState {
  waiting,
  categorySelection,
  inGame,
  roundComplete,
  gameComplete,
}