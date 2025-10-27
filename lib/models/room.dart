class Room {
  final String id;
  final String code;
  final List<String> teamA;
  final List<String> teamB;
  final List<String> selectedCategories;
  final bool isGameStarted;

  Room({
    required this.id,
    required this.code,
    this.teamA = const [],
    this.teamB = const [],
    this.selectedCategories = const [],
    this.isGameStarted = false,
  });
}