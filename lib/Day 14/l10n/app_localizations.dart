import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @nicknameLabel.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nicknameLabel;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @createNewRoom.
  ///
  /// In en, this message translates to:
  /// **'Create New Room'**
  String get createNewRoom;

  /// No description provided for @continueGuest.
  ///
  /// In en, this message translates to:
  /// **'Play as Guest'**
  String get continueGuest;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to DORAK!'**
  String get welcome;

  /// No description provided for @selectCategories.
  ///
  /// In en, this message translates to:
  /// **'Select Categories'**
  String get selectCategories;

  /// No description provided for @selectCategoriesHint.
  ///
  /// In en, this message translates to:
  /// **'Select 5–8 categories to start the game'**
  String get selectCategoriesHint;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @numberOfQuestions.
  ///
  /// In en, this message translates to:
  /// **'Number of Questions'**
  String get numberOfQuestions;

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start Game ({count}/5)'**
  String startGame(Object count);

  /// No description provided for @waitingForHost.
  ///
  /// In en, this message translates to:
  /// **'Waiting for host to select categories...'**
  String get waitingForHost;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get alreadyHaveAccount;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to DORAK!'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save your progress and compete with friends'**
  String get welcomeSubtitle;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In with Email'**
  String get signInButton;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get noAccount;

  /// No description provided for @googleButton.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get googleButton;

  /// No description provided for @appleButton.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get appleButton;

  /// No description provided for @guestButton.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get guestButton;

  /// No description provided for @firebaseInitError.
  ///
  /// In en, this message translates to:
  /// **'Firebase failed to initialize'**
  String get firebaseInitError;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @gameLobbyTitle.
  ///
  /// In en, this message translates to:
  /// **'Game Lobby'**
  String get gameLobbyTitle;

  /// No description provided for @connectingRoom.
  ///
  /// In en, this message translates to:
  /// **'Connecting to room...'**
  String get connectingRoom;

  /// No description provided for @enterNickname.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Nickname'**
  String get enterNickname;

  /// No description provided for @createRoom.
  ///
  /// In en, this message translates to:
  /// **'Create Room'**
  String get createRoom;

  /// No description provided for @joinExistingRoom.
  ///
  /// In en, this message translates to:
  /// **'Join Existing Room'**
  String get joinExistingRoom;

  /// No description provided for @roomCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Room Code'**
  String get roomCodeLabel;

  /// No description provided for @roomCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit code'**
  String get roomCodeHint;

  /// No description provided for @teamA.
  ///
  /// In en, this message translates to:
  /// **'Team A'**
  String get teamA;

  /// No description provided for @teamB.
  ///
  /// In en, this message translates to:
  /// **'Team B'**
  String get teamB;

  /// No description provided for @joinRoom.
  ///
  /// In en, this message translates to:
  /// **'Join Room'**
  String get joinRoom;

  /// No description provided for @roomCreated.
  ///
  /// In en, this message translates to:
  /// **'Room Created!'**
  String get roomCreated;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code: {roomCode}'**
  String code(Object roomCode);

  /// No description provided for @shareRoomCode.
  ///
  /// In en, this message translates to:
  /// **'Share Room Code'**
  String get shareRoomCode;

  /// No description provided for @liveStatus.
  ///
  /// In en, this message translates to:
  /// **'Live - {playerCount} players connected'**
  String liveStatus(Object playerCount);

  /// No description provided for @noPlayersYet.
  ///
  /// In en, this message translates to:
  /// **'No players yet'**
  String get noPlayersYet;

  /// No description provided for @guestLabel.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guestLabel;

  /// No description provided for @memberLabel.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get memberLabel;

  /// No description provided for @liveChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get liveChat;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet\nStart chatting!'**
  String get noMessagesYet;

  /// No description provided for @typeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessageHint;

  /// No description provided for @chatOn.
  ///
  /// In en, this message translates to:
  /// **'ON'**
  String get chatOn;

  /// No description provided for @chatOff.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get chatOff;

  /// No description provided for @startGameDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Start Game?'**
  String get startGameDialogTitle;

  /// No description provided for @startGameDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Are you ready to begin the game with {playerCount} players?'**
  String startGameDialogContent(Object playerCount);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @startGameNow.
  ///
  /// In en, this message translates to:
  /// **'Start Game!'**
  String get startGameNow;

  /// No description provided for @copyCodeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Room code {roomCode} copied to clipboard! Share it with your friends.'**
  String copyCodeSuccess(Object roomCode);

  /// No description provided for @copyCodeFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to share room code. Please try again.'**
  String get copyCodeFailed;

  /// No description provided for @errorConnectingRoom.
  ///
  /// In en, this message translates to:
  /// **'Error connecting to room: {error}'**
  String errorConnectingRoom(Object error);

  /// No description provided for @roomJoinFailed.
  ///
  /// In en, this message translates to:
  /// **'Room not found or join failed.'**
  String get roomJoinFailed;

  /// No description provided for @createRoomFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create room: {error}'**
  String createRoomFailed(Object error);

  /// No description provided for @needMorePlayers.
  ///
  /// In en, this message translates to:
  /// **'Need at least 2 players to start the game!'**
  String get needMorePlayers;

  /// No description provided for @onlyHostCanStart.
  ///
  /// In en, this message translates to:
  /// **'Only the host can start the game.'**
  String get onlyHostCanStart;

  /// No description provided for @invalidRoomCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 6-character room code.'**
  String get invalidRoomCode;

  /// No description provided for @errorJoiningRoom.
  ///
  /// In en, this message translates to:
  /// **'Error joining room: {error}'**
  String errorJoiningRoom(Object error);

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @chatError.
  ///
  /// In en, this message translates to:
  /// **'Chat error: {error}'**
  String chatError(Object error);

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'ON'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @chatControlsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Chat controls coming soon!'**
  String get chatControlsComingSoon;

  /// No description provided for @unknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownUser;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @selectRange.
  ///
  /// In en, this message translates to:
  /// **'Select 5-8 Categories'**
  String get selectRange;

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected (Min: 5, Max: 8)'**
  String selectedCount(Object count);

  /// No description provided for @maximumCategories.
  ///
  /// In en, this message translates to:
  /// **'Maximum 8 categories allowed'**
  String get maximumCategories;

  /// No description provided for @minimumCategories.
  ///
  /// In en, this message translates to:
  /// **'Please select at least 1 category'**
  String get minimumCategories;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get categoryEasy;

  /// No description provided for @categoryMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get categoryMedium;

  /// No description provided for @categoryHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get categoryHard;

  /// No description provided for @maxEightCategories.
  ///
  /// In en, this message translates to:
  /// **'Maximum 8 categories allowed'**
  String get maxEightCategories;

  /// No description provided for @pleaseSelectAtLeastOneCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select at least 1 category'**
  String get pleaseSelectAtLeastOneCategory;

  /// No description provided for @selectCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Categories'**
  String get selectCategoriesTitle;

  /// No description provided for @select58Categories.
  ///
  /// In en, this message translates to:
  /// **'Select 5-8 Categories'**
  String get select58Categories;

  /// No description provided for @selectedCategoriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected (Min: 5, Max: 8)'**
  String selectedCategoriesCount(Object count);

  /// No description provided for @difficultyAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get difficultyAll;

  /// No description provided for @difficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get difficultyEasy;

  /// No description provided for @difficultyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get difficultyMedium;

  /// No description provided for @difficultyHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get difficultyHard;

  /// No description provided for @difficultyLabel.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficultyLabel;

  /// No description provided for @questionCount.
  ///
  /// In en, this message translates to:
  /// **'{count} questions'**
  String questionCount(Object count);

  /// No description provided for @questionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questionsLabel;

  /// No description provided for @startGameButton.
  ///
  /// In en, this message translates to:
  /// **'Start Game ({count}/5)'**
  String startGameButton(Object count);

  /// No description provided for @waitingForHostToSelectCategories.
  ///
  /// In en, this message translates to:
  /// **'Waiting for host to select categories...'**
  String get waitingForHostToSelectCategories;

  /// No description provided for @gameTitle.
  ///
  /// In en, this message translates to:
  /// **'DORAK Game'**
  String get gameTitle;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get time;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @players.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// No description provided for @generalKnowledge.
  ///
  /// In en, this message translates to:
  /// **'General Knowledge'**
  String get generalKnowledge;

  /// No description provided for @questionOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionOfTotal(Object current, Object total);

  /// No description provided for @selectAnswer.
  ///
  /// In en, this message translates to:
  /// **'Select your answer:'**
  String get selectAnswer;

  /// No description provided for @submitVote.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT VOTE'**
  String get submitVote;

  /// No description provided for @teamVotes.
  ///
  /// In en, this message translates to:
  /// **'Team Votes'**
  String get teamVotes;

  /// No description provided for @votesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} votes'**
  String votesCount(Object count);

  /// No description provided for @votingInProgress.
  ///
  /// In en, this message translates to:
  /// **'Voting in progress...'**
  String get votingInProgress;

  /// No description provided for @voteSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Vote submitted for option {option}'**
  String voteSubmitted(Object option);

  /// No description provided for @questionSkipped.
  ///
  /// In en, this message translates to:
  /// **'Question skipped!'**
  String get questionSkipped;

  /// No description provided for @votingStarted.
  ///
  /// In en, this message translates to:
  /// **'Voting started! Teams can now submit answers.'**
  String get votingStarted;

  /// No description provided for @answerRevealed.
  ///
  /// In en, this message translates to:
  /// **'Answer revealed! Team A: +{a}, Team B: +{b}'**
  String answerRevealed(Object a, Object b);

  /// No description provided for @powerCardActivated.
  ///
  /// In en, this message translates to:
  /// **'{card} activated!'**
  String powerCardActivated(Object card);

  /// No description provided for @hostControls.
  ///
  /// In en, this message translates to:
  /// **'Host Controls'**
  String get hostControls;

  /// No description provided for @hostControlTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open host control panel'**
  String get hostControlTooltip;

  /// No description provided for @dorakGameTitle.
  ///
  /// In en, this message translates to:
  /// **'DORAK Game'**
  String get dorakGameTitle;

  /// No description provided for @hostControlsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Host Controls'**
  String get hostControlsTooltip;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get timeLabel;

  /// No description provided for @secondsLabel.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get secondsLabel;

  /// No description provided for @playersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} players'**
  String playersCount(Object count);

  /// No description provided for @questionNumber.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionNumber(Object current, Object total);

  /// No description provided for @selectYourAnswer.
  ///
  /// In en, this message translates to:
  /// **'Select your answer:'**
  String get selectYourAnswer;

  /// No description provided for @voteSubmittedOption.
  ///
  /// In en, this message translates to:
  /// **'Vote submitted for option {option}'**
  String voteSubmittedOption(Object option);

  /// No description provided for @hostControlsTitle.
  ///
  /// In en, this message translates to:
  /// **'Host Controls'**
  String get hostControlsTitle;

  /// No description provided for @gameStateLabel.
  ///
  /// In en, this message translates to:
  /// **'Game State'**
  String get gameStateLabel;

  /// No description provided for @timerControlLabel.
  ///
  /// In en, this message translates to:
  /// **'Timer Control'**
  String get timerControlLabel;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @quickAdjust.
  ///
  /// In en, this message translates to:
  /// **'Quick Adjust:'**
  String get quickAdjust;

  /// No description provided for @pointsControlLabel.
  ///
  /// In en, this message translates to:
  /// **'Points Control'**
  String get pointsControlLabel;

  /// No description provided for @teamLabel.
  ///
  /// In en, this message translates to:
  /// **'Team {team}'**
  String teamLabel(Object team);

  /// No description provided for @awardPoints.
  ///
  /// In en, this message translates to:
  /// **'Award Points:'**
  String get awardPoints;

  /// No description provided for @votingStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Voting Status'**
  String get votingStatusLabel;

  /// No description provided for @teamAVotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Team A Votes'**
  String get teamAVotesLabel;

  /// No description provided for @teamBVotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Team B Votes'**
  String get teamBVotesLabel;

  /// No description provided for @startVoting.
  ///
  /// In en, this message translates to:
  /// **'Start Voting'**
  String get startVoting;

  /// No description provided for @revealAnswer.
  ///
  /// In en, this message translates to:
  /// **'Reveal Answer'**
  String get revealAnswer;

  /// No description provided for @questionControls.
  ///
  /// In en, this message translates to:
  /// **'Question Controls'**
  String get questionControls;

  /// No description provided for @nextQuestion.
  ///
  /// In en, this message translates to:
  /// **'Next Question'**
  String get nextQuestion;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @powerCards.
  ///
  /// In en, this message translates to:
  /// **'Power Cards'**
  String get powerCards;

  /// No description provided for @doublePoints.
  ///
  /// In en, this message translates to:
  /// **'Double Points'**
  String get doublePoints;

  /// No description provided for @stealPoints.
  ///
  /// In en, this message translates to:
  /// **'Steal Points'**
  String get stealPoints;

  /// No description provided for @reverseTurn.
  ///
  /// In en, this message translates to:
  /// **'Reverse Turn'**
  String get reverseTurn;

  /// No description provided for @skipRound.
  ///
  /// In en, this message translates to:
  /// **'Skip Round'**
  String get skipRound;

  /// No description provided for @endGame.
  ///
  /// In en, this message translates to:
  /// **'End Game'**
  String get endGame;

  /// No description provided for @endGameDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'End Game?'**
  String get endGameDialogTitle;

  /// No description provided for @endGameDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to end the current game? This cannot be undone.'**
  String get endGameDialogContent;

  /// No description provided for @endGameConfirm.
  ///
  /// In en, this message translates to:
  /// **'End Game'**
  String get endGameConfirm;

  /// No description provided for @timesUp.
  ///
  /// In en, this message translates to:
  /// **'Time\'s up!'**
  String get timesUp;

  /// No description provided for @doublePointsDesc.
  ///
  /// In en, this message translates to:
  /// **'Next correct answer will be worth double points!'**
  String get doublePointsDesc;

  /// No description provided for @stealPointsDesc.
  ///
  /// In en, this message translates to:
  /// **'Steal 2 points from the other team!'**
  String get stealPointsDesc;

  /// No description provided for @reverseTurnDesc.
  ///
  /// In en, this message translates to:
  /// **'Question goes to the other team!'**
  String get reverseTurnDesc;

  /// No description provided for @skipRoundDesc.
  ///
  /// In en, this message translates to:
  /// **'Skipping to next question!'**
  String get skipRoundDesc;

  /// No description provided for @activatedFallback.
  ///
  /// In en, this message translates to:
  /// **'{card} activated!'**
  String activatedFallback(Object card);

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get points;

  /// No description provided for @doublePointsEffect.
  ///
  /// In en, this message translates to:
  /// **'Next correct answer will be worth double points!'**
  String get doublePointsEffect;

  /// No description provided for @stealPointsEffect.
  ///
  /// In en, this message translates to:
  /// **'Steal 2 points from the other team!'**
  String get stealPointsEffect;

  /// No description provided for @reverseTurnEffect.
  ///
  /// In en, this message translates to:
  /// **'Question goes to the other team!'**
  String get reverseTurnEffect;

  /// No description provided for @skipRoundEffect.
  ///
  /// In en, this message translates to:
  /// **'Skipping to next question!'**
  String get skipRoundEffect;

  /// No description provided for @activated.
  ///
  /// In en, this message translates to:
  /// **'activated'**
  String get activated;

  /// No description provided for @roomCode.
  ///
  /// In en, this message translates to:
  /// **'Room Code'**
  String get roomCode;

  /// No description provided for @gameState.
  ///
  /// In en, this message translates to:
  /// **'Game State'**
  String get gameState;

  /// No description provided for @waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get waiting;

  /// No description provided for @inGame.
  ///
  /// In en, this message translates to:
  /// **'In Game'**
  String get inGame;

  /// No description provided for @roundComplete.
  ///
  /// In en, this message translates to:
  /// **'Round Complete'**
  String get roundComplete;

  /// No description provided for @gameComplete.
  ///
  /// In en, this message translates to:
  /// **'Game Complete'**
  String get gameComplete;

  /// No description provided for @timerControl.
  ///
  /// In en, this message translates to:
  /// **'Timer Control'**
  String get timerControl;

  /// No description provided for @minus10s.
  ///
  /// In en, this message translates to:
  /// **'-10s'**
  String get minus10s;

  /// No description provided for @minus5s.
  ///
  /// In en, this message translates to:
  /// **'-5s'**
  String get minus5s;

  /// No description provided for @plus5s.
  ///
  /// In en, this message translates to:
  /// **'+5s'**
  String get plus5s;

  /// No description provided for @plus10s.
  ///
  /// In en, this message translates to:
  /// **'+10s'**
  String get plus10s;

  /// No description provided for @pointsControl.
  ///
  /// In en, this message translates to:
  /// **'Points Control'**
  String get pointsControl;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get great;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @votingStatus.
  ///
  /// In en, this message translates to:
  /// **'Voting Status'**
  String get votingStatus;

  /// No description provided for @votes.
  ///
  /// In en, this message translates to:
  /// **'votes'**
  String get votes;

  /// No description provided for @doubleNextPoints.
  ///
  /// In en, this message translates to:
  /// **'Double next points'**
  String get doubleNextPoints;

  /// No description provided for @steal2Points.
  ///
  /// In en, this message translates to:
  /// **'Steal 2 points'**
  String get steal2Points;

  /// No description provided for @reverseQuestion.
  ///
  /// In en, this message translates to:
  /// **'Reverse question'**
  String get reverseQuestion;

  /// No description provided for @skipQuestion.
  ///
  /// In en, this message translates to:
  /// **'Skip question'**
  String get skipQuestion;

  /// No description provided for @endGameQ.
  ///
  /// In en, this message translates to:
  /// **'End Game?'**
  String get endGameQ;

  /// No description provided for @endGameWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to end the current game? This cannot be undone.'**
  String get endGameWarning;

  /// No description provided for @gameResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Game Results'**
  String get gameResultsTitle;

  /// No description provided for @itsATie.
  ///
  /// In en, this message translates to:
  /// **'It\'s a Tie!'**
  String get itsATie;

  /// No description provided for @teamAWins.
  ///
  /// In en, this message translates to:
  /// **'🎉 Team A Wins!'**
  String get teamAWins;

  /// No description provided for @teamBWins.
  ///
  /// In en, this message translates to:
  /// **'🎉 Team B Wins!'**
  String get teamBWins;

  /// No description provided for @finalScores.
  ///
  /// In en, this message translates to:
  /// **'Final Scores'**
  String get finalScores;

  /// No description provided for @pointsAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'{score} pts'**
  String pointsAbbreviation(Object score);

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @unknownPlayer.
  ///
  /// In en, this message translates to:
  /// **'Unknown Player'**
  String get unknownPlayer;

  /// No description provided for @winnerBannerPath.
  ///
  /// In en, this message translates to:
  /// **'assets/images/winner.png'**
  String get winnerBannerPath;

  /// No description provided for @loserBannerPath.
  ///
  /// In en, this message translates to:
  /// **'assets/images/loser.png'**
  String get loserBannerPath;

  /// No description provided for @categoryGeneralKnowledge.
  ///
  /// In en, this message translates to:
  /// **'General Knowledge'**
  String get categoryGeneralKnowledge;

  /// No description provided for @categoryGeneralKnowledgeDesc.
  ///
  /// In en, this message translates to:
  /// **'Test your general knowledge'**
  String get categoryGeneralKnowledgeDesc;

  /// No description provided for @categoryFamilyLife.
  ///
  /// In en, this message translates to:
  /// **'Family Life'**
  String get categoryFamilyLife;

  /// No description provided for @categoryFamilyLifeDesc.
  ///
  /// In en, this message translates to:
  /// **'Fun questions about family'**
  String get categoryFamilyLifeDesc;

  /// No description provided for @categoryGulfCulture.
  ///
  /// In en, this message translates to:
  /// **'Gulf Culture'**
  String get categoryGulfCulture;

  /// No description provided for @categoryGulfCultureDesc.
  ///
  /// In en, this message translates to:
  /// **'Questions about Gulf traditions'**
  String get categoryGulfCultureDesc;

  /// No description provided for @categoryMoviesTV.
  ///
  /// In en, this message translates to:
  /// **'Movies & TV'**
  String get categoryMoviesTV;

  /// No description provided for @categoryMoviesTVDesc.
  ///
  /// In en, this message translates to:
  /// **'Guess movies and TV shows'**
  String get categoryMoviesTVDesc;

  /// No description provided for @categoryMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get categoryMusic;

  /// No description provided for @categoryMusicDesc.
  ///
  /// In en, this message translates to:
  /// **'Music trivia and karaoke'**
  String get categoryMusicDesc;

  /// No description provided for @categoryFunnyChallenges.
  ///
  /// In en, this message translates to:
  /// **'Funny Challenges'**
  String get categoryFunnyChallenges;

  /// No description provided for @categoryFunnyChallengesDesc.
  ///
  /// In en, this message translates to:
  /// **'Hilarious physical challenges'**
  String get categoryFunnyChallengesDesc;

  /// No description provided for @categoryKidsCorner.
  ///
  /// In en, this message translates to:
  /// **'Kids Corner'**
  String get categoryKidsCorner;

  /// No description provided for @categoryKidsCornerDesc.
  ///
  /// In en, this message translates to:
  /// **'Fun for the little ones'**
  String get categoryKidsCornerDesc;

  /// No description provided for @categoryQuickThinking.
  ///
  /// In en, this message translates to:
  /// **'Quick Thinking'**
  String get categoryQuickThinking;

  /// No description provided for @categoryQuickThinkingDesc.
  ///
  /// In en, this message translates to:
  /// **'Fast-paced brain teasers'**
  String get categoryQuickThinkingDesc;

  /// No description provided for @selectCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Select 5-8 Categories'**
  String get selectCountLabel;

  /// No description provided for @selectedCountStatus.
  ///
  /// In en, this message translates to:
  /// **'{count} selected (Min: 5, Max: 8)'**
  String selectedCountStatus(Object count);

  /// No description provided for @maxCategoriesWarning.
  ///
  /// In en, this message translates to:
  /// **'Maximum 8 categories allowed'**
  String get maxCategoriesWarning;

  /// No description provided for @tieResult.
  ///
  /// In en, this message translates to:
  /// **'It\'s a Tie!'**
  String get tieResult;

  /// No description provided for @gameResults.
  ///
  /// In en, this message translates to:
  /// **'Game Results'**
  String get gameResults;

  /// No description provided for @cat_1Name.
  ///
  /// In en, this message translates to:
  /// **'General Knowledge'**
  String get cat_1Name;

  /// No description provided for @cat_1Desc.
  ///
  /// In en, this message translates to:
  /// **'Test your general knowledge'**
  String get cat_1Desc;

  /// No description provided for @cat_2Name.
  ///
  /// In en, this message translates to:
  /// **'Family Life'**
  String get cat_2Name;

  /// No description provided for @cat_2Desc.
  ///
  /// In en, this message translates to:
  /// **'Fun questions about family'**
  String get cat_2Desc;

  /// No description provided for @cat_3Name.
  ///
  /// In en, this message translates to:
  /// **'Gulf Culture'**
  String get cat_3Name;

  /// No description provided for @cat_3Desc.
  ///
  /// In en, this message translates to:
  /// **'Questions about Gulf traditions'**
  String get cat_3Desc;

  /// No description provided for @cat_4Name.
  ///
  /// In en, this message translates to:
  /// **'Movies & TV'**
  String get cat_4Name;

  /// No description provided for @cat_4Desc.
  ///
  /// In en, this message translates to:
  /// **'Guess movies and TV shows'**
  String get cat_4Desc;

  /// No description provided for @cat_5Name.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get cat_5Name;

  /// No description provided for @cat_5Desc.
  ///
  /// In en, this message translates to:
  /// **'Music trivia and karaoke'**
  String get cat_5Desc;

  /// No description provided for @cat_6Name.
  ///
  /// In en, this message translates to:
  /// **'Funny Challenges'**
  String get cat_6Name;

  /// No description provided for @cat_6Desc.
  ///
  /// In en, this message translates to:
  /// **'Hilarious physical challenges'**
  String get cat_6Desc;

  /// No description provided for @cat_7Name.
  ///
  /// In en, this message translates to:
  /// **'Kids Corner'**
  String get cat_7Name;

  /// No description provided for @cat_7Desc.
  ///
  /// In en, this message translates to:
  /// **'Fun for the little ones'**
  String get cat_7Desc;

  /// No description provided for @cat_8Name.
  ///
  /// In en, this message translates to:
  /// **'Quick Thinking'**
  String get cat_8Name;

  /// No description provided for @cat_8Desc.
  ///
  /// In en, this message translates to:
  /// **'Fast-paced brain teasers'**
  String get cat_8Desc;

  /// No description provided for @q_gk_001_text.
  ///
  /// In en, this message translates to:
  /// **'What is the capital of Saudi Arabia?'**
  String get q_gk_001_text;

  /// No description provided for @q_gk_001_opt1.
  ///
  /// In en, this message translates to:
  /// **'Riyadh'**
  String get q_gk_001_opt1;

  /// No description provided for @q_gk_001_opt2.
  ///
  /// In en, this message translates to:
  /// **'Jeddah'**
  String get q_gk_001_opt2;

  /// No description provided for @q_gk_001_opt3.
  ///
  /// In en, this message translates to:
  /// **'Doha'**
  String get q_gk_001_opt3;

  /// No description provided for @q_gk_001_opt4.
  ///
  /// In en, this message translates to:
  /// **'Dubai'**
  String get q_gk_001_opt4;

  /// No description provided for @q_gk_002_text.
  ///
  /// In en, this message translates to:
  /// **'What color is a ripe banana?'**
  String get q_gk_002_text;

  /// No description provided for @q_gk_002_opt1.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get q_gk_002_opt1;

  /// No description provided for @q_gk_002_opt2.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get q_gk_002_opt2;

  /// No description provided for @q_gk_002_opt3.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get q_gk_002_opt3;

  /// No description provided for @q_gk_002_opt4.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get q_gk_002_opt4;

  /// No description provided for @q_gk_003_text.
  ///
  /// In en, this message translates to:
  /// **'How many days are there in one week?'**
  String get q_gk_003_text;

  /// No description provided for @q_gk_003_opt1.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get q_gk_003_opt1;

  /// No description provided for @q_gk_003_opt2.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get q_gk_003_opt2;

  /// No description provided for @q_gk_003_opt3.
  ///
  /// In en, this message translates to:
  /// **'7'**
  String get q_gk_003_opt3;

  /// No description provided for @q_gk_003_opt4.
  ///
  /// In en, this message translates to:
  /// **'8'**
  String get q_gk_003_opt4;

  /// No description provided for @q_gk_004_text.
  ///
  /// In en, this message translates to:
  /// **'Which planet is known as the Red Planet?'**
  String get q_gk_004_text;

  /// No description provided for @q_gk_004_opt1.
  ///
  /// In en, this message translates to:
  /// **'Venus'**
  String get q_gk_004_opt1;

  /// No description provided for @q_gk_004_opt2.
  ///
  /// In en, this message translates to:
  /// **'Mars'**
  String get q_gk_004_opt2;

  /// No description provided for @q_gk_004_opt3.
  ///
  /// In en, this message translates to:
  /// **'Jupiter'**
  String get q_gk_004_opt3;

  /// No description provided for @q_gk_004_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mercury'**
  String get q_gk_004_opt4;

  /// No description provided for @q_gk_005_text.
  ///
  /// In en, this message translates to:
  /// **'How many letters are in the English alphabet?'**
  String get q_gk_005_text;

  /// No description provided for @q_gk_005_opt1.
  ///
  /// In en, this message translates to:
  /// **'24'**
  String get q_gk_005_opt1;

  /// No description provided for @q_gk_005_opt2.
  ///
  /// In en, this message translates to:
  /// **'25'**
  String get q_gk_005_opt2;

  /// No description provided for @q_gk_005_opt3.
  ///
  /// In en, this message translates to:
  /// **'26'**
  String get q_gk_005_opt3;

  /// No description provided for @q_gk_005_opt4.
  ///
  /// In en, this message translates to:
  /// **'27'**
  String get q_gk_005_opt4;

  /// No description provided for @q_gk_006_text.
  ///
  /// In en, this message translates to:
  /// **'What do bees make?'**
  String get q_gk_006_text;

  /// No description provided for @q_gk_006_opt1.
  ///
  /// In en, this message translates to:
  /// **'Honey'**
  String get q_gk_006_opt1;

  /// No description provided for @q_gk_006_opt2.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get q_gk_006_opt2;

  /// No description provided for @q_gk_006_opt3.
  ///
  /// In en, this message translates to:
  /// **'Wax'**
  String get q_gk_006_opt3;

  /// No description provided for @q_gk_006_opt4.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get q_gk_006_opt4;

  /// No description provided for @q_gk_007_text.
  ///
  /// In en, this message translates to:
  /// **'Which ocean is the largest?'**
  String get q_gk_007_text;

  /// No description provided for @q_gk_007_opt1.
  ///
  /// In en, this message translates to:
  /// **'Atlantic'**
  String get q_gk_007_opt1;

  /// No description provided for @q_gk_007_opt2.
  ///
  /// In en, this message translates to:
  /// **'Indian'**
  String get q_gk_007_opt2;

  /// No description provided for @q_gk_007_opt3.
  ///
  /// In en, this message translates to:
  /// **'Pacific'**
  String get q_gk_007_opt3;

  /// No description provided for @q_gk_007_opt4.
  ///
  /// In en, this message translates to:
  /// **'Arctic'**
  String get q_gk_007_opt4;

  /// No description provided for @q_gk_008_text.
  ///
  /// In en, this message translates to:
  /// **'How many sides does a triangle have?'**
  String get q_gk_008_text;

  /// No description provided for @q_gk_008_opt1.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get q_gk_008_opt1;

  /// No description provided for @q_gk_008_opt2.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get q_gk_008_opt2;

  /// No description provided for @q_gk_008_opt3.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get q_gk_008_opt3;

  /// No description provided for @q_gk_008_opt4.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get q_gk_008_opt4;

  /// No description provided for @q_gk_009_text.
  ///
  /// In en, this message translates to:
  /// **'What is H₂O commonly known as?'**
  String get q_gk_009_text;

  /// No description provided for @q_gk_009_opt1.
  ///
  /// In en, this message translates to:
  /// **'Oxygen'**
  String get q_gk_009_opt1;

  /// No description provided for @q_gk_009_opt2.
  ///
  /// In en, this message translates to:
  /// **'Salt'**
  String get q_gk_009_opt2;

  /// No description provided for @q_gk_009_opt3.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get q_gk_009_opt3;

  /// No description provided for @q_gk_009_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen'**
  String get q_gk_009_opt4;

  /// No description provided for @q_gk_010_text.
  ///
  /// In en, this message translates to:
  /// **'Which animal is known as the King of the Jungle?'**
  String get q_gk_010_text;

  /// No description provided for @q_gk_010_opt1.
  ///
  /// In en, this message translates to:
  /// **'Tiger'**
  String get q_gk_010_opt1;

  /// No description provided for @q_gk_010_opt2.
  ///
  /// In en, this message translates to:
  /// **'Lion'**
  String get q_gk_010_opt2;

  /// No description provided for @q_gk_010_opt3.
  ///
  /// In en, this message translates to:
  /// **'Elephant'**
  String get q_gk_010_opt3;

  /// No description provided for @q_gk_010_opt4.
  ///
  /// In en, this message translates to:
  /// **'Leopard'**
  String get q_gk_010_opt4;

  /// No description provided for @q_gk_011_text.
  ///
  /// In en, this message translates to:
  /// **'Who wrote the famous play “Romeo and Juliet”?'**
  String get q_gk_011_text;

  /// No description provided for @q_gk_011_opt1.
  ///
  /// In en, this message translates to:
  /// **'Shakespeare'**
  String get q_gk_011_opt1;

  /// No description provided for @q_gk_011_opt2.
  ///
  /// In en, this message translates to:
  /// **'Homer'**
  String get q_gk_011_opt2;

  /// No description provided for @q_gk_011_opt3.
  ///
  /// In en, this message translates to:
  /// **'Tolstoy'**
  String get q_gk_011_opt3;

  /// No description provided for @q_gk_011_opt4.
  ///
  /// In en, this message translates to:
  /// **'Charles Dickens'**
  String get q_gk_011_opt4;

  /// No description provided for @q_gk_012_text.
  ///
  /// In en, this message translates to:
  /// **'What gas do plants produce during photosynthesis?'**
  String get q_gk_012_text;

  /// No description provided for @q_gk_012_opt1.
  ///
  /// In en, this message translates to:
  /// **'Oxygen'**
  String get q_gk_012_opt1;

  /// No description provided for @q_gk_012_opt2.
  ///
  /// In en, this message translates to:
  /// **'Carbon dioxide'**
  String get q_gk_012_opt2;

  /// No description provided for @q_gk_012_opt3.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen'**
  String get q_gk_012_opt3;

  /// No description provided for @q_gk_012_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen'**
  String get q_gk_012_opt4;

  /// No description provided for @q_gk_013_text.
  ///
  /// In en, this message translates to:
  /// **'What is the largest desert in the world?'**
  String get q_gk_013_text;

  /// No description provided for @q_gk_013_opt1.
  ///
  /// In en, this message translates to:
  /// **'Sahara'**
  String get q_gk_013_opt1;

  /// No description provided for @q_gk_013_opt2.
  ///
  /// In en, this message translates to:
  /// **'Arabian'**
  String get q_gk_013_opt2;

  /// No description provided for @q_gk_013_opt3.
  ///
  /// In en, this message translates to:
  /// **'Gobi'**
  String get q_gk_013_opt3;

  /// No description provided for @q_gk_013_opt4.
  ///
  /// In en, this message translates to:
  /// **'Antarctic'**
  String get q_gk_013_opt4;

  /// No description provided for @q_gk_014_text.
  ///
  /// In en, this message translates to:
  /// **'Which metal is liquid at room temperature?'**
  String get q_gk_014_text;

  /// No description provided for @q_gk_014_opt1.
  ///
  /// In en, this message translates to:
  /// **'Mercury'**
  String get q_gk_014_opt1;

  /// No description provided for @q_gk_014_opt2.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get q_gk_014_opt2;

  /// No description provided for @q_gk_014_opt3.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get q_gk_014_opt3;

  /// No description provided for @q_gk_014_opt4.
  ///
  /// In en, this message translates to:
  /// **'Aluminum'**
  String get q_gk_014_opt4;

  /// No description provided for @q_gk_015_text.
  ///
  /// In en, this message translates to:
  /// **'Who was the first person to walk on the Moon?'**
  String get q_gk_015_text;

  /// No description provided for @q_gk_015_opt1.
  ///
  /// In en, this message translates to:
  /// **'Neil Armstrong'**
  String get q_gk_015_opt1;

  /// No description provided for @q_gk_015_opt2.
  ///
  /// In en, this message translates to:
  /// **'Buzz Aldrin'**
  String get q_gk_015_opt2;

  /// No description provided for @q_gk_015_opt3.
  ///
  /// In en, this message translates to:
  /// **'Yuri Gagarin'**
  String get q_gk_015_opt3;

  /// No description provided for @q_gk_015_opt4.
  ///
  /// In en, this message translates to:
  /// **'Alan Shepard'**
  String get q_gk_015_opt4;

  /// No description provided for @q_gk_016_text.
  ///
  /// In en, this message translates to:
  /// **'Which continent has the most countries?'**
  String get q_gk_016_text;

  /// No description provided for @q_gk_016_opt1.
  ///
  /// In en, this message translates to:
  /// **'Asia'**
  String get q_gk_016_opt1;

  /// No description provided for @q_gk_016_opt2.
  ///
  /// In en, this message translates to:
  /// **'Europe'**
  String get q_gk_016_opt2;

  /// No description provided for @q_gk_016_opt3.
  ///
  /// In en, this message translates to:
  /// **'Africa'**
  String get q_gk_016_opt3;

  /// No description provided for @q_gk_016_opt4.
  ///
  /// In en, this message translates to:
  /// **'South America'**
  String get q_gk_016_opt4;

  /// No description provided for @q_gk_017_text.
  ///
  /// In en, this message translates to:
  /// **'What is the longest river in the world?'**
  String get q_gk_017_text;

  /// No description provided for @q_gk_017_opt1.
  ///
  /// In en, this message translates to:
  /// **'Nile'**
  String get q_gk_017_opt1;

  /// No description provided for @q_gk_017_opt2.
  ///
  /// In en, this message translates to:
  /// **'Amazon'**
  String get q_gk_017_opt2;

  /// No description provided for @q_gk_017_opt3.
  ///
  /// In en, this message translates to:
  /// **'Yangtze'**
  String get q_gk_017_opt3;

  /// No description provided for @q_gk_017_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mississippi'**
  String get q_gk_017_opt4;

  /// No description provided for @q_gk_018_text.
  ///
  /// In en, this message translates to:
  /// **'Which country invented paper?'**
  String get q_gk_018_text;

  /// No description provided for @q_gk_018_opt1.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get q_gk_018_opt1;

  /// No description provided for @q_gk_018_opt2.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get q_gk_018_opt2;

  /// No description provided for @q_gk_018_opt3.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get q_gk_018_opt3;

  /// No description provided for @q_gk_018_opt4.
  ///
  /// In en, this message translates to:
  /// **'Greece'**
  String get q_gk_018_opt4;

  /// No description provided for @q_gk_019_text.
  ///
  /// In en, this message translates to:
  /// **'In which year did World War II end?'**
  String get q_gk_019_text;

  /// No description provided for @q_gk_019_opt1.
  ///
  /// In en, this message translates to:
  /// **'1942'**
  String get q_gk_019_opt1;

  /// No description provided for @q_gk_019_opt2.
  ///
  /// In en, this message translates to:
  /// **'1943'**
  String get q_gk_019_opt2;

  /// No description provided for @q_gk_019_opt3.
  ///
  /// In en, this message translates to:
  /// **'1945'**
  String get q_gk_019_opt3;

  /// No description provided for @q_gk_019_opt4.
  ///
  /// In en, this message translates to:
  /// **'1948'**
  String get q_gk_019_opt4;

  /// No description provided for @q_gk_020_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf city is known as the “City of Gold”?'**
  String get q_gk_020_text;

  /// No description provided for @q_gk_020_opt1.
  ///
  /// In en, this message translates to:
  /// **'Dubai'**
  String get q_gk_020_opt1;

  /// No description provided for @q_gk_020_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kuwait City'**
  String get q_gk_020_opt2;

  /// No description provided for @q_gk_020_opt3.
  ///
  /// In en, this message translates to:
  /// **'Riyadh'**
  String get q_gk_020_opt3;

  /// No description provided for @q_gk_020_opt4.
  ///
  /// In en, this message translates to:
  /// **'Doha'**
  String get q_gk_020_opt4;

  /// No description provided for @q_gk_021_text.
  ///
  /// In en, this message translates to:
  /// **'What is the chemical symbol for gold?'**
  String get q_gk_021_text;

  /// No description provided for @q_gk_021_opt1.
  ///
  /// In en, this message translates to:
  /// **'Au'**
  String get q_gk_021_opt1;

  /// No description provided for @q_gk_021_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ag'**
  String get q_gk_021_opt2;

  /// No description provided for @q_gk_021_opt3.
  ///
  /// In en, this message translates to:
  /// **'Gd'**
  String get q_gk_021_opt3;

  /// No description provided for @q_gk_021_opt4.
  ///
  /// In en, this message translates to:
  /// **'Pt'**
  String get q_gk_021_opt4;

  /// No description provided for @q_gk_022_text.
  ///
  /// In en, this message translates to:
  /// **'Who discovered the law of gravity?'**
  String get q_gk_022_text;

  /// No description provided for @q_gk_022_opt1.
  ///
  /// In en, this message translates to:
  /// **'Isaac Newton'**
  String get q_gk_022_opt1;

  /// No description provided for @q_gk_022_opt2.
  ///
  /// In en, this message translates to:
  /// **'Albert Einstein'**
  String get q_gk_022_opt2;

  /// No description provided for @q_gk_022_opt3.
  ///
  /// In en, this message translates to:
  /// **'Galileo'**
  String get q_gk_022_opt3;

  /// No description provided for @q_gk_022_opt4.
  ///
  /// In en, this message translates to:
  /// **'Archimedes'**
  String get q_gk_022_opt4;

  /// No description provided for @q_gk_023_text.
  ///
  /// In en, this message translates to:
  /// **'What is the smallest bone in the human body?'**
  String get q_gk_023_text;

  /// No description provided for @q_gk_023_opt1.
  ///
  /// In en, this message translates to:
  /// **'Stapes'**
  String get q_gk_023_opt1;

  /// No description provided for @q_gk_023_opt2.
  ///
  /// In en, this message translates to:
  /// **'Femur'**
  String get q_gk_023_opt2;

  /// No description provided for @q_gk_023_opt3.
  ///
  /// In en, this message translates to:
  /// **'Tibia'**
  String get q_gk_023_opt3;

  /// No description provided for @q_gk_023_opt4.
  ///
  /// In en, this message translates to:
  /// **'Ulna'**
  String get q_gk_023_opt4;

  /// No description provided for @q_gk_024_text.
  ///
  /// In en, this message translates to:
  /// **'Which planet has the most moons?'**
  String get q_gk_024_text;

  /// No description provided for @q_gk_024_opt1.
  ///
  /// In en, this message translates to:
  /// **'Jupiter'**
  String get q_gk_024_opt1;

  /// No description provided for @q_gk_024_opt2.
  ///
  /// In en, this message translates to:
  /// **'Saturn'**
  String get q_gk_024_opt2;

  /// No description provided for @q_gk_024_opt3.
  ///
  /// In en, this message translates to:
  /// **'Neptune'**
  String get q_gk_024_opt3;

  /// No description provided for @q_gk_024_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mars'**
  String get q_gk_024_opt4;

  /// No description provided for @q_gk_025_text.
  ///
  /// In en, this message translates to:
  /// **'In which year was the United Nations founded?'**
  String get q_gk_025_text;

  /// No description provided for @q_gk_025_opt1.
  ///
  /// In en, this message translates to:
  /// **'1940'**
  String get q_gk_025_opt1;

  /// No description provided for @q_gk_025_opt2.
  ///
  /// In en, this message translates to:
  /// **'1945'**
  String get q_gk_025_opt2;

  /// No description provided for @q_gk_025_opt3.
  ///
  /// In en, this message translates to:
  /// **'1950'**
  String get q_gk_025_opt3;

  /// No description provided for @q_gk_025_opt4.
  ///
  /// In en, this message translates to:
  /// **'1955'**
  String get q_gk_025_opt4;

  /// No description provided for @q_gk_026_text.
  ///
  /// In en, this message translates to:
  /// **'What is the hardest natural substance on Earth?'**
  String get q_gk_026_text;

  /// No description provided for @q_gk_026_opt1.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get q_gk_026_opt1;

  /// No description provided for @q_gk_026_opt2.
  ///
  /// In en, this message translates to:
  /// **'Iron'**
  String get q_gk_026_opt2;

  /// No description provided for @q_gk_026_opt3.
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get q_gk_026_opt3;

  /// No description provided for @q_gk_026_opt4.
  ///
  /// In en, this message translates to:
  /// **'Steel'**
  String get q_gk_026_opt4;

  /// No description provided for @q_gk_027_text.
  ///
  /// In en, this message translates to:
  /// **'What is the currency of Japan?'**
  String get q_gk_027_text;

  /// No description provided for @q_gk_027_opt1.
  ///
  /// In en, this message translates to:
  /// **'Yuan'**
  String get q_gk_027_opt1;

  /// No description provided for @q_gk_027_opt2.
  ///
  /// In en, this message translates to:
  /// **'Yen'**
  String get q_gk_027_opt2;

  /// No description provided for @q_gk_027_opt3.
  ///
  /// In en, this message translates to:
  /// **'Won'**
  String get q_gk_027_opt3;

  /// No description provided for @q_gk_027_opt4.
  ///
  /// In en, this message translates to:
  /// **'Ringgit'**
  String get q_gk_027_opt4;

  /// No description provided for @q_gk_028_text.
  ///
  /// In en, this message translates to:
  /// **'Which element has the chemical symbol “Na”?'**
  String get q_gk_028_text;

  /// No description provided for @q_gk_028_opt1.
  ///
  /// In en, this message translates to:
  /// **'Sodium'**
  String get q_gk_028_opt1;

  /// No description provided for @q_gk_028_opt2.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen'**
  String get q_gk_028_opt2;

  /// No description provided for @q_gk_028_opt3.
  ///
  /// In en, this message translates to:
  /// **'Nickel'**
  String get q_gk_028_opt3;

  /// No description provided for @q_gk_028_opt4.
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get q_gk_028_opt4;

  /// No description provided for @q_gk_029_text.
  ///
  /// In en, this message translates to:
  /// **'What is the capital city of Canada?'**
  String get q_gk_029_text;

  /// No description provided for @q_gk_029_opt1.
  ///
  /// In en, this message translates to:
  /// **'Toronto'**
  String get q_gk_029_opt1;

  /// No description provided for @q_gk_029_opt2.
  ///
  /// In en, this message translates to:
  /// **'Vancouver'**
  String get q_gk_029_opt2;

  /// No description provided for @q_gk_029_opt3.
  ///
  /// In en, this message translates to:
  /// **'Ottawa'**
  String get q_gk_029_opt3;

  /// No description provided for @q_gk_029_opt4.
  ///
  /// In en, this message translates to:
  /// **'Montreal'**
  String get q_gk_029_opt4;

  /// No description provided for @q_gk_030_text.
  ///
  /// In en, this message translates to:
  /// **'Who proposed the theory of relativity?'**
  String get q_gk_030_text;

  /// No description provided for @q_gk_030_opt1.
  ///
  /// In en, this message translates to:
  /// **'Einstein'**
  String get q_gk_030_opt1;

  /// No description provided for @q_gk_030_opt2.
  ///
  /// In en, this message translates to:
  /// **'Newton'**
  String get q_gk_030_opt2;

  /// No description provided for @q_gk_030_opt3.
  ///
  /// In en, this message translates to:
  /// **'Tesla'**
  String get q_gk_030_opt3;

  /// No description provided for @q_gk_030_opt4.
  ///
  /// In en, this message translates to:
  /// **'Curie'**
  String get q_gk_030_opt4;

  /// No description provided for @q_fl_001_text.
  ///
  /// In en, this message translates to:
  /// **'What is something families often do together on weekends?'**
  String get q_fl_001_text;

  /// No description provided for @q_fl_001_opt1.
  ///
  /// In en, this message translates to:
  /// **'Watch movies'**
  String get q_fl_001_opt1;

  /// No description provided for @q_fl_001_opt2.
  ///
  /// In en, this message translates to:
  /// **'Go shopping'**
  String get q_fl_001_opt2;

  /// No description provided for @q_fl_001_opt3.
  ///
  /// In en, this message translates to:
  /// **'Stay silent'**
  String get q_fl_001_opt3;

  /// No description provided for @q_fl_001_opt4.
  ///
  /// In en, this message translates to:
  /// **'Work overtime'**
  String get q_fl_001_opt4;

  /// No description provided for @q_fl_002_text.
  ///
  /// In en, this message translates to:
  /// **'Who is usually the oldest member in a family?'**
  String get q_fl_002_text;

  /// No description provided for @q_fl_002_opt1.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get q_fl_002_opt1;

  /// No description provided for @q_fl_002_opt2.
  ///
  /// In en, this message translates to:
  /// **'Grandfather'**
  String get q_fl_002_opt2;

  /// No description provided for @q_fl_002_opt3.
  ///
  /// In en, this message translates to:
  /// **'Brother'**
  String get q_fl_002_opt3;

  /// No description provided for @q_fl_002_opt4.
  ///
  /// In en, this message translates to:
  /// **'Uncle'**
  String get q_fl_002_opt4;

  /// No description provided for @q_fl_003_text.
  ///
  /// In en, this message translates to:
  /// **'What do most families eat together on Fridays in the Gulf?'**
  String get q_fl_003_text;

  /// No description provided for @q_fl_003_opt1.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get q_fl_003_opt1;

  /// No description provided for @q_fl_003_opt2.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get q_fl_003_opt2;

  /// No description provided for @q_fl_003_opt3.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get q_fl_003_opt3;

  /// No description provided for @q_fl_003_opt4.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get q_fl_003_opt4;

  /// No description provided for @q_fl_004_text.
  ///
  /// In en, this message translates to:
  /// **'What do parents always tell their kids to finish before playing?'**
  String get q_fl_004_text;

  /// No description provided for @q_fl_004_opt1.
  ///
  /// In en, this message translates to:
  /// **'Homework'**
  String get q_fl_004_opt1;

  /// No description provided for @q_fl_004_opt2.
  ///
  /// In en, this message translates to:
  /// **'TV shows'**
  String get q_fl_004_opt2;

  /// No description provided for @q_fl_004_opt3.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get q_fl_004_opt3;

  /// No description provided for @q_fl_004_opt4.
  ///
  /// In en, this message translates to:
  /// **'Calls'**
  String get q_fl_004_opt4;

  /// No description provided for @q_fl_005_text.
  ///
  /// In en, this message translates to:
  /// **'Who is usually in charge of cooking in most households?'**
  String get q_fl_005_text;

  /// No description provided for @q_fl_005_opt1.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get q_fl_005_opt1;

  /// No description provided for @q_fl_005_opt2.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get q_fl_005_opt2;

  /// No description provided for @q_fl_005_opt3.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get q_fl_005_opt3;

  /// No description provided for @q_fl_005_opt4.
  ///
  /// In en, this message translates to:
  /// **'Neighbor'**
  String get q_fl_005_opt4;

  /// No description provided for @q_fl_006_text.
  ///
  /// In en, this message translates to:
  /// **'What’s something you say to your parents before leaving the house?'**
  String get q_fl_006_text;

  /// No description provided for @q_fl_006_opt1.
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get q_fl_006_opt1;

  /// No description provided for @q_fl_006_opt2.
  ///
  /// In en, this message translates to:
  /// **'See you'**
  String get q_fl_006_opt2;

  /// No description provided for @q_fl_006_opt3.
  ///
  /// In en, this message translates to:
  /// **'I’m off'**
  String get q_fl_006_opt3;

  /// No description provided for @q_fl_006_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_fl_006_opt4;

  /// No description provided for @q_fl_007_text.
  ///
  /// In en, this message translates to:
  /// **'What’s the most common family pet?'**
  String get q_fl_007_text;

  /// No description provided for @q_fl_007_opt1.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get q_fl_007_opt1;

  /// No description provided for @q_fl_007_opt2.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get q_fl_007_opt2;

  /// No description provided for @q_fl_007_opt3.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get q_fl_007_opt3;

  /// No description provided for @q_fl_007_opt4.
  ///
  /// In en, this message translates to:
  /// **'Parrot'**
  String get q_fl_007_opt4;

  /// No description provided for @q_fl_008_text.
  ///
  /// In en, this message translates to:
  /// **'Who teaches manners and respect at home?'**
  String get q_fl_008_text;

  /// No description provided for @q_fl_008_opt1.
  ///
  /// In en, this message translates to:
  /// **'Parents'**
  String get q_fl_008_opt1;

  /// No description provided for @q_fl_008_opt2.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get q_fl_008_opt2;

  /// No description provided for @q_fl_008_opt3.
  ///
  /// In en, this message translates to:
  /// **'Teachers'**
  String get q_fl_008_opt3;

  /// No description provided for @q_fl_008_opt4.
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get q_fl_008_opt4;

  /// No description provided for @q_fl_009_text.
  ///
  /// In en, this message translates to:
  /// **'What do families usually celebrate together?'**
  String get q_fl_009_text;

  /// No description provided for @q_fl_009_opt1.
  ///
  /// In en, this message translates to:
  /// **'Eid'**
  String get q_fl_009_opt1;

  /// No description provided for @q_fl_009_opt2.
  ///
  /// In en, this message translates to:
  /// **'Birthdays'**
  String get q_fl_009_opt2;

  /// No description provided for @q_fl_009_opt3.
  ///
  /// In en, this message translates to:
  /// **'Graduations'**
  String get q_fl_009_opt3;

  /// No description provided for @q_fl_009_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_fl_009_opt4;

  /// No description provided for @q_fl_010_text.
  ///
  /// In en, this message translates to:
  /// **'Which room in the house brings the family together?'**
  String get q_fl_010_text;

  /// No description provided for @q_fl_010_opt1.
  ///
  /// In en, this message translates to:
  /// **'Living room'**
  String get q_fl_010_opt1;

  /// No description provided for @q_fl_010_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get q_fl_010_opt2;

  /// No description provided for @q_fl_010_opt3.
  ///
  /// In en, this message translates to:
  /// **'Garage'**
  String get q_fl_010_opt3;

  /// No description provided for @q_fl_010_opt4.
  ///
  /// In en, this message translates to:
  /// **'Bedroom'**
  String get q_fl_010_opt4;

  /// No description provided for @q_fl_011_text.
  ///
  /// In en, this message translates to:
  /// **'What’s one good way to make your family members happy?'**
  String get q_fl_011_text;

  /// No description provided for @q_fl_011_opt1.
  ///
  /// In en, this message translates to:
  /// **'Help them'**
  String get q_fl_011_opt1;

  /// No description provided for @q_fl_011_opt2.
  ///
  /// In en, this message translates to:
  /// **'Complain'**
  String get q_fl_011_opt2;

  /// No description provided for @q_fl_011_opt3.
  ///
  /// In en, this message translates to:
  /// **'Ignore them'**
  String get q_fl_011_opt3;

  /// No description provided for @q_fl_011_opt4.
  ///
  /// In en, this message translates to:
  /// **'Blame them'**
  String get q_fl_011_opt4;

  /// No description provided for @q_fl_012_text.
  ///
  /// In en, this message translates to:
  /// **'What is something families do during Ramadan evenings?'**
  String get q_fl_012_text;

  /// No description provided for @q_fl_012_opt1.
  ///
  /// In en, this message translates to:
  /// **'Eat together'**
  String get q_fl_012_opt1;

  /// No description provided for @q_fl_012_opt2.
  ///
  /// In en, this message translates to:
  /// **'Watch TV'**
  String get q_fl_012_opt2;

  /// No description provided for @q_fl_012_opt3.
  ///
  /// In en, this message translates to:
  /// **'Pray together'**
  String get q_fl_012_opt3;

  /// No description provided for @q_fl_012_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_fl_012_opt4;

  /// No description provided for @q_fl_013_text.
  ///
  /// In en, this message translates to:
  /// **'Who usually decides family vacation plans?'**
  String get q_fl_013_text;

  /// No description provided for @q_fl_013_opt1.
  ///
  /// In en, this message translates to:
  /// **'Parents'**
  String get q_fl_013_opt1;

  /// No description provided for @q_fl_013_opt2.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get q_fl_013_opt2;

  /// No description provided for @q_fl_013_opt3.
  ///
  /// In en, this message translates to:
  /// **'Grandparents'**
  String get q_fl_013_opt3;

  /// No description provided for @q_fl_013_opt4.
  ///
  /// In en, this message translates to:
  /// **'Neighbors'**
  String get q_fl_013_opt4;

  /// No description provided for @q_fl_014_text.
  ///
  /// In en, this message translates to:
  /// **'What does a good family always show to one another?'**
  String get q_fl_014_text;

  /// No description provided for @q_fl_014_opt1.
  ///
  /// In en, this message translates to:
  /// **'Respect'**
  String get q_fl_014_opt1;

  /// No description provided for @q_fl_014_opt2.
  ///
  /// In en, this message translates to:
  /// **'Anger'**
  String get q_fl_014_opt2;

  /// No description provided for @q_fl_014_opt3.
  ///
  /// In en, this message translates to:
  /// **'Jealousy'**
  String get q_fl_014_opt3;

  /// No description provided for @q_fl_014_opt4.
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get q_fl_014_opt4;

  /// No description provided for @q_fl_015_text.
  ///
  /// In en, this message translates to:
  /// **'What’s something families do together during Eid?'**
  String get q_fl_015_text;

  /// No description provided for @q_fl_015_opt1.
  ///
  /// In en, this message translates to:
  /// **'Visit relatives'**
  String get q_fl_015_opt1;

  /// No description provided for @q_fl_015_opt2.
  ///
  /// In en, this message translates to:
  /// **'Go to work'**
  String get q_fl_015_opt2;

  /// No description provided for @q_fl_015_opt3.
  ///
  /// In en, this message translates to:
  /// **'Sleep all day'**
  String get q_fl_015_opt3;

  /// No description provided for @q_fl_015_opt4.
  ///
  /// In en, this message translates to:
  /// **'Travel alone'**
  String get q_fl_015_opt4;

  /// No description provided for @q_fl_016_text.
  ///
  /// In en, this message translates to:
  /// **'What should you say when a family member sneezes?'**
  String get q_fl_016_text;

  /// No description provided for @q_fl_016_opt1.
  ///
  /// In en, this message translates to:
  /// **'Bless you'**
  String get q_fl_016_opt1;

  /// No description provided for @q_fl_016_opt2.
  ///
  /// In en, this message translates to:
  /// **'Excuse me'**
  String get q_fl_016_opt2;

  /// No description provided for @q_fl_016_opt3.
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get q_fl_016_opt3;

  /// No description provided for @q_fl_016_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get q_fl_016_opt4;

  /// No description provided for @q_fl_017_text.
  ///
  /// In en, this message translates to:
  /// **'What helps families stay connected when living far apart?'**
  String get q_fl_017_text;

  /// No description provided for @q_fl_017_opt1.
  ///
  /// In en, this message translates to:
  /// **'Phone calls'**
  String get q_fl_017_opt1;

  /// No description provided for @q_fl_017_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ignoring each other'**
  String get q_fl_017_opt2;

  /// No description provided for @q_fl_017_opt3.
  ///
  /// In en, this message translates to:
  /// **'No contact'**
  String get q_fl_017_opt3;

  /// No description provided for @q_fl_017_opt4.
  ///
  /// In en, this message translates to:
  /// **'Letters only'**
  String get q_fl_017_opt4;

  /// No description provided for @q_fl_018_text.
  ///
  /// In en, this message translates to:
  /// **'Which activity can strengthen family bonds?'**
  String get q_fl_018_text;

  /// No description provided for @q_fl_018_opt1.
  ///
  /// In en, this message translates to:
  /// **'Cooking together'**
  String get q_fl_018_opt1;

  /// No description provided for @q_fl_018_opt2.
  ///
  /// In en, this message translates to:
  /// **'Arguing'**
  String get q_fl_018_opt2;

  /// No description provided for @q_fl_018_opt3.
  ///
  /// In en, this message translates to:
  /// **'Playing separately'**
  String get q_fl_018_opt3;

  /// No description provided for @q_fl_018_opt4.
  ///
  /// In en, this message translates to:
  /// **'Silent meals'**
  String get q_fl_018_opt4;

  /// No description provided for @q_fl_019_text.
  ///
  /// In en, this message translates to:
  /// **'What do families in the Gulf enjoy doing at the beach?'**
  String get q_fl_019_text;

  /// No description provided for @q_fl_019_opt1.
  ///
  /// In en, this message translates to:
  /// **'Picnics'**
  String get q_fl_019_opt1;

  /// No description provided for @q_fl_019_opt2.
  ///
  /// In en, this message translates to:
  /// **'Volleyball'**
  String get q_fl_019_opt2;

  /// No description provided for @q_fl_019_opt3.
  ///
  /// In en, this message translates to:
  /// **'Swimming'**
  String get q_fl_019_opt3;

  /// No description provided for @q_fl_019_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_fl_019_opt4;

  /// No description provided for @q_fl_020_text.
  ///
  /// In en, this message translates to:
  /// **'What’s a family value that is highly respected in Gulf culture?'**
  String get q_fl_020_text;

  /// No description provided for @q_fl_020_opt1.
  ///
  /// In en, this message translates to:
  /// **'Obedience to parents'**
  String get q_fl_020_opt1;

  /// No description provided for @q_fl_020_opt2.
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get q_fl_020_opt2;

  /// No description provided for @q_fl_020_opt3.
  ///
  /// In en, this message translates to:
  /// **'Silence'**
  String get q_fl_020_opt3;

  /// No description provided for @q_fl_020_opt4.
  ///
  /// In en, this message translates to:
  /// **'Independence'**
  String get q_fl_020_opt4;

  /// No description provided for @q_fl_021_text.
  ///
  /// In en, this message translates to:
  /// **'What’s one major benefit of eating together as a family?'**
  String get q_fl_021_text;

  /// No description provided for @q_fl_021_opt1.
  ///
  /// In en, this message translates to:
  /// **'Better communication'**
  String get q_fl_021_opt1;

  /// No description provided for @q_fl_021_opt2.
  ///
  /// In en, this message translates to:
  /// **'Faster eating'**
  String get q_fl_021_opt2;

  /// No description provided for @q_fl_021_opt3.
  ///
  /// In en, this message translates to:
  /// **'Less cleanup'**
  String get q_fl_021_opt3;

  /// No description provided for @q_fl_021_opt4.
  ///
  /// In en, this message translates to:
  /// **'More screen time'**
  String get q_fl_021_opt4;

  /// No description provided for @q_fl_022_text.
  ///
  /// In en, this message translates to:
  /// **'Which family tradition helps pass down values between generations?'**
  String get q_fl_022_text;

  /// No description provided for @q_fl_022_opt1.
  ///
  /// In en, this message translates to:
  /// **'Storytelling'**
  String get q_fl_022_opt1;

  /// No description provided for @q_fl_022_opt2.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get q_fl_022_opt2;

  /// No description provided for @q_fl_022_opt3.
  ///
  /// In en, this message translates to:
  /// **'Online gaming'**
  String get q_fl_022_opt3;

  /// No description provided for @q_fl_022_opt4.
  ///
  /// In en, this message translates to:
  /// **'Watching TV alone'**
  String get q_fl_022_opt4;

  /// No description provided for @q_fl_023_text.
  ///
  /// In en, this message translates to:
  /// **'What can cause distance between family members?'**
  String get q_fl_023_text;

  /// No description provided for @q_fl_023_opt1.
  ///
  /// In en, this message translates to:
  /// **'Lack of communication'**
  String get q_fl_023_opt1;

  /// No description provided for @q_fl_023_opt2.
  ///
  /// In en, this message translates to:
  /// **'Respect'**
  String get q_fl_023_opt2;

  /// No description provided for @q_fl_023_opt3.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get q_fl_023_opt3;

  /// No description provided for @q_fl_023_opt4.
  ///
  /// In en, this message translates to:
  /// **'Laughter'**
  String get q_fl_023_opt4;

  /// No description provided for @q_fl_024_text.
  ///
  /// In en, this message translates to:
  /// **'Why is honesty important in a family?'**
  String get q_fl_024_text;

  /// No description provided for @q_fl_024_opt1.
  ///
  /// In en, this message translates to:
  /// **'It builds trust'**
  String get q_fl_024_opt1;

  /// No description provided for @q_fl_024_opt2.
  ///
  /// In en, this message translates to:
  /// **'It causes fights'**
  String get q_fl_024_opt2;

  /// No description provided for @q_fl_024_opt3.
  ///
  /// In en, this message translates to:
  /// **'It wastes time'**
  String get q_fl_024_opt3;

  /// No description provided for @q_fl_024_opt4.
  ///
  /// In en, this message translates to:
  /// **'It makes things boring'**
  String get q_fl_024_opt4;

  /// No description provided for @q_fl_025_text.
  ///
  /// In en, this message translates to:
  /// **'What’s one way parents can teach responsibility to kids?'**
  String get q_fl_025_text;

  /// No description provided for @q_fl_025_opt1.
  ///
  /// In en, this message translates to:
  /// **'Assign chores'**
  String get q_fl_025_opt1;

  /// No description provided for @q_fl_025_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ignore mistakes'**
  String get q_fl_025_opt2;

  /// No description provided for @q_fl_025_opt3.
  ///
  /// In en, this message translates to:
  /// **'Do everything for them'**
  String get q_fl_025_opt3;

  /// No description provided for @q_fl_025_opt4.
  ///
  /// In en, this message translates to:
  /// **'Reward laziness'**
  String get q_fl_025_opt4;

  /// No description provided for @q_fl_026_text.
  ///
  /// In en, this message translates to:
  /// **'Why is patience important in family life?'**
  String get q_fl_026_text;

  /// No description provided for @q_fl_026_opt1.
  ///
  /// In en, this message translates to:
  /// **'To handle differences calmly'**
  String get q_fl_026_opt1;

  /// No description provided for @q_fl_026_opt2.
  ///
  /// In en, this message translates to:
  /// **'To argue better'**
  String get q_fl_026_opt2;

  /// No description provided for @q_fl_026_opt3.
  ///
  /// In en, this message translates to:
  /// **'To win'**
  String get q_fl_026_opt3;

  /// No description provided for @q_fl_026_opt4.
  ///
  /// In en, this message translates to:
  /// **'To avoid help'**
  String get q_fl_026_opt4;

  /// No description provided for @q_fl_027_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf family event brings everyone together each year?'**
  String get q_fl_027_text;

  /// No description provided for @q_fl_027_opt1.
  ///
  /// In en, this message translates to:
  /// **'Eid gathering'**
  String get q_fl_027_opt1;

  /// No description provided for @q_fl_027_opt2.
  ///
  /// In en, this message translates to:
  /// **'National Day parade'**
  String get q_fl_027_opt2;

  /// No description provided for @q_fl_027_opt3.
  ///
  /// In en, this message translates to:
  /// **'Solo trip'**
  String get q_fl_027_opt3;

  /// No description provided for @q_fl_027_opt4.
  ///
  /// In en, this message translates to:
  /// **'TV marathon'**
  String get q_fl_027_opt4;

  /// No description provided for @q_fl_028_text.
  ///
  /// In en, this message translates to:
  /// **'What’s an example of family teamwork?'**
  String get q_fl_028_text;

  /// No description provided for @q_fl_028_opt1.
  ///
  /// In en, this message translates to:
  /// **'Cleaning the house together'**
  String get q_fl_028_opt1;

  /// No description provided for @q_fl_028_opt2.
  ///
  /// In en, this message translates to:
  /// **'Arguing'**
  String get q_fl_028_opt2;

  /// No description provided for @q_fl_028_opt3.
  ///
  /// In en, this message translates to:
  /// **'Staying quiet'**
  String get q_fl_028_opt3;

  /// No description provided for @q_fl_028_opt4.
  ///
  /// In en, this message translates to:
  /// **'Ignoring chores'**
  String get q_fl_028_opt4;

  /// No description provided for @q_fl_029_text.
  ///
  /// In en, this message translates to:
  /// **'Why should families practice gratitude?'**
  String get q_fl_029_text;

  /// No description provided for @q_fl_029_opt1.
  ///
  /// In en, this message translates to:
  /// **'It improves happiness'**
  String get q_fl_029_opt1;

  /// No description provided for @q_fl_029_opt2.
  ///
  /// In en, this message translates to:
  /// **'It wastes time'**
  String get q_fl_029_opt2;

  /// No description provided for @q_fl_029_opt3.
  ///
  /// In en, this message translates to:
  /// **'It causes problems'**
  String get q_fl_029_opt3;

  /// No description provided for @q_fl_029_opt4.
  ///
  /// In en, this message translates to:
  /// **'It creates envy'**
  String get q_fl_029_opt4;

  /// No description provided for @q_fl_030_text.
  ///
  /// In en, this message translates to:
  /// **'What can children teach parents in modern families?'**
  String get q_fl_030_text;

  /// No description provided for @q_fl_030_opt1.
  ///
  /// In en, this message translates to:
  /// **'New technology'**
  String get q_fl_030_opt1;

  /// No description provided for @q_fl_030_opt2.
  ///
  /// In en, this message translates to:
  /// **'Old traditions'**
  String get q_fl_030_opt2;

  /// No description provided for @q_fl_030_opt3.
  ///
  /// In en, this message translates to:
  /// **'More rules'**
  String get q_fl_030_opt3;

  /// No description provided for @q_fl_030_opt4.
  ///
  /// In en, this message translates to:
  /// **'Less respect'**
  String get q_fl_030_opt4;

  /// No description provided for @q_gc_001_text.
  ///
  /// In en, this message translates to:
  /// **'Which drink is traditionally served first to guests in the Gulf?'**
  String get q_gc_001_text;

  /// No description provided for @q_gc_001_opt1.
  ///
  /// In en, this message translates to:
  /// **'Arabic coffee (Gahwa)'**
  String get q_gc_001_opt1;

  /// No description provided for @q_gc_001_opt2.
  ///
  /// In en, this message translates to:
  /// **'Tea'**
  String get q_gc_001_opt2;

  /// No description provided for @q_gc_001_opt3.
  ///
  /// In en, this message translates to:
  /// **'Juice'**
  String get q_gc_001_opt3;

  /// No description provided for @q_gc_001_opt4.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get q_gc_001_opt4;

  /// No description provided for @q_gc_002_text.
  ///
  /// In en, this message translates to:
  /// **'What is the traditional Gulf bread called?'**
  String get q_gc_002_text;

  /// No description provided for @q_gc_002_opt1.
  ///
  /// In en, this message translates to:
  /// **'Regag'**
  String get q_gc_002_opt1;

  /// No description provided for @q_gc_002_opt2.
  ///
  /// In en, this message translates to:
  /// **'Tortilla'**
  String get q_gc_002_opt2;

  /// No description provided for @q_gc_002_opt3.
  ///
  /// In en, this message translates to:
  /// **'Chapati'**
  String get q_gc_002_opt3;

  /// No description provided for @q_gc_002_opt4.
  ///
  /// In en, this message translates to:
  /// **'Pita'**
  String get q_gc_002_opt4;

  /// No description provided for @q_gc_003_text.
  ///
  /// In en, this message translates to:
  /// **'What is the traditional clothing worn by Gulf men?'**
  String get q_gc_003_text;

  /// No description provided for @q_gc_003_opt1.
  ///
  /// In en, this message translates to:
  /// **'Kandura/Thobe'**
  String get q_gc_003_opt1;

  /// No description provided for @q_gc_003_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kimono'**
  String get q_gc_003_opt2;

  /// No description provided for @q_gc_003_opt3.
  ///
  /// In en, this message translates to:
  /// **'Kurta'**
  String get q_gc_003_opt3;

  /// No description provided for @q_gc_003_opt4.
  ///
  /// In en, this message translates to:
  /// **'Suit'**
  String get q_gc_003_opt4;

  /// No description provided for @q_gc_004_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country is famous for pearl diving?'**
  String get q_gc_004_text;

  /// No description provided for @q_gc_004_opt1.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_gc_004_opt1;

  /// No description provided for @q_gc_004_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_gc_004_opt2;

  /// No description provided for @q_gc_004_opt3.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get q_gc_004_opt3;

  /// No description provided for @q_gc_004_opt4.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_gc_004_opt4;

  /// No description provided for @q_gc_005_text.
  ///
  /// In en, this message translates to:
  /// **'What do Gulf people usually eat to break their fast during Ramadan?'**
  String get q_gc_005_text;

  /// No description provided for @q_gc_005_opt1.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get q_gc_005_opt1;

  /// No description provided for @q_gc_005_opt2.
  ///
  /// In en, this message translates to:
  /// **'Rice'**
  String get q_gc_005_opt2;

  /// No description provided for @q_gc_005_opt3.
  ///
  /// In en, this message translates to:
  /// **'Soup'**
  String get q_gc_005_opt3;

  /// No description provided for @q_gc_005_opt4.
  ///
  /// In en, this message translates to:
  /// **'Salad'**
  String get q_gc_005_opt4;

  /// No description provided for @q_gc_006_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country has the tallest building in the world?'**
  String get q_gc_006_text;

  /// No description provided for @q_gc_006_opt1.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_gc_006_opt1;

  /// No description provided for @q_gc_006_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_gc_006_opt2;

  /// No description provided for @q_gc_006_opt3.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_gc_006_opt3;

  /// No description provided for @q_gc_006_opt4.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get q_gc_006_opt4;

  /// No description provided for @q_gc_007_text.
  ///
  /// In en, this message translates to:
  /// **'What is a traditional Gulf dance called?'**
  String get q_gc_007_text;

  /// No description provided for @q_gc_007_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ardah'**
  String get q_gc_007_opt1;

  /// No description provided for @q_gc_007_opt2.
  ///
  /// In en, this message translates to:
  /// **'Salsa'**
  String get q_gc_007_opt2;

  /// No description provided for @q_gc_007_opt3.
  ///
  /// In en, this message translates to:
  /// **'Ballet'**
  String get q_gc_007_opt3;

  /// No description provided for @q_gc_007_opt4.
  ///
  /// In en, this message translates to:
  /// **'Tango'**
  String get q_gc_007_opt4;

  /// No description provided for @q_gc_008_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country’s capital city is Doha?'**
  String get q_gc_008_text;

  /// No description provided for @q_gc_008_opt1.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_gc_008_opt1;

  /// No description provided for @q_gc_008_opt2.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get q_gc_008_opt2;

  /// No description provided for @q_gc_008_opt3.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_gc_008_opt3;

  /// No description provided for @q_gc_008_opt4.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_gc_008_opt4;

  /// No description provided for @q_gc_009_text.
  ///
  /// In en, this message translates to:
  /// **'What is a traditional Gulf boat called?'**
  String get q_gc_009_text;

  /// No description provided for @q_gc_009_opt1.
  ///
  /// In en, this message translates to:
  /// **'Dhow'**
  String get q_gc_009_opt1;

  /// No description provided for @q_gc_009_opt2.
  ///
  /// In en, this message translates to:
  /// **'Canoe'**
  String get q_gc_009_opt2;

  /// No description provided for @q_gc_009_opt3.
  ///
  /// In en, this message translates to:
  /// **'Yacht'**
  String get q_gc_009_opt3;

  /// No description provided for @q_gc_009_opt4.
  ///
  /// In en, this message translates to:
  /// **'Submarine'**
  String get q_gc_009_opt4;

  /// No description provided for @q_gc_010_text.
  ///
  /// In en, this message translates to:
  /// **'What does the Arabic word “Yalla” mean?'**
  String get q_gc_010_text;

  /// No description provided for @q_gc_010_opt1.
  ///
  /// In en, this message translates to:
  /// **'Let’s go'**
  String get q_gc_010_opt1;

  /// No description provided for @q_gc_010_opt2.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get q_gc_010_opt2;

  /// No description provided for @q_gc_010_opt3.
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get q_gc_010_opt3;

  /// No description provided for @q_gc_010_opt4.
  ///
  /// In en, this message translates to:
  /// **'Wait'**
  String get q_gc_010_opt4;

  /// No description provided for @q_gc_011_text.
  ///
  /// In en, this message translates to:
  /// **'What is the Gulf traditional dish made of rice, meat, and spices?'**
  String get q_gc_011_text;

  /// No description provided for @q_gc_011_opt1.
  ///
  /// In en, this message translates to:
  /// **'Machboos'**
  String get q_gc_011_opt1;

  /// No description provided for @q_gc_011_opt2.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get q_gc_011_opt2;

  /// No description provided for @q_gc_011_opt3.
  ///
  /// In en, this message translates to:
  /// **'Burger'**
  String get q_gc_011_opt3;

  /// No description provided for @q_gc_011_opt4.
  ///
  /// In en, this message translates to:
  /// **'Biryani'**
  String get q_gc_011_opt4;

  /// No description provided for @q_gc_012_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf city is home to the famous Souq Waqif?'**
  String get q_gc_012_text;

  /// No description provided for @q_gc_012_opt1.
  ///
  /// In en, this message translates to:
  /// **'Doha'**
  String get q_gc_012_opt1;

  /// No description provided for @q_gc_012_opt2.
  ///
  /// In en, this message translates to:
  /// **'Dubai'**
  String get q_gc_012_opt2;

  /// No description provided for @q_gc_012_opt3.
  ///
  /// In en, this message translates to:
  /// **'Muscat'**
  String get q_gc_012_opt3;

  /// No description provided for @q_gc_012_opt4.
  ///
  /// In en, this message translates to:
  /// **'Manama'**
  String get q_gc_012_opt4;

  /// No description provided for @q_gc_013_text.
  ///
  /// In en, this message translates to:
  /// **'What is the Gulf traditional fragrance made from wood?'**
  String get q_gc_013_text;

  /// No description provided for @q_gc_013_opt1.
  ///
  /// In en, this message translates to:
  /// **'Oud'**
  String get q_gc_013_opt1;

  /// No description provided for @q_gc_013_opt2.
  ///
  /// In en, this message translates to:
  /// **'Rose oil'**
  String get q_gc_013_opt2;

  /// No description provided for @q_gc_013_opt3.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get q_gc_013_opt3;

  /// No description provided for @q_gc_013_opt4.
  ///
  /// In en, this message translates to:
  /// **'Musk'**
  String get q_gc_013_opt4;

  /// No description provided for @q_gc_014_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country celebrates National Day on December 2?'**
  String get q_gc_014_text;

  /// No description provided for @q_gc_014_opt1.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_gc_014_opt1;

  /// No description provided for @q_gc_014_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_gc_014_opt2;

  /// No description provided for @q_gc_014_opt3.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_gc_014_opt3;

  /// No description provided for @q_gc_014_opt4.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get q_gc_014_opt4;

  /// No description provided for @q_gc_015_text.
  ///
  /// In en, this message translates to:
  /// **'What type of headwear is traditionally worn by Gulf men?'**
  String get q_gc_015_text;

  /// No description provided for @q_gc_015_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ghutra'**
  String get q_gc_015_opt1;

  /// No description provided for @q_gc_015_opt2.
  ///
  /// In en, this message translates to:
  /// **'Cap'**
  String get q_gc_015_opt2;

  /// No description provided for @q_gc_015_opt3.
  ///
  /// In en, this message translates to:
  /// **'Hat'**
  String get q_gc_015_opt3;

  /// No description provided for @q_gc_015_opt4.
  ///
  /// In en, this message translates to:
  /// **'Turban'**
  String get q_gc_015_opt4;

  /// No description provided for @q_gc_016_text.
  ///
  /// In en, this message translates to:
  /// **'What are traditional Gulf women’s dresses often decorated with?'**
  String get q_gc_016_text;

  /// No description provided for @q_gc_016_opt1.
  ///
  /// In en, this message translates to:
  /// **'Gold thread embroidery'**
  String get q_gc_016_opt1;

  /// No description provided for @q_gc_016_opt2.
  ///
  /// In en, this message translates to:
  /// **'Beads'**
  String get q_gc_016_opt2;

  /// No description provided for @q_gc_016_opt3.
  ///
  /// In en, this message translates to:
  /// **'Paint'**
  String get q_gc_016_opt3;

  /// No description provided for @q_gc_016_opt4.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get q_gc_016_opt4;

  /// No description provided for @q_gc_017_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country is known as the “Land of Frankincense”?'**
  String get q_gc_017_text;

  /// No description provided for @q_gc_017_opt1.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get q_gc_017_opt1;

  /// No description provided for @q_gc_017_opt2.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_gc_017_opt2;

  /// No description provided for @q_gc_017_opt3.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_gc_017_opt3;

  /// No description provided for @q_gc_017_opt4.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_gc_017_opt4;

  /// No description provided for @q_gc_018_text.
  ///
  /// In en, this message translates to:
  /// **'What is the Gulf term for a close family gathering or evening meeting?'**
  String get q_gc_018_text;

  /// No description provided for @q_gc_018_opt1.
  ///
  /// In en, this message translates to:
  /// **'Diwaniya/Majlis'**
  String get q_gc_018_opt1;

  /// No description provided for @q_gc_018_opt2.
  ///
  /// In en, this message translates to:
  /// **'Bazaar'**
  String get q_gc_018_opt2;

  /// No description provided for @q_gc_018_opt3.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get q_gc_018_opt3;

  /// No description provided for @q_gc_018_opt4.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get q_gc_018_opt4;

  /// No description provided for @q_gc_019_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country has the island city of Muharraq?'**
  String get q_gc_019_text;

  /// No description provided for @q_gc_019_opt1.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_gc_019_opt1;

  /// No description provided for @q_gc_019_opt2.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_gc_019_opt2;

  /// No description provided for @q_gc_019_opt3.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_gc_019_opt3;

  /// No description provided for @q_gc_019_opt4.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get q_gc_019_opt4;

  /// No description provided for @q_gc_020_text.
  ///
  /// In en, this message translates to:
  /// **'What is the Gulf traditional hospitality gesture when guests arrive?'**
  String get q_gc_020_text;

  /// No description provided for @q_gc_020_opt1.
  ///
  /// In en, this message translates to:
  /// **'Serve coffee and dates'**
  String get q_gc_020_opt1;

  /// No description provided for @q_gc_020_opt2.
  ///
  /// In en, this message translates to:
  /// **'Turn on music'**
  String get q_gc_020_opt2;

  /// No description provided for @q_gc_020_opt3.
  ///
  /// In en, this message translates to:
  /// **'Offer gifts'**
  String get q_gc_020_opt3;

  /// No description provided for @q_gc_020_opt4.
  ///
  /// In en, this message translates to:
  /// **'Cook a feast immediately'**
  String get q_gc_020_opt4;

  /// No description provided for @q_gc_021_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country’s flag has a serrated white edge with nine points?'**
  String get q_gc_021_text;

  /// No description provided for @q_gc_021_opt1.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_gc_021_opt1;

  /// No description provided for @q_gc_021_opt2.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_gc_021_opt2;

  /// No description provided for @q_gc_021_opt3.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get q_gc_021_opt3;

  /// No description provided for @q_gc_021_opt4.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_gc_021_opt4;

  /// No description provided for @q_gc_022_text.
  ///
  /// In en, this message translates to:
  /// **'In which Gulf country is the Wahiba Sands desert located?'**
  String get q_gc_022_text;

  /// No description provided for @q_gc_022_opt1.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get q_gc_022_opt1;

  /// No description provided for @q_gc_022_opt2.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get q_gc_022_opt2;

  /// No description provided for @q_gc_022_opt3.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_gc_022_opt3;

  /// No description provided for @q_gc_022_opt4.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_gc_022_opt4;

  /// No description provided for @q_gc_023_text.
  ///
  /// In en, this message translates to:
  /// **'What was the main economic activity in the Gulf before oil discovery?'**
  String get q_gc_023_text;

  /// No description provided for @q_gc_023_opt1.
  ///
  /// In en, this message translates to:
  /// **'Pearl diving and trading'**
  String get q_gc_023_opt1;

  /// No description provided for @q_gc_023_opt2.
  ///
  /// In en, this message translates to:
  /// **'Fishing only'**
  String get q_gc_023_opt2;

  /// No description provided for @q_gc_023_opt3.
  ///
  /// In en, this message translates to:
  /// **'Farming'**
  String get q_gc_023_opt3;

  /// No description provided for @q_gc_023_opt4.
  ///
  /// In en, this message translates to:
  /// **'Gold mining'**
  String get q_gc_023_opt4;

  /// No description provided for @q_gc_024_text.
  ///
  /// In en, this message translates to:
  /// **'What does the word “Habibi” mean in Arabic?'**
  String get q_gc_024_text;

  /// No description provided for @q_gc_024_opt1.
  ///
  /// In en, this message translates to:
  /// **'My dear'**
  String get q_gc_024_opt1;

  /// No description provided for @q_gc_024_opt2.
  ///
  /// In en, this message translates to:
  /// **'My friend'**
  String get q_gc_024_opt2;

  /// No description provided for @q_gc_024_opt3.
  ///
  /// In en, this message translates to:
  /// **'My teacher'**
  String get q_gc_024_opt3;

  /// No description provided for @q_gc_024_opt4.
  ///
  /// In en, this message translates to:
  /// **'My child'**
  String get q_gc_024_opt4;

  /// No description provided for @q_gc_025_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf festival celebrates heritage and traditional sports like camel racing?'**
  String get q_gc_025_text;

  /// No description provided for @q_gc_025_opt1.
  ///
  /// In en, this message translates to:
  /// **'Janadriyah Festival'**
  String get q_gc_025_opt1;

  /// No description provided for @q_gc_025_opt2.
  ///
  /// In en, this message translates to:
  /// **'Eid Al-Fitr'**
  String get q_gc_025_opt2;

  /// No description provided for @q_gc_025_opt3.
  ///
  /// In en, this message translates to:
  /// **'Hala February'**
  String get q_gc_025_opt3;

  /// No description provided for @q_gc_025_opt4.
  ///
  /// In en, this message translates to:
  /// **'Ramadan Market'**
  String get q_gc_025_opt4;

  /// No description provided for @q_gc_026_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf port city was historically called “the Venice of the Gulf”?'**
  String get q_gc_026_text;

  /// No description provided for @q_gc_026_opt1.
  ///
  /// In en, this message translates to:
  /// **'Kuwait City'**
  String get q_gc_026_opt1;

  /// No description provided for @q_gc_026_opt2.
  ///
  /// In en, this message translates to:
  /// **'Manama'**
  String get q_gc_026_opt2;

  /// No description provided for @q_gc_026_opt3.
  ///
  /// In en, this message translates to:
  /// **'Dubai'**
  String get q_gc_026_opt3;

  /// No description provided for @q_gc_026_opt4.
  ///
  /// In en, this message translates to:
  /// **'Muscat'**
  String get q_gc_026_opt4;

  /// No description provided for @q_gc_027_text.
  ///
  /// In en, this message translates to:
  /// **'Which traditional Gulf game is played with small seashells or stones?'**
  String get q_gc_027_text;

  /// No description provided for @q_gc_027_opt1.
  ///
  /// In en, this message translates to:
  /// **'Al-karam'**
  String get q_gc_027_opt1;

  /// No description provided for @q_gc_027_opt2.
  ///
  /// In en, this message translates to:
  /// **'Al-siniyah'**
  String get q_gc_027_opt2;

  /// No description provided for @q_gc_027_opt3.
  ///
  /// In en, this message translates to:
  /// **'Al-karamoh'**
  String get q_gc_027_opt3;

  /// No description provided for @q_gc_027_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hawaleen'**
  String get q_gc_027_opt4;

  /// No description provided for @q_gc_028_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf poet is known as the “Poet of a Million”?'**
  String get q_gc_028_text;

  /// No description provided for @q_gc_028_opt1.
  ///
  /// In en, this message translates to:
  /// **'Mohammed bin Rashid Al Maktoum'**
  String get q_gc_028_opt1;

  /// No description provided for @q_gc_028_opt2.
  ///
  /// In en, this message translates to:
  /// **'Nizar Qabbani'**
  String get q_gc_028_opt2;

  /// No description provided for @q_gc_028_opt3.
  ///
  /// In en, this message translates to:
  /// **'Prince Khalid Al-Faisal'**
  String get q_gc_028_opt3;

  /// No description provided for @q_gc_028_opt4.
  ///
  /// In en, this message translates to:
  /// **'Abdulaziz Al-Qasimi'**
  String get q_gc_028_opt4;

  /// No description provided for @q_gc_029_text.
  ///
  /// In en, this message translates to:
  /// **'What traditional Gulf jewelry piece is worn around the head or forehead by women?'**
  String get q_gc_029_text;

  /// No description provided for @q_gc_029_opt1.
  ///
  /// In en, this message translates to:
  /// **'Tikka'**
  String get q_gc_029_opt1;

  /// No description provided for @q_gc_029_opt2.
  ///
  /// In en, this message translates to:
  /// **'Burqa'**
  String get q_gc_029_opt2;

  /// No description provided for @q_gc_029_opt3.
  ///
  /// In en, this message translates to:
  /// **'Matha Patti'**
  String get q_gc_029_opt3;

  /// No description provided for @q_gc_029_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mask of gold (Burqa)'**
  String get q_gc_029_opt4;

  /// No description provided for @q_gc_030_text.
  ///
  /// In en, this message translates to:
  /// **'What do the colors of most Gulf flags symbolize? (Red, White, Green, Black)'**
  String get q_gc_030_text;

  /// No description provided for @q_gc_030_opt1.
  ///
  /// In en, this message translates to:
  /// **'Arab unity and courage'**
  String get q_gc_030_opt1;

  /// No description provided for @q_gc_030_opt2.
  ///
  /// In en, this message translates to:
  /// **'Nature and peace'**
  String get q_gc_030_opt2;

  /// No description provided for @q_gc_030_opt3.
  ///
  /// In en, this message translates to:
  /// **'Modernity'**
  String get q_gc_030_opt3;

  /// No description provided for @q_gc_030_opt4.
  ///
  /// In en, this message translates to:
  /// **'Trade and culture'**
  String get q_gc_030_opt4;

  /// No description provided for @q_mv_001_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf TV show is famous for its funny sketches during Ramadan?'**
  String get q_mv_001_text;

  /// No description provided for @q_mv_001_opt1.
  ///
  /// In en, this message translates to:
  /// **'Tash Ma Tash'**
  String get q_mv_001_opt1;

  /// No description provided for @q_mv_001_opt2.
  ///
  /// In en, this message translates to:
  /// **'Selfie'**
  String get q_mv_001_opt2;

  /// No description provided for @q_mv_001_opt3.
  ///
  /// In en, this message translates to:
  /// **'Shabab Al Bomb'**
  String get q_mv_001_opt3;

  /// No description provided for @q_mv_001_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_mv_001_opt4;

  /// No description provided for @q_mv_002_text.
  ///
  /// In en, this message translates to:
  /// **'Who is known as the “Father of Kuwaiti Theatre”?'**
  String get q_mv_002_text;

  /// No description provided for @q_mv_002_opt1.
  ///
  /// In en, this message translates to:
  /// **'Abdulhussain Abdulredha'**
  String get q_mv_002_opt1;

  /// No description provided for @q_mv_002_opt2.
  ///
  /// In en, this message translates to:
  /// **'Saad Al-Faraj'**
  String get q_mv_002_opt2;

  /// No description provided for @q_mv_002_opt3.
  ///
  /// In en, this message translates to:
  /// **'Nayef Al-Rodan'**
  String get q_mv_002_opt3;

  /// No description provided for @q_mv_002_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hayat Al-Fahad'**
  String get q_mv_002_opt4;

  /// No description provided for @q_mv_003_text.
  ///
  /// In en, this message translates to:
  /// **'Which country produced the popular TV show “Tash Ma Tash”?'**
  String get q_mv_003_text;

  /// No description provided for @q_mv_003_opt1.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get q_mv_003_opt1;

  /// No description provided for @q_mv_003_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_mv_003_opt2;

  /// No description provided for @q_mv_003_opt3.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_mv_003_opt3;

  /// No description provided for @q_mv_003_opt4.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_mv_003_opt4;

  /// No description provided for @q_mv_004_text.
  ///
  /// In en, this message translates to:
  /// **'Which Arab country is famous for its film industry called “Hollywood of the Middle East”?'**
  String get q_mv_004_text;

  /// No description provided for @q_mv_004_opt1.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get q_mv_004_opt1;

  /// No description provided for @q_mv_004_opt2.
  ///
  /// In en, this message translates to:
  /// **'Lebanon'**
  String get q_mv_004_opt2;

  /// No description provided for @q_mv_004_opt3.
  ///
  /// In en, this message translates to:
  /// **'Jordan'**
  String get q_mv_004_opt3;

  /// No description provided for @q_mv_004_opt4.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_mv_004_opt4;

  /// No description provided for @q_mv_005_text.
  ///
  /// In en, this message translates to:
  /// **'Which actress is considered a legend of Kuwaiti TV drama?'**
  String get q_mv_005_text;

  /// No description provided for @q_mv_005_opt1.
  ///
  /// In en, this message translates to:
  /// **'Hayat Al-Fahad'**
  String get q_mv_005_opt1;

  /// No description provided for @q_mv_005_opt2.
  ///
  /// In en, this message translates to:
  /// **'Soad Abdullah'**
  String get q_mv_005_opt2;

  /// No description provided for @q_mv_005_opt3.
  ///
  /// In en, this message translates to:
  /// **'Haya Abdul Salam'**
  String get q_mv_005_opt3;

  /// No description provided for @q_mv_005_opt4.
  ///
  /// In en, this message translates to:
  /// **'Muna Shaddad'**
  String get q_mv_005_opt4;

  /// No description provided for @q_mv_006_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country often produces Ramadan TV dramas every year?'**
  String get q_mv_006_text;

  /// No description provided for @q_mv_006_opt1.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_mv_006_opt1;

  /// No description provided for @q_mv_006_opt2.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get q_mv_006_opt2;

  /// No description provided for @q_mv_006_opt3.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_mv_006_opt3;

  /// No description provided for @q_mv_006_opt4.
  ///
  /// In en, this message translates to:
  /// **'Yemen'**
  String get q_mv_006_opt4;

  /// No description provided for @q_mv_007_text.
  ///
  /// In en, this message translates to:
  /// **'What language are most Gulf TV series filmed in?'**
  String get q_mv_007_text;

  /// No description provided for @q_mv_007_opt1.
  ///
  /// In en, this message translates to:
  /// **'Khaliji Arabic'**
  String get q_mv_007_opt1;

  /// No description provided for @q_mv_007_opt2.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get q_mv_007_opt2;

  /// No description provided for @q_mv_007_opt3.
  ///
  /// In en, this message translates to:
  /// **'Egyptian Arabic'**
  String get q_mv_007_opt3;

  /// No description provided for @q_mv_007_opt4.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get q_mv_007_opt4;

  /// No description provided for @q_mv_008_text.
  ///
  /// In en, this message translates to:
  /// **'What is the name of the famous Emirati comedy show featuring daily life humor?'**
  String get q_mv_008_text;

  /// No description provided for @q_mv_008_opt1.
  ///
  /// In en, this message translates to:
  /// **'Freej'**
  String get q_mv_008_opt1;

  /// No description provided for @q_mv_008_opt2.
  ///
  /// In en, this message translates to:
  /// **'Tash Ma Tash'**
  String get q_mv_008_opt2;

  /// No description provided for @q_mv_008_opt3.
  ///
  /// In en, this message translates to:
  /// **'Al Douri'**
  String get q_mv_008_opt3;

  /// No description provided for @q_mv_008_opt4.
  ///
  /// In en, this message translates to:
  /// **'Selfie'**
  String get q_mv_008_opt4;

  /// No description provided for @q_mv_009_text.
  ///
  /// In en, this message translates to:
  /// **'Which TV show features old Gulf traditions and wisdom in a comedic way?'**
  String get q_mv_009_text;

  /// No description provided for @q_mv_009_opt1.
  ///
  /// In en, this message translates to:
  /// **'Darb Al Zalag'**
  String get q_mv_009_opt1;

  /// No description provided for @q_mv_009_opt2.
  ///
  /// In en, this message translates to:
  /// **'Freej'**
  String get q_mv_009_opt2;

  /// No description provided for @q_mv_009_opt3.
  ///
  /// In en, this message translates to:
  /// **'Selfie'**
  String get q_mv_009_opt3;

  /// No description provided for @q_mv_009_opt4.
  ///
  /// In en, this message translates to:
  /// **'Shaabiyat Al Cartoon'**
  String get q_mv_009_opt4;

  /// No description provided for @q_mv_010_text.
  ///
  /// In en, this message translates to:
  /// **'Who played the role of “Hassan” in “Darb Al Zalag”?'**
  String get q_mv_010_text;

  /// No description provided for @q_mv_010_opt1.
  ///
  /// In en, this message translates to:
  /// **'Abdulhussain Abdulredha'**
  String get q_mv_010_opt1;

  /// No description provided for @q_mv_010_opt2.
  ///
  /// In en, this message translates to:
  /// **'Saad Al-Faraj'**
  String get q_mv_010_opt2;

  /// No description provided for @q_mv_010_opt3.
  ///
  /// In en, this message translates to:
  /// **'Khaled Al-Nafisi'**
  String get q_mv_010_opt3;

  /// No description provided for @q_mv_010_opt4.
  ///
  /// In en, this message translates to:
  /// **'Ali Al-Mufidi'**
  String get q_mv_010_opt4;

  /// No description provided for @q_mv_011_text.
  ///
  /// In en, this message translates to:
  /// **'What is the main theme of the Syrian series “Bab Al-Hara”?'**
  String get q_mv_011_text;

  /// No description provided for @q_mv_011_opt1.
  ///
  /// In en, this message translates to:
  /// **'Life in old Damascus'**
  String get q_mv_011_opt1;

  /// No description provided for @q_mv_011_opt2.
  ///
  /// In en, this message translates to:
  /// **'Crime solving'**
  String get q_mv_011_opt2;

  /// No description provided for @q_mv_011_opt3.
  ///
  /// In en, this message translates to:
  /// **'Science fiction'**
  String get q_mv_011_opt3;

  /// No description provided for @q_mv_011_opt4.
  ///
  /// In en, this message translates to:
  /// **'Comedy'**
  String get q_mv_011_opt4;

  /// No description provided for @q_mv_012_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf actor starred in “Selfie,” known for social satire?'**
  String get q_mv_012_text;

  /// No description provided for @q_mv_012_opt1.
  ///
  /// In en, this message translates to:
  /// **'Nasser Al-Qasabi'**
  String get q_mv_012_opt1;

  /// No description provided for @q_mv_012_opt2.
  ///
  /// In en, this message translates to:
  /// **'Abdulhussain Abdulredha'**
  String get q_mv_012_opt2;

  /// No description provided for @q_mv_012_opt3.
  ///
  /// In en, this message translates to:
  /// **'Tariq Al-Ali'**
  String get q_mv_012_opt3;

  /// No description provided for @q_mv_012_opt4.
  ///
  /// In en, this message translates to:
  /// **'Saad Al-Faraj'**
  String get q_mv_012_opt4;

  /// No description provided for @q_mv_013_text.
  ///
  /// In en, this message translates to:
  /// **'Which Kuwaiti actress is known as the “Queen of Drama”?'**
  String get q_mv_013_text;

  /// No description provided for @q_mv_013_opt1.
  ///
  /// In en, this message translates to:
  /// **'Hayat Al-Fahad'**
  String get q_mv_013_opt1;

  /// No description provided for @q_mv_013_opt2.
  ///
  /// In en, this message translates to:
  /// **'Soad Abdullah'**
  String get q_mv_013_opt2;

  /// No description provided for @q_mv_013_opt3.
  ///
  /// In en, this message translates to:
  /// **'Haya Abdul Salam'**
  String get q_mv_013_opt3;

  /// No description provided for @q_mv_013_opt4.
  ///
  /// In en, this message translates to:
  /// **'Laila Abdullah'**
  String get q_mv_013_opt4;

  /// No description provided for @q_mv_014_text.
  ///
  /// In en, this message translates to:
  /// **'In which month do Gulf families usually enjoy new drama releases?'**
  String get q_mv_014_text;

  /// No description provided for @q_mv_014_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ramadan'**
  String get q_mv_014_opt1;

  /// No description provided for @q_mv_014_opt2.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get q_mv_014_opt2;

  /// No description provided for @q_mv_014_opt3.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get q_mv_014_opt3;

  /// No description provided for @q_mv_014_opt4.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get q_mv_014_opt4;

  /// No description provided for @q_mv_015_text.
  ///
  /// In en, this message translates to:
  /// **'Which Arab singer starred in the movie “The Message”?'**
  String get q_mv_015_text;

  /// No description provided for @q_mv_015_opt1.
  ///
  /// In en, this message translates to:
  /// **'Abdallah Al Rowaished'**
  String get q_mv_015_opt1;

  /// No description provided for @q_mv_015_opt2.
  ///
  /// In en, this message translates to:
  /// **'Omar Sharif'**
  String get q_mv_015_opt2;

  /// No description provided for @q_mv_015_opt3.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Abdo'**
  String get q_mv_015_opt3;

  /// No description provided for @q_mv_015_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mustafa Akkad'**
  String get q_mv_015_opt4;

  /// No description provided for @q_mv_016_text.
  ///
  /// In en, this message translates to:
  /// **'Which Emirati animated series celebrates traditional life and women’s friendship?'**
  String get q_mv_016_text;

  /// No description provided for @q_mv_016_opt1.
  ///
  /// In en, this message translates to:
  /// **'Freej'**
  String get q_mv_016_opt1;

  /// No description provided for @q_mv_016_opt2.
  ///
  /// In en, this message translates to:
  /// **'Shaabiyat Al Cartoon'**
  String get q_mv_016_opt2;

  /// No description provided for @q_mv_016_opt3.
  ///
  /// In en, this message translates to:
  /// **'Kids TV'**
  String get q_mv_016_opt3;

  /// No description provided for @q_mv_016_opt4.
  ///
  /// In en, this message translates to:
  /// **'Tash Ma Tash'**
  String get q_mv_016_opt4;

  /// No description provided for @q_mv_017_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf TV series was one of the first to tackle social issues openly?'**
  String get q_mv_017_text;

  /// No description provided for @q_mv_017_opt1.
  ///
  /// In en, this message translates to:
  /// **'Selfie'**
  String get q_mv_017_opt1;

  /// No description provided for @q_mv_017_opt2.
  ///
  /// In en, this message translates to:
  /// **'Tash Ma Tash'**
  String get q_mv_017_opt2;

  /// No description provided for @q_mv_017_opt3.
  ///
  /// In en, this message translates to:
  /// **'Shabab Al Bomb'**
  String get q_mv_017_opt3;

  /// No description provided for @q_mv_017_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hob Wahd'**
  String get q_mv_017_opt4;

  /// No description provided for @q_mv_018_text.
  ///
  /// In en, this message translates to:
  /// **'Which Egyptian actor is famous for his role in “The Yacoubian Building”?'**
  String get q_mv_018_text;

  /// No description provided for @q_mv_018_opt1.
  ///
  /// In en, this message translates to:
  /// **'Adel Imam'**
  String get q_mv_018_opt1;

  /// No description provided for @q_mv_018_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Helmy'**
  String get q_mv_018_opt2;

  /// No description provided for @q_mv_018_opt3.
  ///
  /// In en, this message translates to:
  /// **'Amr Diab'**
  String get q_mv_018_opt3;

  /// No description provided for @q_mv_018_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mohamed Ramadan'**
  String get q_mv_018_opt4;

  /// No description provided for @q_mv_019_text.
  ///
  /// In en, this message translates to:
  /// **'What is a common theme in Gulf family TV dramas?'**
  String get q_mv_019_text;

  /// No description provided for @q_mv_019_opt1.
  ///
  /// In en, this message translates to:
  /// **'Tradition and family values'**
  String get q_mv_019_opt1;

  /// No description provided for @q_mv_019_opt2.
  ///
  /// In en, this message translates to:
  /// **'Fantasy worlds'**
  String get q_mv_019_opt2;

  /// No description provided for @q_mv_019_opt3.
  ///
  /// In en, this message translates to:
  /// **'Action scenes'**
  String get q_mv_019_opt3;

  /// No description provided for @q_mv_019_opt4.
  ///
  /// In en, this message translates to:
  /// **'Science fiction'**
  String get q_mv_019_opt4;

  /// No description provided for @q_mv_020_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf actor is known for his comedic roles and popular stage performances?'**
  String get q_mv_020_text;

  /// No description provided for @q_mv_020_opt1.
  ///
  /// In en, this message translates to:
  /// **'Tariq Al-Ali'**
  String get q_mv_020_opt1;

  /// No description provided for @q_mv_020_opt2.
  ///
  /// In en, this message translates to:
  /// **'Saad Al-Faraj'**
  String get q_mv_020_opt2;

  /// No description provided for @q_mv_020_opt3.
  ///
  /// In en, this message translates to:
  /// **'Nasser Al-Qasabi'**
  String get q_mv_020_opt3;

  /// No description provided for @q_mv_020_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hayat Al-Fahad'**
  String get q_mv_020_opt4;

  /// No description provided for @q_mv_021_text.
  ///
  /// In en, this message translates to:
  /// **'What was the first color TV series produced in Kuwait?'**
  String get q_mv_021_text;

  /// No description provided for @q_mv_021_opt1.
  ///
  /// In en, this message translates to:
  /// **'Darb Al Zalag'**
  String get q_mv_021_opt1;

  /// No description provided for @q_mv_021_opt2.
  ///
  /// In en, this message translates to:
  /// **'Al Assouf'**
  String get q_mv_021_opt2;

  /// No description provided for @q_mv_021_opt3.
  ///
  /// In en, this message translates to:
  /// **'Al Darb Al Taweel'**
  String get q_mv_021_opt3;

  /// No description provided for @q_mv_021_opt4.
  ///
  /// In en, this message translates to:
  /// **'Bayt Al Tawa'**
  String get q_mv_021_opt4;

  /// No description provided for @q_mv_022_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf director is known for blending modern storytelling with tradition?'**
  String get q_mv_022_text;

  /// No description provided for @q_mv_022_opt1.
  ///
  /// In en, this message translates to:
  /// **'Saud Al-Khalaf'**
  String get q_mv_022_opt1;

  /// No description provided for @q_mv_022_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ali Al-Kandari'**
  String get q_mv_022_opt2;

  /// No description provided for @q_mv_022_opt3.
  ///
  /// In en, this message translates to:
  /// **'Hamad Al-Humaid'**
  String get q_mv_022_opt3;

  /// No description provided for @q_mv_022_opt4.
  ///
  /// In en, this message translates to:
  /// **'Fahad Al-Mufarrej'**
  String get q_mv_022_opt4;

  /// No description provided for @q_mv_023_text.
  ///
  /// In en, this message translates to:
  /// **'Which Arab TV channel is most known for premiering Ramadan dramas?'**
  String get q_mv_023_text;

  /// No description provided for @q_mv_023_opt1.
  ///
  /// In en, this message translates to:
  /// **'MBC'**
  String get q_mv_023_opt1;

  /// No description provided for @q_mv_023_opt2.
  ///
  /// In en, this message translates to:
  /// **'Dubai TV'**
  String get q_mv_023_opt2;

  /// No description provided for @q_mv_023_opt3.
  ///
  /// In en, this message translates to:
  /// **'Al Jazeera'**
  String get q_mv_023_opt3;

  /// No description provided for @q_mv_023_opt4.
  ///
  /// In en, this message translates to:
  /// **'Rotana Cinema'**
  String get q_mv_023_opt4;

  /// No description provided for @q_mv_024_text.
  ///
  /// In en, this message translates to:
  /// **'Which Kuwaiti film was nominated at international festivals for best short film?'**
  String get q_mv_024_text;

  /// No description provided for @q_mv_024_opt1.
  ///
  /// In en, this message translates to:
  /// **'The Watermelon'**
  String get q_mv_024_opt1;

  /// No description provided for @q_mv_024_opt2.
  ///
  /// In en, this message translates to:
  /// **'The Intruder'**
  String get q_mv_024_opt2;

  /// No description provided for @q_mv_024_opt3.
  ///
  /// In en, this message translates to:
  /// **'Between the Sand and the Sea'**
  String get q_mv_024_opt3;

  /// No description provided for @q_mv_024_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hob El Awal'**
  String get q_mv_024_opt4;

  /// No description provided for @q_mv_025_text.
  ///
  /// In en, this message translates to:
  /// **'What was the first Gulf movie to screen at Cannes Film Festival?'**
  String get q_mv_025_text;

  /// No description provided for @q_mv_025_opt1.
  ///
  /// In en, this message translates to:
  /// **'City of Life'**
  String get q_mv_025_opt1;

  /// No description provided for @q_mv_025_opt2.
  ///
  /// In en, this message translates to:
  /// **'Letters to Palestine'**
  String get q_mv_025_opt2;

  /// No description provided for @q_mv_025_opt3.
  ///
  /// In en, this message translates to:
  /// **'Wadjda'**
  String get q_mv_025_opt3;

  /// No description provided for @q_mv_025_opt4.
  ///
  /// In en, this message translates to:
  /// **'Sea Shadow'**
  String get q_mv_025_opt4;

  /// No description provided for @q_mv_026_text.
  ///
  /// In en, this message translates to:
  /// **'Which Saudi film made history as the first directed by a woman?'**
  String get q_mv_026_text;

  /// No description provided for @q_mv_026_opt1.
  ///
  /// In en, this message translates to:
  /// **'Wadjda'**
  String get q_mv_026_opt1;

  /// No description provided for @q_mv_026_opt2.
  ///
  /// In en, this message translates to:
  /// **'Barakah Meets Barakah'**
  String get q_mv_026_opt2;

  /// No description provided for @q_mv_026_opt3.
  ///
  /// In en, this message translates to:
  /// **'The Perfect Candidate'**
  String get q_mv_026_opt3;

  /// No description provided for @q_mv_026_opt4.
  ///
  /// In en, this message translates to:
  /// **'Scales'**
  String get q_mv_026_opt4;

  /// No description provided for @q_mv_027_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf actor is nicknamed “The Professor of Comedy”?'**
  String get q_mv_027_text;

  /// No description provided for @q_mv_027_opt1.
  ///
  /// In en, this message translates to:
  /// **'Abdulhussain Abdulredha'**
  String get q_mv_027_opt1;

  /// No description provided for @q_mv_027_opt2.
  ///
  /// In en, this message translates to:
  /// **'Tariq Al-Ali'**
  String get q_mv_027_opt2;

  /// No description provided for @q_mv_027_opt3.
  ///
  /// In en, this message translates to:
  /// **'Nasser Al-Qasabi'**
  String get q_mv_027_opt3;

  /// No description provided for @q_mv_027_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hayat Al-Fahad'**
  String get q_mv_027_opt4;

  /// No description provided for @q_mv_028_text.
  ///
  /// In en, this message translates to:
  /// **'Which UAE film told the story of friendship across generations?'**
  String get q_mv_028_text;

  /// No description provided for @q_mv_028_opt1.
  ///
  /// In en, this message translates to:
  /// **'Sea Shadow'**
  String get q_mv_028_opt1;

  /// No description provided for @q_mv_028_opt2.
  ///
  /// In en, this message translates to:
  /// **'City of Life'**
  String get q_mv_028_opt2;

  /// No description provided for @q_mv_028_opt3.
  ///
  /// In en, this message translates to:
  /// **'The Dreamer'**
  String get q_mv_028_opt3;

  /// No description provided for @q_mv_028_opt4.
  ///
  /// In en, this message translates to:
  /// **'The Diver'**
  String get q_mv_028_opt4;

  /// No description provided for @q_mv_029_text.
  ///
  /// In en, this message translates to:
  /// **'Which Saudi TV drama follows family struggles during the 1970s oil boom?'**
  String get q_mv_029_text;

  /// No description provided for @q_mv_029_opt1.
  ///
  /// In en, this message translates to:
  /// **'Al Assouf'**
  String get q_mv_029_opt1;

  /// No description provided for @q_mv_029_opt2.
  ///
  /// In en, this message translates to:
  /// **'Selfie'**
  String get q_mv_029_opt2;

  /// No description provided for @q_mv_029_opt3.
  ///
  /// In en, this message translates to:
  /// **'Shabab Al Bomb'**
  String get q_mv_029_opt3;

  /// No description provided for @q_mv_029_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hob Wahd'**
  String get q_mv_029_opt4;

  /// No description provided for @q_mv_030_text.
  ///
  /// In en, this message translates to:
  /// **'Who is the famous Egyptian comedian known as “El Zaeem”?'**
  String get q_mv_030_text;

  /// No description provided for @q_mv_030_opt1.
  ///
  /// In en, this message translates to:
  /// **'Adel Imam'**
  String get q_mv_030_opt1;

  /// No description provided for @q_mv_030_opt2.
  ///
  /// In en, this message translates to:
  /// **'Mohamed Henedy'**
  String get q_mv_030_opt2;

  /// No description provided for @q_mv_030_opt3.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Mekky'**
  String get q_mv_030_opt3;

  /// No description provided for @q_mv_030_opt4.
  ///
  /// In en, this message translates to:
  /// **'Omar Sharif'**
  String get q_mv_030_opt4;

  /// No description provided for @q_mu_001_text.
  ///
  /// In en, this message translates to:
  /// **'Who is known as the “Artist of the Arabs”?'**
  String get q_mu_001_text;

  /// No description provided for @q_mu_001_opt1.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Abdu'**
  String get q_mu_001_opt1;

  /// No description provided for @q_mu_001_opt2.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_001_opt2;

  /// No description provided for @q_mu_001_opt3.
  ///
  /// In en, this message translates to:
  /// **'Abdallah Al Rowaished'**
  String get q_mu_001_opt3;

  /// No description provided for @q_mu_001_opt4.
  ///
  /// In en, this message translates to:
  /// **'Kadim Al Sahir'**
  String get q_mu_001_opt4;

  /// No description provided for @q_mu_002_text.
  ///
  /// In en, this message translates to:
  /// **'Which Kuwaiti singer is known for the song “Ya Tayr El Hob”?'**
  String get q_mu_002_text;

  /// No description provided for @q_mu_002_opt1.
  ///
  /// In en, this message translates to:
  /// **'Abdallah Al Rowaished'**
  String get q_mu_002_opt1;

  /// No description provided for @q_mu_002_opt2.
  ///
  /// In en, this message translates to:
  /// **'Nabeel Shuail'**
  String get q_mu_002_opt2;

  /// No description provided for @q_mu_002_opt3.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_002_opt3;

  /// No description provided for @q_mu_002_opt4.
  ///
  /// In en, this message translates to:
  /// **'Talal Maddah'**
  String get q_mu_002_opt4;

  /// No description provided for @q_mu_003_text.
  ///
  /// In en, this message translates to:
  /// **'What instrument is commonly used in traditional Gulf music?'**
  String get q_mu_003_text;

  /// No description provided for @q_mu_003_opt1.
  ///
  /// In en, this message translates to:
  /// **'Oud'**
  String get q_mu_003_opt1;

  /// No description provided for @q_mu_003_opt2.
  ///
  /// In en, this message translates to:
  /// **'Guitar'**
  String get q_mu_003_opt2;

  /// No description provided for @q_mu_003_opt3.
  ///
  /// In en, this message translates to:
  /// **'Piano'**
  String get q_mu_003_opt3;

  /// No description provided for @q_mu_003_opt4.
  ///
  /// In en, this message translates to:
  /// **'Violin'**
  String get q_mu_003_opt4;

  /// No description provided for @q_mu_004_text.
  ///
  /// In en, this message translates to:
  /// **'Which Saudi singer performed “El Amaken”?'**
  String get q_mu_004_text;

  /// No description provided for @q_mu_004_opt1.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Abdu'**
  String get q_mu_004_opt1;

  /// No description provided for @q_mu_004_opt2.
  ///
  /// In en, this message translates to:
  /// **'Abdul Majeed Abdullah'**
  String get q_mu_004_opt2;

  /// No description provided for @q_mu_004_opt3.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_004_opt3;

  /// No description provided for @q_mu_004_opt4.
  ///
  /// In en, this message translates to:
  /// **'Nabeel Shuail'**
  String get q_mu_004_opt4;

  /// No description provided for @q_mu_005_text.
  ///
  /// In en, this message translates to:
  /// **'Which Emirati singer is known for the hit “Ahebbak”?'**
  String get q_mu_005_text;

  /// No description provided for @q_mu_005_opt1.
  ///
  /// In en, this message translates to:
  /// **'Hussain Al Jassmi'**
  String get q_mu_005_opt1;

  /// No description provided for @q_mu_005_opt2.
  ///
  /// In en, this message translates to:
  /// **'Balqees Fathi'**
  String get q_mu_005_opt2;

  /// No description provided for @q_mu_005_opt3.
  ///
  /// In en, this message translates to:
  /// **'Fahad Al Kubaisi'**
  String get q_mu_005_opt3;

  /// No description provided for @q_mu_005_opt4.
  ///
  /// In en, this message translates to:
  /// **'Abdul Majeed Abdullah'**
  String get q_mu_005_opt4;

  /// No description provided for @q_mu_006_text.
  ///
  /// In en, this message translates to:
  /// **'Which musical style features drums and rhythmic clapping at weddings?'**
  String get q_mu_006_text;

  /// No description provided for @q_mu_006_opt1.
  ///
  /// In en, this message translates to:
  /// **'Laywa'**
  String get q_mu_006_opt1;

  /// No description provided for @q_mu_006_opt2.
  ///
  /// In en, this message translates to:
  /// **'Hip hop'**
  String get q_mu_006_opt2;

  /// No description provided for @q_mu_006_opt3.
  ///
  /// In en, this message translates to:
  /// **'Jazz'**
  String get q_mu_006_opt3;

  /// No description provided for @q_mu_006_opt4.
  ///
  /// In en, this message translates to:
  /// **'Techno'**
  String get q_mu_006_opt4;

  /// No description provided for @q_mu_007_text.
  ///
  /// In en, this message translates to:
  /// **'Which country is singer Rashed Al-Majed from?'**
  String get q_mu_007_text;

  /// No description provided for @q_mu_007_opt1.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get q_mu_007_opt1;

  /// No description provided for @q_mu_007_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_mu_007_opt2;

  /// No description provided for @q_mu_007_opt3.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_mu_007_opt3;

  /// No description provided for @q_mu_007_opt4.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_mu_007_opt4;

  /// No description provided for @q_mu_008_text.
  ///
  /// In en, this message translates to:
  /// **'Which Emirati singer became popular with “Boshret Khair”?'**
  String get q_mu_008_text;

  /// No description provided for @q_mu_008_opt1.
  ///
  /// In en, this message translates to:
  /// **'Hussain Al Jassmi'**
  String get q_mu_008_opt1;

  /// No description provided for @q_mu_008_opt2.
  ///
  /// In en, this message translates to:
  /// **'Majid Al Mohandis'**
  String get q_mu_008_opt2;

  /// No description provided for @q_mu_008_opt3.
  ///
  /// In en, this message translates to:
  /// **'Abdul Majeed Abdullah'**
  String get q_mu_008_opt3;

  /// No description provided for @q_mu_008_opt4.
  ///
  /// In en, this message translates to:
  /// **'Balqees Fathi'**
  String get q_mu_008_opt4;

  /// No description provided for @q_mu_009_text.
  ///
  /// In en, this message translates to:
  /// **'What is the traditional dance performed to live drumming in Gulf weddings?'**
  String get q_mu_009_text;

  /// No description provided for @q_mu_009_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ardah'**
  String get q_mu_009_opt1;

  /// No description provided for @q_mu_009_opt2.
  ///
  /// In en, this message translates to:
  /// **'Samba'**
  String get q_mu_009_opt2;

  /// No description provided for @q_mu_009_opt3.
  ///
  /// In en, this message translates to:
  /// **'Ballet'**
  String get q_mu_009_opt3;

  /// No description provided for @q_mu_009_opt4.
  ///
  /// In en, this message translates to:
  /// **'Salsa'**
  String get q_mu_009_opt4;

  /// No description provided for @q_mu_010_text.
  ///
  /// In en, this message translates to:
  /// **'Which Kuwaiti artist is called “The Voice of Kuwait”?'**
  String get q_mu_010_text;

  /// No description provided for @q_mu_010_opt1.
  ///
  /// In en, this message translates to:
  /// **'Nabeel Shuail'**
  String get q_mu_010_opt1;

  /// No description provided for @q_mu_010_opt2.
  ///
  /// In en, this message translates to:
  /// **'Abdallah Al Rowaished'**
  String get q_mu_010_opt2;

  /// No description provided for @q_mu_010_opt3.
  ///
  /// In en, this message translates to:
  /// **'Bader Al Shuaibi'**
  String get q_mu_010_opt3;

  /// No description provided for @q_mu_010_opt4.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_010_opt4;

  /// No description provided for @q_mu_011_text.
  ///
  /// In en, this message translates to:
  /// **'Which Iraqi artist is known as “The Caesar of Arabic Song”?'**
  String get q_mu_011_text;

  /// No description provided for @q_mu_011_opt1.
  ///
  /// In en, this message translates to:
  /// **'Kadim Al Sahir'**
  String get q_mu_011_opt1;

  /// No description provided for @q_mu_011_opt2.
  ///
  /// In en, this message translates to:
  /// **'Majid Al Mohandis'**
  String get q_mu_011_opt2;

  /// No description provided for @q_mu_011_opt3.
  ///
  /// In en, this message translates to:
  /// **'Saber Rebai'**
  String get q_mu_011_opt3;

  /// No description provided for @q_mu_011_opt4.
  ///
  /// In en, this message translates to:
  /// **'Amr Diab'**
  String get q_mu_011_opt4;

  /// No description provided for @q_mu_012_text.
  ///
  /// In en, this message translates to:
  /// **'Which Saudi artist is known for the song “Ya Taib El Galb”?'**
  String get q_mu_012_text;

  /// No description provided for @q_mu_012_opt1.
  ///
  /// In en, this message translates to:
  /// **'Abdul Majeed Abdullah'**
  String get q_mu_012_opt1;

  /// No description provided for @q_mu_012_opt2.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Abdu'**
  String get q_mu_012_opt2;

  /// No description provided for @q_mu_012_opt3.
  ///
  /// In en, this message translates to:
  /// **'Majid Al Mohandis'**
  String get q_mu_012_opt3;

  /// No description provided for @q_mu_012_opt4.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_012_opt4;

  /// No description provided for @q_mu_013_text.
  ///
  /// In en, this message translates to:
  /// **'Which female Emirati singer is the daughter of Ahmed Fathi?'**
  String get q_mu_013_text;

  /// No description provided for @q_mu_013_opt1.
  ///
  /// In en, this message translates to:
  /// **'Balqees Fathi'**
  String get q_mu_013_opt1;

  /// No description provided for @q_mu_013_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ahlam Al Shamsi'**
  String get q_mu_013_opt2;

  /// No description provided for @q_mu_013_opt3.
  ///
  /// In en, this message translates to:
  /// **'Diana Haddad'**
  String get q_mu_013_opt3;

  /// No description provided for @q_mu_013_opt4.
  ///
  /// In en, this message translates to:
  /// **'Shamma Hamdan'**
  String get q_mu_013_opt4;

  /// No description provided for @q_mu_014_text.
  ///
  /// In en, this message translates to:
  /// **'Which Egyptian pop singer is famous for “Tamally Maak”?'**
  String get q_mu_014_text;

  /// No description provided for @q_mu_014_opt1.
  ///
  /// In en, this message translates to:
  /// **'Amr Diab'**
  String get q_mu_014_opt1;

  /// No description provided for @q_mu_014_opt2.
  ///
  /// In en, this message translates to:
  /// **'Tamer Hosny'**
  String get q_mu_014_opt2;

  /// No description provided for @q_mu_014_opt3.
  ///
  /// In en, this message translates to:
  /// **'Mohamed Hamaki'**
  String get q_mu_014_opt3;

  /// No description provided for @q_mu_014_opt4.
  ///
  /// In en, this message translates to:
  /// **'Ramy Sabry'**
  String get q_mu_014_opt4;

  /// No description provided for @q_mu_015_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf traditional instrument produces deep drum beats?'**
  String get q_mu_015_text;

  /// No description provided for @q_mu_015_opt1.
  ///
  /// In en, this message translates to:
  /// **'Mirwas'**
  String get q_mu_015_opt1;

  /// No description provided for @q_mu_015_opt2.
  ///
  /// In en, this message translates to:
  /// **'Tabla'**
  String get q_mu_015_opt2;

  /// No description provided for @q_mu_015_opt3.
  ///
  /// In en, this message translates to:
  /// **'Tambourine'**
  String get q_mu_015_opt3;

  /// No description provided for @q_mu_015_opt4.
  ///
  /// In en, this message translates to:
  /// **'Cajón'**
  String get q_mu_015_opt4;

  /// No description provided for @q_mu_016_text.
  ///
  /// In en, this message translates to:
  /// **'Which Lebanese singer is known for her hit “Ya Tabtab”?'**
  String get q_mu_016_text;

  /// No description provided for @q_mu_016_opt1.
  ///
  /// In en, this message translates to:
  /// **'Nancy Ajram'**
  String get q_mu_016_opt1;

  /// No description provided for @q_mu_016_opt2.
  ///
  /// In en, this message translates to:
  /// **'Elissa'**
  String get q_mu_016_opt2;

  /// No description provided for @q_mu_016_opt3.
  ///
  /// In en, this message translates to:
  /// **'Haifa Wehbe'**
  String get q_mu_016_opt3;

  /// No description provided for @q_mu_016_opt4.
  ///
  /// In en, this message translates to:
  /// **'Myriam Fares'**
  String get q_mu_016_opt4;

  /// No description provided for @q_mu_017_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf artist famously sang at Expo 2020 Dubai opening?'**
  String get q_mu_017_text;

  /// No description provided for @q_mu_017_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ahlam Al Shamsi'**
  String get q_mu_017_opt1;

  /// No description provided for @q_mu_017_opt2.
  ///
  /// In en, this message translates to:
  /// **'Hussain Al Jassmi'**
  String get q_mu_017_opt2;

  /// No description provided for @q_mu_017_opt3.
  ///
  /// In en, this message translates to:
  /// **'Balqees Fathi'**
  String get q_mu_017_opt3;

  /// No description provided for @q_mu_017_opt4.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_017_opt4;

  /// No description provided for @q_mu_018_text.
  ///
  /// In en, this message translates to:
  /// **'Which Saudi musician is known for blending pop and traditional sounds?'**
  String get q_mu_018_text;

  /// No description provided for @q_mu_018_opt1.
  ///
  /// In en, this message translates to:
  /// **'Abdul Majeed Abdullah'**
  String get q_mu_018_opt1;

  /// No description provided for @q_mu_018_opt2.
  ///
  /// In en, this message translates to:
  /// **'Tariq Al-Harbi'**
  String get q_mu_018_opt2;

  /// No description provided for @q_mu_018_opt3.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_018_opt3;

  /// No description provided for @q_mu_018_opt4.
  ///
  /// In en, this message translates to:
  /// **'Talal Maddah'**
  String get q_mu_018_opt4;

  /// No description provided for @q_mu_019_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf female singer is known as “Queen of Stage”?'**
  String get q_mu_019_text;

  /// No description provided for @q_mu_019_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ahlam Al Shamsi'**
  String get q_mu_019_opt1;

  /// No description provided for @q_mu_019_opt2.
  ///
  /// In en, this message translates to:
  /// **'Balqees Fathi'**
  String get q_mu_019_opt2;

  /// No description provided for @q_mu_019_opt3.
  ///
  /// In en, this message translates to:
  /// **'Diana Haddad'**
  String get q_mu_019_opt3;

  /// No description provided for @q_mu_019_opt4.
  ///
  /// In en, this message translates to:
  /// **'Shamma Hamdan'**
  String get q_mu_019_opt4;

  /// No description provided for @q_mu_020_text.
  ///
  /// In en, this message translates to:
  /// **'Which Arabic song became a global hit with its “Habibi” lyrics?'**
  String get q_mu_020_text;

  /// No description provided for @q_mu_020_opt1.
  ///
  /// In en, this message translates to:
  /// **'Habibi Ya Nour El Ain'**
  String get q_mu_020_opt1;

  /// No description provided for @q_mu_020_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ya Tabtab'**
  String get q_mu_020_opt2;

  /// No description provided for @q_mu_020_opt3.
  ///
  /// In en, this message translates to:
  /// **'Ahebbak'**
  String get q_mu_020_opt3;

  /// No description provided for @q_mu_020_opt4.
  ///
  /// In en, this message translates to:
  /// **'Tamally Maak'**
  String get q_mu_020_opt4;

  /// No description provided for @q_mu_021_text.
  ///
  /// In en, this message translates to:
  /// **'Who composed the Saudi national anthem?'**
  String get q_mu_021_text;

  /// No description provided for @q_mu_021_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ibrahim Khafaji'**
  String get q_mu_021_opt1;

  /// No description provided for @q_mu_021_opt2.
  ///
  /// In en, this message translates to:
  /// **'Talal Maddah'**
  String get q_mu_021_opt2;

  /// No description provided for @q_mu_021_opt3.
  ///
  /// In en, this message translates to:
  /// **'Abdulrahman Al-Khateeb'**
  String get q_mu_021_opt3;

  /// No description provided for @q_mu_021_opt4.
  ///
  /// In en, this message translates to:
  /// **'Abdul Majeed Abdullah'**
  String get q_mu_021_opt4;

  /// No description provided for @q_mu_022_text.
  ///
  /// In en, this message translates to:
  /// **'Which Kuwaiti composer is known for shaping the Gulf musical identity?'**
  String get q_mu_022_text;

  /// No description provided for @q_mu_022_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ahmad Baqer'**
  String get q_mu_022_opt1;

  /// No description provided for @q_mu_022_opt2.
  ///
  /// In en, this message translates to:
  /// **'Bader Al Shuaibi'**
  String get q_mu_022_opt2;

  /// No description provided for @q_mu_022_opt3.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Shams'**
  String get q_mu_022_opt3;

  /// No description provided for @q_mu_022_opt4.
  ///
  /// In en, this message translates to:
  /// **'Nabeel Shuail'**
  String get q_mu_022_opt4;

  /// No description provided for @q_mu_023_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf singer was called “The Golden Voice of Arabia”?'**
  String get q_mu_023_text;

  /// No description provided for @q_mu_023_opt1.
  ///
  /// In en, this message translates to:
  /// **'Talal Maddah'**
  String get q_mu_023_opt1;

  /// No description provided for @q_mu_023_opt2.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Abdu'**
  String get q_mu_023_opt2;

  /// No description provided for @q_mu_023_opt3.
  ///
  /// In en, this message translates to:
  /// **'Abdul Majeed Abdullah'**
  String get q_mu_023_opt3;

  /// No description provided for @q_mu_023_opt4.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_023_opt4;

  /// No description provided for @q_mu_024_text.
  ///
  /// In en, this message translates to:
  /// **'Which country is home to the annual “Winter at Tantora” music festival?'**
  String get q_mu_024_text;

  /// No description provided for @q_mu_024_opt1.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get q_mu_024_opt1;

  /// No description provided for @q_mu_024_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get q_mu_024_opt2;

  /// No description provided for @q_mu_024_opt3.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_mu_024_opt3;

  /// No description provided for @q_mu_024_opt4.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_mu_024_opt4;

  /// No description provided for @q_mu_025_text.
  ///
  /// In en, this message translates to:
  /// **'Which musical form combines poetry and rhythm in Gulf tradition?'**
  String get q_mu_025_text;

  /// No description provided for @q_mu_025_opt1.
  ///
  /// In en, this message translates to:
  /// **'Samri'**
  String get q_mu_025_opt1;

  /// No description provided for @q_mu_025_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ardah'**
  String get q_mu_025_opt2;

  /// No description provided for @q_mu_025_opt3.
  ///
  /// In en, this message translates to:
  /// **'Laywa'**
  String get q_mu_025_opt3;

  /// No description provided for @q_mu_025_opt4.
  ///
  /// In en, this message translates to:
  /// **'Khaleeji pop'**
  String get q_mu_025_opt4;

  /// No description provided for @q_mu_026_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf singer collaborated with international artist RedOne?'**
  String get q_mu_026_text;

  /// No description provided for @q_mu_026_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ahlam Al Shamsi'**
  String get q_mu_026_opt1;

  /// No description provided for @q_mu_026_opt2.
  ///
  /// In en, this message translates to:
  /// **'Balqees Fathi'**
  String get q_mu_026_opt2;

  /// No description provided for @q_mu_026_opt3.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_026_opt3;

  /// No description provided for @q_mu_026_opt4.
  ///
  /// In en, this message translates to:
  /// **'Abdul Majeed Abdullah'**
  String get q_mu_026_opt4;

  /// No description provided for @q_mu_027_text.
  ///
  /// In en, this message translates to:
  /// **'Which Bahraini singer is known for the song “Ma’ak Rouh”?'**
  String get q_mu_027_text;

  /// No description provided for @q_mu_027_opt1.
  ///
  /// In en, this message translates to:
  /// **'Hala Al Turk'**
  String get q_mu_027_opt1;

  /// No description provided for @q_mu_027_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Al Jumairi'**
  String get q_mu_027_opt2;

  /// No description provided for @q_mu_027_opt3.
  ///
  /// In en, this message translates to:
  /// **'Isa Qattan'**
  String get q_mu_027_opt3;

  /// No description provided for @q_mu_027_opt4.
  ///
  /// In en, this message translates to:
  /// **'Khaled Fouad'**
  String get q_mu_027_opt4;

  /// No description provided for @q_mu_028_text.
  ///
  /// In en, this message translates to:
  /// **'Which legendary Egyptian singer was known as “Kawkab El Sharq” (Star of the East)?'**
  String get q_mu_028_text;

  /// No description provided for @q_mu_028_opt1.
  ///
  /// In en, this message translates to:
  /// **'Umm Kulthum'**
  String get q_mu_028_opt1;

  /// No description provided for @q_mu_028_opt2.
  ///
  /// In en, this message translates to:
  /// **'Fairouz'**
  String get q_mu_028_opt2;

  /// No description provided for @q_mu_028_opt3.
  ///
  /// In en, this message translates to:
  /// **'Abdel Halim Hafez'**
  String get q_mu_028_opt3;

  /// No description provided for @q_mu_028_opt4.
  ///
  /// In en, this message translates to:
  /// **'Warda Al Jazairia'**
  String get q_mu_028_opt4;

  /// No description provided for @q_mu_029_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf musician pioneered the modern “Khaleeji pop” genre?'**
  String get q_mu_029_text;

  /// No description provided for @q_mu_029_opt1.
  ///
  /// In en, this message translates to:
  /// **'Rashed Al-Majed'**
  String get q_mu_029_opt1;

  /// No description provided for @q_mu_029_opt2.
  ///
  /// In en, this message translates to:
  /// **'Talal Maddah'**
  String get q_mu_029_opt2;

  /// No description provided for @q_mu_029_opt3.
  ///
  /// In en, this message translates to:
  /// **'Abdallah Al Rowaished'**
  String get q_mu_029_opt3;

  /// No description provided for @q_mu_029_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Abdu'**
  String get q_mu_029_opt4;

  /// No description provided for @q_mu_030_text.
  ///
  /// In en, this message translates to:
  /// **'Which Arabic singer performed the famous song “Enta Omri”?'**
  String get q_mu_030_text;

  /// No description provided for @q_mu_030_opt1.
  ///
  /// In en, this message translates to:
  /// **'Umm Kulthum'**
  String get q_mu_030_opt1;

  /// No description provided for @q_mu_030_opt2.
  ///
  /// In en, this message translates to:
  /// **'Fairouz'**
  String get q_mu_030_opt2;

  /// No description provided for @q_mu_030_opt3.
  ///
  /// In en, this message translates to:
  /// **'Warda'**
  String get q_mu_030_opt3;

  /// No description provided for @q_mu_030_opt4.
  ///
  /// In en, this message translates to:
  /// **'Samira Said'**
  String get q_mu_030_opt4;

  /// No description provided for @q_fc_001_text.
  ///
  /// In en, this message translates to:
  /// **'Make your teammates laugh in under 15 seconds!'**
  String get q_fc_001_text;

  /// No description provided for @q_fc_002_text.
  ///
  /// In en, this message translates to:
  /// **'Talk like a robot for the next 20 seconds.'**
  String get q_fc_002_text;

  /// No description provided for @q_fc_003_text.
  ///
  /// In en, this message translates to:
  /// **'Act like a cat trying to catch a laser pointer.'**
  String get q_fc_003_text;

  /// No description provided for @q_fc_004_text.
  ///
  /// In en, this message translates to:
  /// **'Say your full name backward as fast as you can.'**
  String get q_fc_004_text;

  /// No description provided for @q_fc_005_text.
  ///
  /// In en, this message translates to:
  /// **'Pretend you are a famous singer performing on stage.'**
  String get q_fc_005_text;

  /// No description provided for @q_fc_006_text.
  ///
  /// In en, this message translates to:
  /// **'Dance without music for 10 seconds.'**
  String get q_fc_006_text;

  /// No description provided for @q_fc_007_text.
  ///
  /// In en, this message translates to:
  /// **'Imitate a crying baby until everyone laughs.'**
  String get q_fc_007_text;

  /// No description provided for @q_fc_008_text.
  ///
  /// In en, this message translates to:
  /// **'Say “Dorak” five times as fast as possible without mistakes.'**
  String get q_fc_008_text;

  /// No description provided for @q_fc_009_text.
  ///
  /// In en, this message translates to:
  /// **'Pretend your hand is a phone and talk to your “best friend.”'**
  String get q_fc_009_text;

  /// No description provided for @q_fc_010_text.
  ///
  /// In en, this message translates to:
  /// **'Stand on one leg for 10 seconds while saying the alphabet backward.'**
  String get q_fc_010_text;

  /// No description provided for @q_fc_011_text.
  ///
  /// In en, this message translates to:
  /// **'Do 10 jumping jacks while making a funny sound after each one.'**
  String get q_fc_011_text;

  /// No description provided for @q_fc_012_text.
  ///
  /// In en, this message translates to:
  /// **'Act like an animal your team chooses for 15 seconds.'**
  String get q_fc_012_text;

  /// No description provided for @q_fc_013_text.
  ///
  /// In en, this message translates to:
  /// **'Hold a silly face for 10 seconds without laughing.'**
  String get q_fc_013_text;

  /// No description provided for @q_fc_014_text.
  ///
  /// In en, this message translates to:
  /// **'Pretend you are stuck inside a box and try to get out.'**
  String get q_fc_014_text;

  /// No description provided for @q_fc_015_text.
  ///
  /// In en, this message translates to:
  /// **'Spin around three times, then walk in a straight line.'**
  String get q_fc_015_text;

  /// No description provided for @q_fc_016_text.
  ///
  /// In en, this message translates to:
  /// **'Say everything you speak for the next 30 seconds in song.'**
  String get q_fc_016_text;

  /// No description provided for @q_fc_017_text.
  ///
  /// In en, this message translates to:
  /// **'Act out brushing your teeth in slow motion.'**
  String get q_fc_017_text;

  /// No description provided for @q_fc_018_text.
  ///
  /// In en, this message translates to:
  /// **'Pretend to interview your teammate as if they are a celebrity.'**
  String get q_fc_018_text;

  /// No description provided for @q_fc_019_text.
  ///
  /// In en, this message translates to:
  /// **'Make up a dance move and name it after yourself.'**
  String get q_fc_019_text;

  /// No description provided for @q_fc_020_text.
  ///
  /// In en, this message translates to:
  /// **'Tell a one-minute story using only animal sounds.'**
  String get q_fc_020_text;

  /// No description provided for @q_fc_021_text.
  ///
  /// In en, this message translates to:
  /// **'Balance something on your head for 20 seconds without dropping it.'**
  String get q_fc_021_text;

  /// No description provided for @q_fc_022_text.
  ///
  /// In en, this message translates to:
  /// **'Do 10 push-ups while your team cheers you on.'**
  String get q_fc_022_text;

  /// No description provided for @q_fc_023_text.
  ///
  /// In en, this message translates to:
  /// **'Act like a news reporter giving “breaking news” about your team.'**
  String get q_fc_023_text;

  /// No description provided for @q_fc_024_text.
  ///
  /// In en, this message translates to:
  /// **'Imitate your teammate’s laugh until everyone laughs.'**
  String get q_fc_024_text;

  /// No description provided for @q_fc_025_text.
  ///
  /// In en, this message translates to:
  /// **'Say a tongue twister five times correctly: “She sells seashells by the seashore.”'**
  String get q_fc_025_text;

  /// No description provided for @q_fc_026_text.
  ///
  /// In en, this message translates to:
  /// **'Make up a commercial for an imaginary product (like “Invisible Shoes”).'**
  String get q_fc_026_text;

  /// No description provided for @q_fc_027_text.
  ///
  /// In en, this message translates to:
  /// **'Pretend to be a chef teaching how to cook “air soup.”'**
  String get q_fc_027_text;

  /// No description provided for @q_fc_028_text.
  ///
  /// In en, this message translates to:
  /// **'Spin in a circle while singing your favorite song.'**
  String get q_fc_028_text;

  /// No description provided for @q_fc_029_text.
  ///
  /// In en, this message translates to:
  /// **'Pass the phone to another player while clapping rhythmically.'**
  String get q_fc_029_text;

  /// No description provided for @q_fc_030_text.
  ///
  /// In en, this message translates to:
  /// **'Do your best imitation of a famous movie villain for 20 seconds.'**
  String get q_fc_030_text;

  /// No description provided for @q_kc_001_text.
  ///
  /// In en, this message translates to:
  /// **'What color is the sky on a clear, sunny day?'**
  String get q_kc_001_text;

  /// No description provided for @q_kc_001_opt1.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get q_kc_001_opt1;

  /// No description provided for @q_kc_001_opt2.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get q_kc_001_opt2;

  /// No description provided for @q_kc_001_opt3.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get q_kc_001_opt3;

  /// No description provided for @q_kc_001_opt4.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get q_kc_001_opt4;

  /// No description provided for @q_kc_002_text.
  ///
  /// In en, this message translates to:
  /// **'How many legs does a cat have?'**
  String get q_kc_002_text;

  /// No description provided for @q_kc_002_opt1.
  ///
  /// In en, this message translates to:
  /// **'Four'**
  String get q_kc_002_opt1;

  /// No description provided for @q_kc_002_opt2.
  ///
  /// In en, this message translates to:
  /// **'Two'**
  String get q_kc_002_opt2;

  /// No description provided for @q_kc_002_opt3.
  ///
  /// In en, this message translates to:
  /// **'Six'**
  String get q_kc_002_opt3;

  /// No description provided for @q_kc_002_opt4.
  ///
  /// In en, this message translates to:
  /// **'Eight'**
  String get q_kc_002_opt4;

  /// No description provided for @q_kc_003_text.
  ///
  /// In en, this message translates to:
  /// **'Which animal says “Moo”?'**
  String get q_kc_003_text;

  /// No description provided for @q_kc_003_opt1.
  ///
  /// In en, this message translates to:
  /// **'Cow'**
  String get q_kc_003_opt1;

  /// No description provided for @q_kc_003_opt2.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get q_kc_003_opt2;

  /// No description provided for @q_kc_003_opt3.
  ///
  /// In en, this message translates to:
  /// **'Sheep'**
  String get q_kc_003_opt3;

  /// No description provided for @q_kc_003_opt4.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get q_kc_003_opt4;

  /// No description provided for @q_kc_004_text.
  ///
  /// In en, this message translates to:
  /// **'What do bees make?'**
  String get q_kc_004_text;

  /// No description provided for @q_kc_004_opt1.
  ///
  /// In en, this message translates to:
  /// **'Honey'**
  String get q_kc_004_opt1;

  /// No description provided for @q_kc_004_opt2.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get q_kc_004_opt2;

  /// No description provided for @q_kc_004_opt3.
  ///
  /// In en, this message translates to:
  /// **'Butter'**
  String get q_kc_004_opt3;

  /// No description provided for @q_kc_004_opt4.
  ///
  /// In en, this message translates to:
  /// **'Juice'**
  String get q_kc_004_opt4;

  /// No description provided for @q_kc_005_text.
  ///
  /// In en, this message translates to:
  /// **'What is 2 + 3?'**
  String get q_kc_005_text;

  /// No description provided for @q_kc_005_opt1.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get q_kc_005_opt1;

  /// No description provided for @q_kc_005_opt2.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get q_kc_005_opt2;

  /// No description provided for @q_kc_005_opt3.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get q_kc_005_opt3;

  /// No description provided for @q_kc_005_opt4.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get q_kc_005_opt4;

  /// No description provided for @q_kc_006_text.
  ///
  /// In en, this message translates to:
  /// **'Which fruit keeps the doctor away if you eat one every day?'**
  String get q_kc_006_text;

  /// No description provided for @q_kc_006_opt1.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get q_kc_006_opt1;

  /// No description provided for @q_kc_006_opt2.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get q_kc_006_opt2;

  /// No description provided for @q_kc_006_opt3.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get q_kc_006_opt3;

  /// No description provided for @q_kc_006_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mango'**
  String get q_kc_006_opt4;

  /// No description provided for @q_kc_007_text.
  ///
  /// In en, this message translates to:
  /// **'What color are bananas when they are ripe?'**
  String get q_kc_007_text;

  /// No description provided for @q_kc_007_opt1.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get q_kc_007_opt1;

  /// No description provided for @q_kc_007_opt2.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get q_kc_007_opt2;

  /// No description provided for @q_kc_007_opt3.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get q_kc_007_opt3;

  /// No description provided for @q_kc_007_opt4.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get q_kc_007_opt4;

  /// No description provided for @q_kc_008_text.
  ///
  /// In en, this message translates to:
  /// **'Which planet do we live on?'**
  String get q_kc_008_text;

  /// No description provided for @q_kc_008_opt1.
  ///
  /// In en, this message translates to:
  /// **'Earth'**
  String get q_kc_008_opt1;

  /// No description provided for @q_kc_008_opt2.
  ///
  /// In en, this message translates to:
  /// **'Mars'**
  String get q_kc_008_opt2;

  /// No description provided for @q_kc_008_opt3.
  ///
  /// In en, this message translates to:
  /// **'Venus'**
  String get q_kc_008_opt3;

  /// No description provided for @q_kc_008_opt4.
  ///
  /// In en, this message translates to:
  /// **'Jupiter'**
  String get q_kc_008_opt4;

  /// No description provided for @q_kc_009_text.
  ///
  /// In en, this message translates to:
  /// **'What do you call a baby dog?'**
  String get q_kc_009_text;

  /// No description provided for @q_kc_009_opt1.
  ///
  /// In en, this message translates to:
  /// **'Puppy'**
  String get q_kc_009_opt1;

  /// No description provided for @q_kc_009_opt2.
  ///
  /// In en, this message translates to:
  /// **'Kitten'**
  String get q_kc_009_opt2;

  /// No description provided for @q_kc_009_opt3.
  ///
  /// In en, this message translates to:
  /// **'Cub'**
  String get q_kc_009_opt3;

  /// No description provided for @q_kc_009_opt4.
  ///
  /// In en, this message translates to:
  /// **'Chick'**
  String get q_kc_009_opt4;

  /// No description provided for @q_kc_010_text.
  ///
  /// In en, this message translates to:
  /// **'Which shape has three sides?'**
  String get q_kc_010_text;

  /// No description provided for @q_kc_010_opt1.
  ///
  /// In en, this message translates to:
  /// **'Triangle'**
  String get q_kc_010_opt1;

  /// No description provided for @q_kc_010_opt2.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get q_kc_010_opt2;

  /// No description provided for @q_kc_010_opt3.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get q_kc_010_opt3;

  /// No description provided for @q_kc_010_opt4.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get q_kc_010_opt4;

  /// No description provided for @q_kc_011_text.
  ///
  /// In en, this message translates to:
  /// **'What do plants need to make their food?'**
  String get q_kc_011_text;

  /// No description provided for @q_kc_011_opt1.
  ///
  /// In en, this message translates to:
  /// **'Sunlight'**
  String get q_kc_011_opt1;

  /// No description provided for @q_kc_011_opt2.
  ///
  /// In en, this message translates to:
  /// **'Moonlight'**
  String get q_kc_011_opt2;

  /// No description provided for @q_kc_011_opt3.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get q_kc_011_opt3;

  /// No description provided for @q_kc_011_opt4.
  ///
  /// In en, this message translates to:
  /// **'Snow'**
  String get q_kc_011_opt4;

  /// No description provided for @q_kc_012_text.
  ///
  /// In en, this message translates to:
  /// **'Which animal is known as the “King of the Jungle”?'**
  String get q_kc_012_text;

  /// No description provided for @q_kc_012_opt1.
  ///
  /// In en, this message translates to:
  /// **'Lion'**
  String get q_kc_012_opt1;

  /// No description provided for @q_kc_012_opt2.
  ///
  /// In en, this message translates to:
  /// **'Elephant'**
  String get q_kc_012_opt2;

  /// No description provided for @q_kc_012_opt3.
  ///
  /// In en, this message translates to:
  /// **'Tiger'**
  String get q_kc_012_opt3;

  /// No description provided for @q_kc_012_opt4.
  ///
  /// In en, this message translates to:
  /// **'Bear'**
  String get q_kc_012_opt4;

  /// No description provided for @q_kc_013_text.
  ///
  /// In en, this message translates to:
  /// **'What do you call the person who flies an airplane?'**
  String get q_kc_013_text;

  /// No description provided for @q_kc_013_opt1.
  ///
  /// In en, this message translates to:
  /// **'Pilot'**
  String get q_kc_013_opt1;

  /// No description provided for @q_kc_013_opt2.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get q_kc_013_opt2;

  /// No description provided for @q_kc_013_opt3.
  ///
  /// In en, this message translates to:
  /// **'Captain'**
  String get q_kc_013_opt3;

  /// No description provided for @q_kc_013_opt4.
  ///
  /// In en, this message translates to:
  /// **'Mechanic'**
  String get q_kc_013_opt4;

  /// No description provided for @q_kc_014_text.
  ///
  /// In en, this message translates to:
  /// **'How many days are there in a week?'**
  String get q_kc_014_text;

  /// No description provided for @q_kc_014_opt1.
  ///
  /// In en, this message translates to:
  /// **'7'**
  String get q_kc_014_opt1;

  /// No description provided for @q_kc_014_opt2.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get q_kc_014_opt2;

  /// No description provided for @q_kc_014_opt3.
  ///
  /// In en, this message translates to:
  /// **'10'**
  String get q_kc_014_opt3;

  /// No description provided for @q_kc_014_opt4.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get q_kc_014_opt4;

  /// No description provided for @q_kc_015_text.
  ///
  /// In en, this message translates to:
  /// **'Which animal can live both in water and on land?'**
  String get q_kc_015_text;

  /// No description provided for @q_kc_015_opt1.
  ///
  /// In en, this message translates to:
  /// **'Frog'**
  String get q_kc_015_opt1;

  /// No description provided for @q_kc_015_opt2.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get q_kc_015_opt2;

  /// No description provided for @q_kc_015_opt3.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get q_kc_015_opt3;

  /// No description provided for @q_kc_015_opt4.
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get q_kc_015_opt4;

  /// No description provided for @q_kc_016_text.
  ///
  /// In en, this message translates to:
  /// **'What do you use to brush your teeth?'**
  String get q_kc_016_text;

  /// No description provided for @q_kc_016_opt1.
  ///
  /// In en, this message translates to:
  /// **'Toothbrush'**
  String get q_kc_016_opt1;

  /// No description provided for @q_kc_016_opt2.
  ///
  /// In en, this message translates to:
  /// **'Spoon'**
  String get q_kc_016_opt2;

  /// No description provided for @q_kc_016_opt3.
  ///
  /// In en, this message translates to:
  /// **'Comb'**
  String get q_kc_016_opt3;

  /// No description provided for @q_kc_016_opt4.
  ///
  /// In en, this message translates to:
  /// **'Towel'**
  String get q_kc_016_opt4;

  /// No description provided for @q_kc_017_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf country has the Burj Khalifa?'**
  String get q_kc_017_text;

  /// No description provided for @q_kc_017_opt1.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get q_kc_017_opt1;

  /// No description provided for @q_kc_017_opt2.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get q_kc_017_opt2;

  /// No description provided for @q_kc_017_opt3.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get q_kc_017_opt3;

  /// No description provided for @q_kc_017_opt4.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get q_kc_017_opt4;

  /// No description provided for @q_kc_018_text.
  ///
  /// In en, this message translates to:
  /// **'What color do you get when you mix blue and yellow?'**
  String get q_kc_018_text;

  /// No description provided for @q_kc_018_opt1.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get q_kc_018_opt1;

  /// No description provided for @q_kc_018_opt2.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get q_kc_018_opt2;

  /// No description provided for @q_kc_018_opt3.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get q_kc_018_opt3;

  /// No description provided for @q_kc_018_opt4.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get q_kc_018_opt4;

  /// No description provided for @q_kc_019_text.
  ///
  /// In en, this message translates to:
  /// **'What is the opposite of “hot”?'**
  String get q_kc_019_text;

  /// No description provided for @q_kc_019_opt1.
  ///
  /// In en, this message translates to:
  /// **'Cold'**
  String get q_kc_019_opt1;

  /// No description provided for @q_kc_019_opt2.
  ///
  /// In en, this message translates to:
  /// **'Warm'**
  String get q_kc_019_opt2;

  /// No description provided for @q_kc_019_opt3.
  ///
  /// In en, this message translates to:
  /// **'Wet'**
  String get q_kc_019_opt3;

  /// No description provided for @q_kc_019_opt4.
  ///
  /// In en, this message translates to:
  /// **'Cool'**
  String get q_kc_019_opt4;

  /// No description provided for @q_kc_020_text.
  ///
  /// In en, this message translates to:
  /// **'Which season comes after spring?'**
  String get q_kc_020_text;

  /// No description provided for @q_kc_020_opt1.
  ///
  /// In en, this message translates to:
  /// **'Summer'**
  String get q_kc_020_opt1;

  /// No description provided for @q_kc_020_opt2.
  ///
  /// In en, this message translates to:
  /// **'Winter'**
  String get q_kc_020_opt2;

  /// No description provided for @q_kc_020_opt3.
  ///
  /// In en, this message translates to:
  /// **'Autumn'**
  String get q_kc_020_opt3;

  /// No description provided for @q_kc_020_opt4.
  ///
  /// In en, this message translates to:
  /// **'Rainy'**
  String get q_kc_020_opt4;

  /// No description provided for @q_kc_021_text.
  ///
  /// In en, this message translates to:
  /// **'What gas do humans breathe in to live?'**
  String get q_kc_021_text;

  /// No description provided for @q_kc_021_opt1.
  ///
  /// In en, this message translates to:
  /// **'Oxygen'**
  String get q_kc_021_opt1;

  /// No description provided for @q_kc_021_opt2.
  ///
  /// In en, this message translates to:
  /// **'Carbon Dioxide'**
  String get q_kc_021_opt2;

  /// No description provided for @q_kc_021_opt3.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen'**
  String get q_kc_021_opt3;

  /// No description provided for @q_kc_021_opt4.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen'**
  String get q_kc_021_opt4;

  /// No description provided for @q_kc_022_text.
  ///
  /// In en, this message translates to:
  /// **'Which planet is known as the Red Planet?'**
  String get q_kc_022_text;

  /// No description provided for @q_kc_022_opt1.
  ///
  /// In en, this message translates to:
  /// **'Mars'**
  String get q_kc_022_opt1;

  /// No description provided for @q_kc_022_opt2.
  ///
  /// In en, this message translates to:
  /// **'Venus'**
  String get q_kc_022_opt2;

  /// No description provided for @q_kc_022_opt3.
  ///
  /// In en, this message translates to:
  /// **'Mercury'**
  String get q_kc_022_opt3;

  /// No description provided for @q_kc_022_opt4.
  ///
  /// In en, this message translates to:
  /// **'Jupiter'**
  String get q_kc_022_opt4;

  /// No description provided for @q_kc_023_text.
  ///
  /// In en, this message translates to:
  /// **'What do you call a baby cow?'**
  String get q_kc_023_text;

  /// No description provided for @q_kc_023_opt1.
  ///
  /// In en, this message translates to:
  /// **'Calf'**
  String get q_kc_023_opt1;

  /// No description provided for @q_kc_023_opt2.
  ///
  /// In en, this message translates to:
  /// **'Foal'**
  String get q_kc_023_opt2;

  /// No description provided for @q_kc_023_opt3.
  ///
  /// In en, this message translates to:
  /// **'Cub'**
  String get q_kc_023_opt3;

  /// No description provided for @q_kc_023_opt4.
  ///
  /// In en, this message translates to:
  /// **'Pup'**
  String get q_kc_023_opt4;

  /// No description provided for @q_kc_024_text.
  ///
  /// In en, this message translates to:
  /// **'What is the largest mammal in the world?'**
  String get q_kc_024_text;

  /// No description provided for @q_kc_024_opt1.
  ///
  /// In en, this message translates to:
  /// **'Blue Whale'**
  String get q_kc_024_opt1;

  /// No description provided for @q_kc_024_opt2.
  ///
  /// In en, this message translates to:
  /// **'Elephant'**
  String get q_kc_024_opt2;

  /// No description provided for @q_kc_024_opt3.
  ///
  /// In en, this message translates to:
  /// **'Shark'**
  String get q_kc_024_opt3;

  /// No description provided for @q_kc_024_opt4.
  ///
  /// In en, this message translates to:
  /// **'Giraffe'**
  String get q_kc_024_opt4;

  /// No description provided for @q_kc_025_text.
  ///
  /// In en, this message translates to:
  /// **'Which country is famous for making pizza?'**
  String get q_kc_025_text;

  /// No description provided for @q_kc_025_opt1.
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get q_kc_025_opt1;

  /// No description provided for @q_kc_025_opt2.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get q_kc_025_opt2;

  /// No description provided for @q_kc_025_opt3.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get q_kc_025_opt3;

  /// No description provided for @q_kc_025_opt4.
  ///
  /// In en, this message translates to:
  /// **'Greece'**
  String get q_kc_025_opt4;

  /// No description provided for @q_kc_026_text.
  ///
  /// In en, this message translates to:
  /// **'Which instrument has black and white keys?'**
  String get q_kc_026_text;

  /// No description provided for @q_kc_026_opt1.
  ///
  /// In en, this message translates to:
  /// **'Piano'**
  String get q_kc_026_opt1;

  /// No description provided for @q_kc_026_opt2.
  ///
  /// In en, this message translates to:
  /// **'Drum'**
  String get q_kc_026_opt2;

  /// No description provided for @q_kc_026_opt3.
  ///
  /// In en, this message translates to:
  /// **'Guitar'**
  String get q_kc_026_opt3;

  /// No description provided for @q_kc_026_opt4.
  ///
  /// In en, this message translates to:
  /// **'Violin'**
  String get q_kc_026_opt4;

  /// No description provided for @q_kc_027_text.
  ///
  /// In en, this message translates to:
  /// **'What is the process called when water turns into vapor?'**
  String get q_kc_027_text;

  /// No description provided for @q_kc_027_opt1.
  ///
  /// In en, this message translates to:
  /// **'Evaporation'**
  String get q_kc_027_opt1;

  /// No description provided for @q_kc_027_opt2.
  ///
  /// In en, this message translates to:
  /// **'Condensation'**
  String get q_kc_027_opt2;

  /// No description provided for @q_kc_027_opt3.
  ///
  /// In en, this message translates to:
  /// **'Freezing'**
  String get q_kc_027_opt3;

  /// No description provided for @q_kc_027_opt4.
  ///
  /// In en, this message translates to:
  /// **'Boiling'**
  String get q_kc_027_opt4;

  /// No description provided for @q_kc_028_text.
  ///
  /// In en, this message translates to:
  /// **'Which Gulf city is known for its man-made Palm Island?'**
  String get q_kc_028_text;

  /// No description provided for @q_kc_028_opt1.
  ///
  /// In en, this message translates to:
  /// **'Dubai'**
  String get q_kc_028_opt1;

  /// No description provided for @q_kc_028_opt2.
  ///
  /// In en, this message translates to:
  /// **'Doha'**
  String get q_kc_028_opt2;

  /// No description provided for @q_kc_028_opt3.
  ///
  /// In en, this message translates to:
  /// **'Muscat'**
  String get q_kc_028_opt3;

  /// No description provided for @q_kc_028_opt4.
  ///
  /// In en, this message translates to:
  /// **'Manama'**
  String get q_kc_028_opt4;

  /// No description provided for @q_kc_029_text.
  ///
  /// In en, this message translates to:
  /// **'What is the fastest land animal?'**
  String get q_kc_029_text;

  /// No description provided for @q_kc_029_opt1.
  ///
  /// In en, this message translates to:
  /// **'Cheetah'**
  String get q_kc_029_opt1;

  /// No description provided for @q_kc_029_opt2.
  ///
  /// In en, this message translates to:
  /// **'Lion'**
  String get q_kc_029_opt2;

  /// No description provided for @q_kc_029_opt3.
  ///
  /// In en, this message translates to:
  /// **'Horse'**
  String get q_kc_029_opt3;

  /// No description provided for @q_kc_029_opt4.
  ///
  /// In en, this message translates to:
  /// **'Gazelle'**
  String get q_kc_029_opt4;

  /// No description provided for @q_kc_030_text.
  ///
  /// In en, this message translates to:
  /// **'What do you call the small holes on your skin that sweat comes from?'**
  String get q_kc_030_text;

  /// No description provided for @q_kc_030_opt1.
  ///
  /// In en, this message translates to:
  /// **'Pores'**
  String get q_kc_030_opt1;

  /// No description provided for @q_kc_030_opt2.
  ///
  /// In en, this message translates to:
  /// **'Spots'**
  String get q_kc_030_opt2;

  /// No description provided for @q_kc_030_opt3.
  ///
  /// In en, this message translates to:
  /// **'Cells'**
  String get q_kc_030_opt3;

  /// No description provided for @q_kc_030_opt4.
  ///
  /// In en, this message translates to:
  /// **'Glands'**
  String get q_kc_030_opt4;

  /// No description provided for @q_qt_001_text.
  ///
  /// In en, this message translates to:
  /// **'Name a fruit that is yellow.'**
  String get q_qt_001_text;

  /// No description provided for @q_qt_001_opt1.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get q_qt_001_opt1;

  /// No description provided for @q_qt_001_opt2.
  ///
  /// In en, this message translates to:
  /// **'Lemon'**
  String get q_qt_001_opt2;

  /// No description provided for @q_qt_001_opt3.
  ///
  /// In en, this message translates to:
  /// **'Mango'**
  String get q_qt_001_opt3;

  /// No description provided for @q_qt_001_opt4.
  ///
  /// In en, this message translates to:
  /// **'Pineapple'**
  String get q_qt_001_opt4;

  /// No description provided for @q_qt_002_text.
  ///
  /// In en, this message translates to:
  /// **'What color do you get when you mix red and white?'**
  String get q_qt_002_text;

  /// No description provided for @q_qt_002_opt1.
  ///
  /// In en, this message translates to:
  /// **'Pink'**
  String get q_qt_002_opt1;

  /// No description provided for @q_qt_002_opt2.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get q_qt_002_opt2;

  /// No description provided for @q_qt_002_opt3.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get q_qt_002_opt3;

  /// No description provided for @q_qt_002_opt4.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get q_qt_002_opt4;

  /// No description provided for @q_qt_003_text.
  ///
  /// In en, this message translates to:
  /// **'Say the word “fast” five times without stopping!'**
  String get q_qt_003_text;

  /// No description provided for @q_qt_004_text.
  ///
  /// In en, this message translates to:
  /// **'Name something you can wear on your head.'**
  String get q_qt_004_text;

  /// No description provided for @q_qt_004_opt1.
  ///
  /// In en, this message translates to:
  /// **'Hat'**
  String get q_qt_004_opt1;

  /// No description provided for @q_qt_004_opt2.
  ///
  /// In en, this message translates to:
  /// **'Cap'**
  String get q_qt_004_opt2;

  /// No description provided for @q_qt_004_opt3.
  ///
  /// In en, this message translates to:
  /// **'Scarf'**
  String get q_qt_004_opt3;

  /// No description provided for @q_qt_004_opt4.
  ///
  /// In en, this message translates to:
  /// **'Helmet'**
  String get q_qt_004_opt4;

  /// No description provided for @q_qt_005_text.
  ///
  /// In en, this message translates to:
  /// **'Clap your hands 10 times as fast as you can!'**
  String get q_qt_005_text;

  /// No description provided for @q_qt_006_text.
  ///
  /// In en, this message translates to:
  /// **'What is 10 - 3?'**
  String get q_qt_006_text;

  /// No description provided for @q_qt_006_opt1.
  ///
  /// In en, this message translates to:
  /// **'7'**
  String get q_qt_006_opt1;

  /// No description provided for @q_qt_006_opt2.
  ///
  /// In en, this message translates to:
  /// **'6'**
  String get q_qt_006_opt2;

  /// No description provided for @q_qt_006_opt3.
  ///
  /// In en, this message translates to:
  /// **'8'**
  String get q_qt_006_opt3;

  /// No description provided for @q_qt_006_opt4.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get q_qt_006_opt4;

  /// No description provided for @q_qt_007_text.
  ///
  /// In en, this message translates to:
  /// **'Spell the word “GAME” backward.'**
  String get q_qt_007_text;

  /// No description provided for @q_qt_008_text.
  ///
  /// In en, this message translates to:
  /// **'Name any animal that can fly.'**
  String get q_qt_008_text;

  /// No description provided for @q_qt_008_opt1.
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get q_qt_008_opt1;

  /// No description provided for @q_qt_008_opt2.
  ///
  /// In en, this message translates to:
  /// **'Bat'**
  String get q_qt_008_opt2;

  /// No description provided for @q_qt_008_opt3.
  ///
  /// In en, this message translates to:
  /// **'Eagle'**
  String get q_qt_008_opt3;

  /// No description provided for @q_qt_008_opt4.
  ///
  /// In en, this message translates to:
  /// **'Butterfly'**
  String get q_qt_008_opt4;

  /// No description provided for @q_qt_009_text.
  ///
  /// In en, this message translates to:
  /// **'Say the names of 3 Gulf countries in 10 seconds!'**
  String get q_qt_009_text;

  /// No description provided for @q_qt_010_text.
  ///
  /// In en, this message translates to:
  /// **'Name something you use every morning.'**
  String get q_qt_010_text;

  /// No description provided for @q_qt_010_opt1.
  ///
  /// In en, this message translates to:
  /// **'Toothbrush'**
  String get q_qt_010_opt1;

  /// No description provided for @q_qt_010_opt2.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get q_qt_010_opt2;

  /// No description provided for @q_qt_010_opt3.
  ///
  /// In en, this message translates to:
  /// **'Towel'**
  String get q_qt_010_opt3;

  /// No description provided for @q_qt_010_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_010_opt4;

  /// No description provided for @q_qt_011_text.
  ///
  /// In en, this message translates to:
  /// **'List 3 animals that live in water.'**
  String get q_qt_011_text;

  /// No description provided for @q_qt_012_text.
  ///
  /// In en, this message translates to:
  /// **'Name something round other than a ball.'**
  String get q_qt_012_text;

  /// No description provided for @q_qt_012_opt1.
  ///
  /// In en, this message translates to:
  /// **'Plate'**
  String get q_qt_012_opt1;

  /// No description provided for @q_qt_012_opt2.
  ///
  /// In en, this message translates to:
  /// **'Coin'**
  String get q_qt_012_opt2;

  /// No description provided for @q_qt_012_opt3.
  ///
  /// In en, this message translates to:
  /// **'Clock'**
  String get q_qt_012_opt3;

  /// No description provided for @q_qt_012_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_012_opt4;

  /// No description provided for @q_qt_013_text.
  ///
  /// In en, this message translates to:
  /// **'Say 5 words that start with the letter “S.”'**
  String get q_qt_013_text;

  /// No description provided for @q_qt_014_text.
  ///
  /// In en, this message translates to:
  /// **'Name 3 Gulf countries that start with a vowel.'**
  String get q_qt_014_text;

  /// No description provided for @q_qt_015_text.
  ///
  /// In en, this message translates to:
  /// **'Count from 1 to 10 in under 3 seconds!'**
  String get q_qt_015_text;

  /// No description provided for @q_qt_016_text.
  ///
  /// In en, this message translates to:
  /// **'If you have 5 apples and give 2 away, how many are left?'**
  String get q_qt_016_text;

  /// No description provided for @q_qt_016_opt1.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get q_qt_016_opt1;

  /// No description provided for @q_qt_016_opt2.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get q_qt_016_opt2;

  /// No description provided for @q_qt_016_opt3.
  ///
  /// In en, this message translates to:
  /// **'5'**
  String get q_qt_016_opt3;

  /// No description provided for @q_qt_016_opt4.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get q_qt_016_opt4;

  /// No description provided for @q_qt_017_text.
  ///
  /// In en, this message translates to:
  /// **'Name 3 things that use electricity.'**
  String get q_qt_017_text;

  /// No description provided for @q_qt_017_opt1.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get q_qt_017_opt1;

  /// No description provided for @q_qt_017_opt2.
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get q_qt_017_opt2;

  /// No description provided for @q_qt_017_opt3.
  ///
  /// In en, this message translates to:
  /// **'Fan'**
  String get q_qt_017_opt3;

  /// No description provided for @q_qt_017_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_017_opt4;

  /// No description provided for @q_qt_018_text.
  ///
  /// In en, this message translates to:
  /// **'Say the alphabet without the letter “A.”'**
  String get q_qt_018_text;

  /// No description provided for @q_qt_019_text.
  ///
  /// In en, this message translates to:
  /// **'Name one Gulf country and its capital.'**
  String get q_qt_019_text;

  /// No description provided for @q_qt_019_opt1.
  ///
  /// In en, this message translates to:
  /// **'Kuwait – Kuwait City'**
  String get q_qt_019_opt1;

  /// No description provided for @q_qt_019_opt2.
  ///
  /// In en, this message translates to:
  /// **'UAE – Abu Dhabi'**
  String get q_qt_019_opt2;

  /// No description provided for @q_qt_019_opt3.
  ///
  /// In en, this message translates to:
  /// **'Qatar – Doha'**
  String get q_qt_019_opt3;

  /// No description provided for @q_qt_019_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_019_opt4;

  /// No description provided for @q_qt_020_text.
  ///
  /// In en, this message translates to:
  /// **'Name 3 things that are cold.'**
  String get q_qt_020_text;

  /// No description provided for @q_qt_020_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ice'**
  String get q_qt_020_opt1;

  /// No description provided for @q_qt_020_opt2.
  ///
  /// In en, this message translates to:
  /// **'Snow'**
  String get q_qt_020_opt2;

  /// No description provided for @q_qt_020_opt3.
  ///
  /// In en, this message translates to:
  /// **'Juice'**
  String get q_qt_020_opt3;

  /// No description provided for @q_qt_020_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_020_opt4;

  /// No description provided for @q_qt_021_text.
  ///
  /// In en, this message translates to:
  /// **'Name 5 fruits in 10 seconds!'**
  String get q_qt_021_text;

  /// No description provided for @q_qt_022_text.
  ///
  /// In en, this message translates to:
  /// **'Say the word “banana” backward without pausing.'**
  String get q_qt_022_text;

  /// No description provided for @q_qt_023_text.
  ///
  /// In en, this message translates to:
  /// **'Name something that is both a food and a color.'**
  String get q_qt_023_text;

  /// No description provided for @q_qt_023_opt1.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get q_qt_023_opt1;

  /// No description provided for @q_qt_023_opt2.
  ///
  /// In en, this message translates to:
  /// **'Peach'**
  String get q_qt_023_opt2;

  /// No description provided for @q_qt_023_opt3.
  ///
  /// In en, this message translates to:
  /// **'Lemon'**
  String get q_qt_023_opt3;

  /// No description provided for @q_qt_023_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_023_opt4;

  /// No description provided for @q_qt_024_text.
  ///
  /// In en, this message translates to:
  /// **'Say 5 Gulf cities as fast as you can.'**
  String get q_qt_024_text;

  /// No description provided for @q_qt_025_text.
  ///
  /// In en, this message translates to:
  /// **'List 3 things that can melt.'**
  String get q_qt_025_text;

  /// No description provided for @q_qt_025_opt1.
  ///
  /// In en, this message translates to:
  /// **'Ice'**
  String get q_qt_025_opt1;

  /// No description provided for @q_qt_025_opt2.
  ///
  /// In en, this message translates to:
  /// **'Chocolate'**
  String get q_qt_025_opt2;

  /// No description provided for @q_qt_025_opt3.
  ///
  /// In en, this message translates to:
  /// **'Butter'**
  String get q_qt_025_opt3;

  /// No description provided for @q_qt_025_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_025_opt4;

  /// No description provided for @q_qt_026_text.
  ///
  /// In en, this message translates to:
  /// **'If you rearrange the letters of “DORAK,” what new word can you make?'**
  String get q_qt_026_text;

  /// No description provided for @q_qt_026_opt1.
  ///
  /// In en, this message translates to:
  /// **'Road'**
  String get q_qt_026_opt1;

  /// No description provided for @q_qt_026_opt2.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get q_qt_026_opt2;

  /// No description provided for @q_qt_026_opt3.
  ///
  /// In en, this message translates to:
  /// **'Radko'**
  String get q_qt_026_opt3;

  /// No description provided for @q_qt_026_opt4.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get q_qt_026_opt4;

  /// No description provided for @q_qt_027_text.
  ///
  /// In en, this message translates to:
  /// **'Say a word that rhymes with “Game.”'**
  String get q_qt_027_text;

  /// No description provided for @q_qt_027_opt1.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get q_qt_027_opt1;

  /// No description provided for @q_qt_027_opt2.
  ///
  /// In en, this message translates to:
  /// **'Same'**
  String get q_qt_027_opt2;

  /// No description provided for @q_qt_027_opt3.
  ///
  /// In en, this message translates to:
  /// **'Flame'**
  String get q_qt_027_opt3;

  /// No description provided for @q_qt_027_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_027_opt4;

  /// No description provided for @q_qt_028_text.
  ///
  /// In en, this message translates to:
  /// **'Name 3 things you’d take to the beach.'**
  String get q_qt_028_text;

  /// No description provided for @q_qt_028_opt1.
  ///
  /// In en, this message translates to:
  /// **'Towel'**
  String get q_qt_028_opt1;

  /// No description provided for @q_qt_028_opt2.
  ///
  /// In en, this message translates to:
  /// **'Sunscreen'**
  String get q_qt_028_opt2;

  /// No description provided for @q_qt_028_opt3.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get q_qt_028_opt3;

  /// No description provided for @q_qt_028_opt4.
  ///
  /// In en, this message translates to:
  /// **'All of the above'**
  String get q_qt_028_opt4;

  /// No description provided for @q_qt_029_text.
  ///
  /// In en, this message translates to:
  /// **'Say your birth month and the name of an animal that starts with the same letter.'**
  String get q_qt_029_text;

  /// No description provided for @q_qt_030_text.
  ///
  /// In en, this message translates to:
  /// **'Spell the word “challenge” correctly — but fast!'**
  String get q_qt_030_text;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
