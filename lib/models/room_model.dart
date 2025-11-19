import 'user_model.dart';
import 'category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  DateTime timerUpdatedAt; // Changed to non-nullable
  // UI/event signals
  int shareNonce;
  String? shareBy;
  String? lastEvent;
  bool chatEnabled;
  // Game preparation by host
  int questionCount;
  String selectedDifficulty; // 'all', 'easy', 'medium', 'hard'
  List<Map<String, dynamic>> preparedQuestions;

  // Scoring enhancements
  int teamAStreak; // Consecutive correct answers for Team A
  int teamBStreak; // Consecutive correct answers for Team B
  DateTime? votingStartedAt; // When current voting started (for speed bonus)
  Map<String, DateTime> voteTimestamps; // userId -> vote timestamp

  // Jackpot system
  bool isJackpotQuestion; // Is current question a jackpot?
  int? jackpotPoints; // Random jackpot value (200-600)
  bool jackpotAccepted; // Did teams accept the jackpot risk?

  // Question anti-repetition system
  List<String> usedQuestionIds; // Track used question IDs to prevent repeats

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
    this.chatEnabled = true,
    int? questionCount,
    String? selectedDifficulty,
    List<Map<String, dynamic>>? preparedQuestions,
    required this.timerUpdatedAt,
    this.teamAStreak = 0,
    this.teamBStreak = 0,
    this.votingStartedAt,
    Map<String, DateTime>? voteTimestamps,
    this.isJackpotQuestion = false,
    this.jackpotPoints,
    this.jackpotAccepted = false,
    List<String>? usedQuestionIds,
  })  : scores = scores ?? {'teamA': 0, 'teamB': 0},
        usedPowerCards = usedPowerCards ?? [],
        questionCount = questionCount ?? 10,
        selectedDifficulty = selectedDifficulty ?? 'all',
        preparedQuestions = preparedQuestions ?? [],
        voteTimestamps = voteTimestamps ?? {},
        usedQuestionIds = usedQuestionIds ?? [];

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
      timerUpdatedAt: DateTime.now(), // Initialize timerUpdatedAt
    );
  }

  GameRoom copyWith({
    String? code,
    String? hostId,
    List<UserModel>? teamA,
    List<UserModel>? teamB,
    List<Category>? selectedCategories,
    GameState? state,
    DateTime? createdAt,
    int? currentRound,
    Map<String, int>? scores,
    int? maxPlayers,
    Map<String, Map<String, int>>? teamVotes,
    bool? votingInProgress,
    int? correctAnswerIndex,
    Map<String, List<int>>? voteHistory,
    int? currentTimer,
    String? currentQuestionId,
    bool? isTimerRunning,
    List<String>? usedPowerCards,
    int? shareNonce,
    String? shareBy,
    String? lastEvent,
    bool? chatEnabled,
    int? questionCount,
    String? selectedDifficulty,
    List<Map<String, dynamic>>? preparedQuestions,
    DateTime? timerUpdatedAt,
    int? teamAStreak,
    int? teamBStreak,
    DateTime? votingStartedAt,
    Map<String, DateTime>? voteTimestamps,
    bool? isJackpotQuestion,
    int? jackpotPoints,
    bool? jackpotAccepted,
    List<String>? usedQuestionIds,
  }) {
    return GameRoom(
      code: code ?? this.code,
      hostId: hostId ?? this.hostId,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      currentRound: currentRound ?? this.currentRound,
      scores: scores ?? this.scores,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      teamVotes: teamVotes ?? this.teamVotes,
      votingInProgress: votingInProgress ?? this.votingInProgress,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      voteHistory: voteHistory ?? this.voteHistory,
      currentTimer: currentTimer ?? this.currentTimer,
      currentQuestionId: currentQuestionId ?? this.currentQuestionId,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      usedPowerCards: usedPowerCards ?? this.usedPowerCards,
      shareNonce: shareNonce ?? this.shareNonce,
      shareBy: shareBy ?? this.shareBy,
      lastEvent: lastEvent ?? this.lastEvent,
      chatEnabled: chatEnabled ?? this.chatEnabled,
      questionCount: questionCount ?? this.questionCount,
      selectedDifficulty: selectedDifficulty ?? this.selectedDifficulty,
      preparedQuestions: preparedQuestions ?? this.preparedQuestions,
      timerUpdatedAt: timerUpdatedAt ?? this.timerUpdatedAt,
      teamAStreak: teamAStreak ?? this.teamAStreak,
      teamBStreak: teamBStreak ?? this.teamBStreak,
      votingStartedAt: votingStartedAt ?? this.votingStartedAt,
      voteTimestamps: voteTimestamps ?? this.voteTimestamps,
      isJackpotQuestion: isJackpotQuestion ?? this.isJackpotQuestion,
      jackpotPoints: jackpotPoints ?? this.jackpotPoints,
      jackpotAccepted: jackpotAccepted ?? this.jackpotAccepted,
      usedQuestionIds: usedQuestionIds ?? this.usedQuestionIds,
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
      'chatEnabled': chatEnabled,
      'questionCount': questionCount,
      'selectedDifficulty': selectedDifficulty,
      'preparedQuestions': preparedQuestions,
      'teamAStreak': teamAStreak,
      'teamBStreak': teamBStreak,
      'votingStartedAt': votingStartedAt?.toIso8601String(),
      'voteTimestamps': voteTimestamps
          .map((key, value) => MapEntry(key, value.toIso8601String())),
      'isJackpotQuestion': isJackpotQuestion,
      'jackpotPoints': jackpotPoints,
      'jackpotAccepted': jackpotAccepted,
      'usedQuestionIds': usedQuestionIds,
      // Intentionally omit timerUpdatedAt here so only setTimer() controls it
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
      chatEnabled: json['chatEnabled'] ?? true,
      questionCount: (json['questionCount'] as num?)?.toInt() ?? 10,
      selectedDifficulty: (json['selectedDifficulty'] ?? 'all') as String,
      preparedQuestions: List<Map<String, dynamic>>.from(
          (json['preparedQuestions'] as List?) ?? const []),
      // Use server timestamp only; avoid host clock skew
      timerUpdatedAt:
          _parseDateTimeFromDynamic(json['timerUpdatedAt']) ?? DateTime.now(),
      teamAStreak: (json['teamAStreak'] as num?)?.toInt() ?? 0,
      teamBStreak: (json['teamBStreak'] as num?)?.toInt() ?? 0,
      votingStartedAt: _parseDateTimeFromDynamic(json['votingStartedAt']),
      voteTimestamps: _parseVoteTimestamps(json['voteTimestamps']),
      isJackpotQuestion: json['isJackpotQuestion'] ?? false,
      jackpotPoints: (json['jackpotPoints'] as num?)?.toInt(),
      jackpotAccepted: json['jackpotAccepted'] ?? false,
      usedQuestionIds: List<String>.from(json['usedQuestionIds'] ?? []),
    );
  }

  static Map<String, DateTime> _parseVoteTimestamps(dynamic value) {
    if (value == null) return {};
    if (value is! Map) return {};
    final result = <String, DateTime>{};
    value.forEach((key, val) {
      if (key is String) {
        final dt = _parseDateTimeFromDynamic(val);
        if (dt != null) result[key] = dt;
      }
    });
    return result;
  }
}

DateTime? _parseDateTimeFromDynamic(dynamic value) {
  // Be tolerant: Firestore may return null for serverTimestamp on first local snapshot.
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  if (value is int) {
    // Support optional millisecond epoch if ever provided
    try {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } catch (_) {
      return null;
    }
  }
  return null;
}

enum GameState {
  waiting,
  categorySelection,
  inGame,
  roundComplete,
  gameComplete,
}
