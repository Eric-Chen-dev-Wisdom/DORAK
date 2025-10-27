class AuthService {
  // Demo login - always returns success for now
  static Future<bool> login(String email, String password) async {
    // Simulate waiting for a server response (2 seconds)
    await Future.delayed(const Duration(seconds: 2));
    print('✅ Demo login successful for: $email');
    return true; // Always return true for demo
  }
  
  // Demo signup
  static Future<bool> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    print('✅ Demo signup successful for: $name ($email)');
    return true;
  }
  
  // Demo guest login
  static Future<bool> guestLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    print('✅ Guest login successful');
    return true;
  }
  
  // Placeholder for Google sign-in
  static Future<bool> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 2));
    print('✅ Google sign-in successful (placeholder)');
    return true;
  }
  
  // Placeholder for Apple sign-in
  static Future<bool> signInWithApple() async {
    await Future.delayed(const Duration(seconds: 2));
    print('✅ Apple sign-in successful (placeholder)');
    return true;
  }
}