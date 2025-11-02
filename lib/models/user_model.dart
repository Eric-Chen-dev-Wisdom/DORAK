// models/user_model.dart
class UserModel {
  final String id;
  final String displayName;
  final String? email; // FIXED: Make email nullable
  final String? photoUrl;
  final UserType type;
  final DateTime createdAt;
  int? currentVote;
  bool hasVoted;

  UserModel({
    required this.id,
    required this.displayName,
    this.email, // FIXED: Remove 'required' since it's nullable
    this.photoUrl,
    required this.type,
    required this.createdAt,
    this.currentVote,
    bool? hasVoted,
  }) : hasVoted = hasVoted ?? false;

  factory UserModel.guest(String name) {
    return UserModel(
      id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      displayName: name,
      email: null, // FIXED: Now this is allowed
      type: UserType.guest,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'type': type.toString(),
      'createdAt': createdAt.toIso8601String(),
      'currentVote': currentVote,
      'hasVoted': hasVoted,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      displayName: json['displayName'] ?? '',
      email: json['email'], // FIXED: Can be null
      photoUrl: json['photoUrl'],
      type: UserType.values.firstWhere(
        (e) => e.toString() == (json['type'] ?? 'UserType.guest'),
        orElse: () => UserType.guest,
      ),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      currentVote: json['currentVote'],
      hasVoted: json['hasVoted'] ?? false,
    );
  }

  void submitVote(int answerIndex) {
    currentVote = answerIndex;
    hasVoted = true;
  }

  void clearVote() {
    currentVote = null;
    hasVoted = false;
  }
}

enum UserType {
  guest,
  email,
  google,
  apple,
  admin,
}
