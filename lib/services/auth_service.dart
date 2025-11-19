// services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/foundation.dart';

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
      if (kDebugMode) {
        print('[Auth] Guest login: ${mockUser.displayName} (${mockUser.id})');
      }
      return mockUser;
    } catch (e) {
      if (kDebugMode) {
        print('[Auth] Guest login error: $e');
      }
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

      if (googleAuth.idToken == null) {
        if (kDebugMode) {
          print('[Auth] Google sign-in error: idToken is null');
        }
        return null;
      }
      if (googleAuth.accessToken == null) {
        if (kDebugMode) {
          print('[Auth] Google sign-in error: accessToken is null');
        }
        return null;
      }

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
      if (kDebugMode) {
        print('[Auth] Google sign-in success: ${model.displayName}');
      }
      return model;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(
            '[Auth] FirebaseAuthException (google): ${e.code} - ${e.message}');
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('[Auth] Google sign-in error: $e');
      }
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('[Auth] Sign out error: $e');
      }
    }
  }

  Future<UserModel?> signInWithApple() async {
    try {
      // Check if Apple Sign In is available
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        print('[Auth] Apple Sign-In not available on this device');
        return null;
      }

      // Request credential from Apple
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create OAuth provider
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(oauthCredential);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Create display name from Apple credential
        String displayName = 'Apple User';
        if (credential.givenName != null && credential.familyName != null) {
          displayName = '${credential.givenName} ${credential.familyName}';
        } else if (firebaseUser.displayName != null) {
          displayName = firebaseUser.displayName!;
        }

        final user = UserModel(
          id: firebaseUser.uid,
          displayName: displayName,
          email: credential.email ?? firebaseUser.email,
          photoUrl: firebaseUser.photoURL,
          type: UserType.apple,
          createdAt: DateTime.now(),
        );

        print('[Auth] ✅ Apple Sign-In successful: ${user.displayName}');
        return user;
      }
      return null;
    } catch (e) {
      print('[Auth] ❌ Apple Sign-In error: $e');
      return null;
    }
  }
}
