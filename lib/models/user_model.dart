class User {
  final String id;
  final String displayName;
  final String email;
  final String? photoUrl;
  final UserType type;
  final DateTime createdAt;

  User({
    required this.id,
    required this.displayName,
    required this.email,
    this.photoUrl,
    required this.type,
    required this.createdAt,
  });

  factory User.guest(String name) {
    return User(
      id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      displayName: name,
      email: '',
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
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      type: UserType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => UserType.guest,
      ),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

enum UserType {
  guest,
  email,
  google,
  apple,
  admin,
}