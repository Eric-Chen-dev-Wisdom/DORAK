class PowerCard {
  final String id;
  final String name;
  final String description;
  final PowerCardType type;
  final int usesRemaining;

  PowerCard({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.usesRemaining = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.toString(),
      'usesRemaining': usesRemaining,
    };
  }
}

enum PowerCardType {
  doublePoints,
  stealPoints,
  skipRound,
  hostDecide,
  extraTime,
}
