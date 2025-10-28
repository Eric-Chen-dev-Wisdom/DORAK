import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  // Temporary: Remove Firebase for prototype testing
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user - temporary for prototype
  // User? get currentUser => _auth.currentUser;
  UserModel? get currentUser => null;

  // Check if user is logged in - temporary for prototype
  // bool get isLoggedIn => _auth.currentUser != null;
  bool get isLoggedIn => false;

  // Guest login - THIS WILL WORK
  Future<UserModel> guestLogin(String displayName) async {
    final user = UserModel.guest(displayName);
    
    // Save guest session locally
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('guest_name', displayName);
    await prefs.setBool('is_guest', true);
    
    return user;
  }

  // Google Sign In - temporary mock
  Future<UserModel?> signInWithGoogle() async {
    // Temporary: Show dialog that this feature is coming soon
    // We'll implement this when we set up Firebase
    return null;
  }

  // Apple Sign In - temporary mock  
  Future<UserModel?> signInWithApple() async {
    // Temporary: Show dialog that this feature is coming soon
    // We'll implement this when we set up Firebase
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    // await _auth.signOut();
    // await _googleSignIn.signOut();
    
    // Clear guest session
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('guest_name');
    await prefs.remove('is_guest');
  }

  // Check if user has guest session
  Future<bool> hasGuestSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_guest') ?? false;
  }

  // Get guest name
  Future<String?> getGuestName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('guest_name');
  }
}