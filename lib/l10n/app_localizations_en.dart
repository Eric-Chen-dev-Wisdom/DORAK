// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get nicknameLabel => 'Guest Player';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get createNewRoom => 'Create Account';

  @override
  String get continueGuest => 'Play as Guest';

  @override
  String get welcome => 'Welcome to DORAK!';

  @override
  String get selectCategories => 'Select Categories';

  @override
  String get selectCategoriesHint => 'Select 5–8 categories to start the game';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get numberOfQuestions => 'Number of Questions';

  @override
  String get startGame => 'Start Game';

  @override
  String get waitingForHost => 'Waiting for host to select categories...';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get invalidEmail => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get signUp => 'Sign Up';

  @override
  String get alreadyHaveAccount => 'Already have an account? Log in';

  @override
  String get signInTitle => 'Sign In';

  @override
  String get welcomeTitle => 'Welcome to DORAK!';

  @override
  String get welcomeSubtitle => 'Sign in to save your progress and compete with friends';

  @override
  String get signInButton => 'Sign In with Email';

  @override
  String get noAccount => 'Don\'t have an account? Sign Up';

  @override
  String get googleButton => 'Continue with Google';

  @override
  String get appleButton => 'Continue with Apple';

  @override
  String get guestButton => 'Continue as Guest';

  @override
  String get firebaseInitError => 'Firebase failed to initialize';

  @override
  String get loading => 'Loading...';

  @override
  String get back => 'Back';
}
