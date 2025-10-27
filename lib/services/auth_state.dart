class AuthState {
  static bool isLoggedIn = false;
  static String? currentUserEmail;
  static String? currentUserName;
  static bool isGuest = false;
  
  // Called when user logs in with email/password
  static void login(String email, String name) {
    isLoggedIn = true;
    currentUserEmail = email;
    currentUserName = name;
    isGuest = false;
    print('🟢 User logged in: $name ($email)');
  }
  
  // Called when user signs up
  static void signUp(String name, String email) {
    isLoggedIn = true;
    currentUserEmail = email;
    currentUserName = name;
    isGuest = false;
    print('🟢 New user signed up: $name ($email)');
  }
  
  // Called when user plays as guest
  static void guestLogin() {
    isLoggedIn = true;
    currentUserEmail = null;
    currentUserName = 'Guest';
    isGuest = true;
    print('🟢 Guest user logged in');
  }
  
  // Called when user logs out
  static void logout() {
    isLoggedIn = false;
    currentUserEmail = null;
    currentUserName = null;
    isGuest = false;
    print('🔴 User logged out');
  }
  
  // Helper to get user display name
  static String get userDisplayName {
    return currentUserName ?? 'Guest';
  }
}