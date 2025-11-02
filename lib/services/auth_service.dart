// services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel?> guestLogin(String displayName) async {
    try {
      final mockUser = UserModel(
        id: 'mock_${DateTime.now().millisecondsSinceEpoch}_${displayName.hashCode}',
        displayName: displayName,
        email: null,
        photoUrl: null,
        type: UserType.guest,
        createdAt: DateTime.now(),
      );
      print('[Auth] Guest login: ${mockUser.displayName} (${mockUser.id})');
      return mockUser;
    } catch (e) {
      print('[Auth] Guest login error: $e');
      return null;
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      // Launch account picker
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // user cancelled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final UserCredential userCred =
          await _auth.signInWithCredential(credential);
      final User? user = userCred.user;
      if (user == null) return null;

      final model = UserModel(
        id: user.uid,
        displayName: user.displayName ?? 'Google User',
        email: user.email,
        photoUrl: user.photoURL,
        type: UserType.google,
        createdAt: DateTime.now(),
      );
      print('[Auth] Google sign-in success: ${model.displayName}');
      return model;
    } on FirebaseAuthException catch (e) {
      print('[Auth] FirebaseAuthException (google): ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('[Auth] Google sign-in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print('[Auth] Sign out error: $e');
    }
  }

  Future<UserModel?> signInWithApple() async {
    print('[Auth] Apple Sign-In not implemented yet');
    return null;
  }
}

