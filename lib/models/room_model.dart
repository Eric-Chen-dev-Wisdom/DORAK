import 'user_model.dart';
import 'category_model.dart';

class GameRoom {
  final String code;
  final String hostId;
  List<UserModel> teamA;
  List<UserModel> teamB;
  List<Category> selectedCategories;
  GameState state;
  final DateTime createdAt;
  int currentRound;
  final Map<String, int> scores;
  final int maxPlayers;

  Map<String, Map<String, int>> teamVotes;
  bool votingInProgress;
  int? correctAnswerIndex;
  Map<String, List<int>> voteHistory;

  int currentTimer;
  String currentQuestionId;
  bool isTimerRunning;
  List<String> usedPowerCards;
  // UI/event signals
  int shareNonce;
  String? shareBy;
  final String? lastEvent;


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
    required this.teamVotes,
    this.votingInProgress = false,
    this.correctAnswerIndex,
    required this.voteHistory,
    this.shareNonce = 0,
    this.shareBy,
    this.lastEvent,
  })  : scores = scores ?? {'teamA': 0, 'teamB': 0},
        usedPowerCards = usedPowerCards ?? [];

  factory GameRoom.createNew({
    required String code,
    required String hostId,
    required String hostName,
  }) {
    final hostUser = UserModel.guest(hostName);
    return GameRoom(
      code: code,
      hostId: hostId,
      teamA: [hostUser],
      teamB: [],
      selectedCategories: [],
      state: GameState.waiting,
      createdAt: DateTime.now(),
      maxPlayers: 10,
      teamVotes: {'A': {}, 'B': {}},
      voteHistory: {'A': [], 'B': []},
    );
  }

  int get teamAPoints => scores['teamA'] ?? 0;
  int get teamBPoints => scores['teamB'] ?? 0;

  void updatePoints(int teamAPoints, int teamBPoints) {
    scores['teamA'] = teamAPoints;
    scores['teamB'] = teamBPoints;
  }

  void updateTimer(int timer) {
    currentTimer = timer;
  }

  void usePowerCard(String card) {
    if (!usedPowerCards.contains(card)) {
      usedPowerCards.add(card);
    }
  }

  void startVoting() {
    votingInProgress = true;
    teamVotes = {'A': {}, 'B': {}};

    for (var user in teamA) {
      user.clearVote();
    }
    for (var user in teamB) {
      user.clearVote();
    }
  }

  void submitVote(String team, int answerIndex, String userId) {
    if (!votingInProgress) return;

    final teamUsers = team == 'A' ? teamA : teamB;
    final user = teamUsers.firstWhere((u) => u.id == userId);
    user.submitVote(answerIndex);

    final currentVotes = teamVotes[team]!;
    final answerKey = answerIndex.toString();
    currentVotes[answerKey] = (currentVotes[answerKey] ?? 0) + 1;
  }

  Map<String, int> getTeamFinalAnswers() {
    final result = <String, int>{};

    for (final team in ['A', 'B']) {
      final votes = teamVotes[team]!;
      if (votes.isEmpty) {
        result[team] = -1;
        continue;
      }

      int maxVotes = 0;
      String? mostVotedAnswer;

      votes.forEach((answerKey, voteCount) {
        if (voteCount > maxVotes) {
          maxVotes = voteCount;
          mostVotedAnswer = answerKey;
        }
      });

      // FIXED: Use null-aware operator with tryParse for safety
      result[team] = int.tryParse(mostVotedAnswer ?? '-1') ?? -1;
    }

    return result;
  }

  int getVoteCountForTeam(String team, int answerIndex) {
    return teamVotes[team]?[answerIndex.toString()] ?? 0;
  }

  int getTotalVotesForTeam(String team) {
    final votes = teamVotes[team]!;
    return votes.values.fold(0, (sum, count) => sum + count);
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'hostId': hostId,
      'teamA': teamA.map((user) => user.toJson()).toList(),
      'teamB': teamB.map((user) => user.toJson()).toList(),
      'selectedCategories':
          selectedCategories.map((cat) => cat.toJson()).toList(),
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
      'shareNonce': shareNonce,
      'shareBy': shareBy,
      'lastEvent': lastEvent,

    };
  }

  factory GameRoom.fromJson(Map<String, dynamic> json) {
    Map<String, Map<String, int>> parseTeamVotes(
        Map<String, dynamic>? votesJson) {
      final result = <String, Map<String, int>>{'A': {}, 'B': {}};
      if (votesJson != null) {
        votesJson.forEach((team, votes) {
          if (votes is Map) {
            votes.forEach((answerKey, count) {
              result[team]![answerKey.toString()] = (count as num).toInt();
            });
          }
        });
      }
      return result;
    }

    Map<String, List<int>> parseVoteHistory(Map<String, dynamic>? historyJson) {
      final result = <String, List<int>>{'A': [], 'B': []};
      if (historyJson != null) {
        historyJson.forEach((team, history) {
          if (history is List) {
            result[team] =
                history.map((item) => (item as num).toInt()).toList();
          }
        });
      }
      return result;
    }

    return GameRoom(
      code: json['code'] ?? '',
      hostId: json['hostId'] ?? '',
      teamA: (json['teamA'] as List?)
              ?.map((userJson) => UserModel.fromJson(userJson))
              .toList() ??
          [],
      teamB: (json['teamB'] as List?)
              ?.map((userJson) => UserModel.fromJson(userJson))
              .toList() ??
          [],
      selectedCategories: (json['selectedCategories'] as List?)
              ?.map((catJson) => Category.fromJson(catJson))
              .toList() ??
          [],
      state: GameState.values.firstWhere(
          (e) => e.toString() == (json['state'] ?? 'GameState.waiting'),
          orElse: () => GameState.waiting),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      maxPlayers: json['maxPlayers'] ?? 10,
      currentRound: json['currentRound'] ?? 0,
      scores: Map<String, int>.from(json['scores'] ?? {}),
      currentTimer: json['currentTimer'] ?? 60,
      currentQuestionId: json['currentQuestionId'] ?? '',
      isTimerRunning: json['isTimerRunning'] ?? false,
      usedPowerCards: List<String>.from(json['usedPowerCards'] ?? []),
      teamVotes: parseTeamVotes(json['teamVotes']),
      votingInProgress: json['votingInProgress'] ?? false,
      correctAnswerIndex: json['correctAnswerIndex'],
      voteHistory:
          parseVoteHistory(json['voteHistory']), // FIXED: Use new parser
      shareNonce: (json['shareNonce'] as num?)?.toInt() ?? 0,
      shareBy: json['shareBy'],
      lastEvent: json['lastEvent'], 

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
