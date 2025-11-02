// services/auth_service.dart
import '../models/user_model.dart';

class AuthService {
  // Use mock users for testing instead of Firebase Auth
  Future<UserModel?> guestLogin(String displayName) async {
    try {
      // Create a mock user without Firebase Auth
      // This avoids the emulator conflict
      final mockUser = UserModel(
        id: 'mock_${DateTime.now().millisecondsSinceEpoch}_${displayName.hashCode}',
        displayName: displayName,
        email: null,
        photoUrl: null,
        type: UserType.guest,
        createdAt: DateTime.now(),
      );

      print('✅ Mock guest login: ${mockUser.displayName} (ID: ${mockUser.id})');
      return mockUser;
    } catch (e) {
      print('❌ Mock guest login error: $e');
      return null;
    }
  }

  // Placeholder for Google Sign-In
  Future<UserModel?> signInWithGoogle() async {
    print('🔜 Google Sign-In not implemented yet');
    return null;
  }

  // Placeholder for Apple Sign-In
  Future<UserModel?> signInWithApple() async {
    print('🔜 Apple Sign-In not implemented yet');
    return null;
  }
}
