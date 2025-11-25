// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get nicknameLabel => 'Nickname';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get createNewRoom => 'Create New Room';

  @override
  String get continueGuest => 'Play as Guest';

  @override
  String get createAccount => 'Create Account';

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
  String startGame(Object count) {
    return 'Start Game ($count/5)';
  }

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

  @override
  String get gameLobbyTitle => 'Game Lobby';

  @override
  String get connectingRoom => 'Connecting to room...';

  @override
  String get enterNickname => 'Enter Your Nickname';

  @override
  String get createRoom => 'Create Room';

  @override
  String get joinExistingRoom => 'Join Existing Room';

  @override
  String get roomCodeLabel => 'Room Code';

  @override
  String get roomCodeHint => 'Enter 6-digit code';

  @override
  String get teamA => 'Team A';

  @override
  String get teamB => 'Team B';

  @override
  String get joinRoom => 'Join Room';

  @override
  String get roomCreated => 'Room Created!';

  @override
  String code(Object roomCode) {
    return 'Code: $roomCode';
  }

  @override
  String get shareRoomCode => 'Share Room Code';

  @override
  String liveStatus(Object playerCount) {
    return 'Live - $playerCount players connected';
  }

  @override
  String get noPlayersYet => 'No players yet';

  @override
  String get guestLabel => 'Guest';

  @override
  String get memberLabel => 'Member';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get noMessagesYet => 'No messages yet\nStart chatting!';

  @override
  String get typeMessageHint => 'Type a message...';

  @override
  String get chatOn => 'ON';

  @override
  String get chatOff => 'OFF';

  @override
  String get startGameDialogTitle => 'Start Game?';

  @override
  String startGameDialogContent(Object playerCount) {
    return 'Are you ready to begin the game with $playerCount players?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get startGameNow => 'Start Game!';

  @override
  String copyCodeSuccess(Object roomCode) {
    return 'Room code $roomCode copied to clipboard! Share it with your friends.';
  }

  @override
  String get copyCodeFailed => 'Failed to share room code. Please try again.';

  @override
  String errorConnectingRoom(Object error) {
    return 'Error connecting to room: $error';
  }

  @override
  String get roomJoinFailed => 'Room not found or join failed.';

  @override
  String createRoomFailed(Object error) {
    return 'Failed to create room: $error';
  }

  @override
  String get needMorePlayers => 'Need at least 2 players to start the game!';

  @override
  String get onlyHostCanStart => 'Only the host can start the game.';

  @override
  String get invalidRoomCode => 'Please enter a valid 6-character room code.';

  @override
  String errorJoiningRoom(Object error) {
    return 'Error joining room: $error';
  }

  @override
  String get or => 'OR';

  @override
  String chatError(Object error) {
    return 'Chat error: $error';
  }

  @override
  String get on => 'ON';

  @override
  String get off => 'OFF';

  @override
  String get chatControlsComingSoon => 'Chat controls coming soon!';

  @override
  String get unknownUser => 'Unknown';

  @override
  String get you => 'You';

  @override
  String get selectRange => 'Select 5-8 Categories';

  @override
  String selectedCount(Object count) {
    return '$count selected (Min: 5, Max: 8)';
  }

  @override
  String get maximumCategories => 'Maximum 8 categories allowed';

  @override
  String get minimumCategories => 'Please select at least 1 category';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryEasy => 'Easy';

  @override
  String get categoryMedium => 'Medium';

  @override
  String get categoryHard => 'Hard';

  @override
  String get maxEightCategories => 'Maximum 8 categories allowed';

  @override
  String get pleaseSelectAtLeastOneCategory => 'Please select at least 1 category';

  @override
  String get selectCategoriesTitle => 'Select Categories';

  @override
  String get select58Categories => 'Select 5-8 Categories';

  @override
  String selectedCategoriesCount(Object count) {
    return '$count selected (Min: 5, Max: 8)';
  }

  @override
  String get difficultyAll => 'All';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get difficultyLabel => 'Difficulty';

  @override
  String questionCount(Object count) {
    return '$count questions';
  }

  @override
  String get questionsLabel => 'Questions';

  @override
  String startGameButton(Object count) {
    return 'Start Game ($count/5)';
  }

  @override
  String get waitingForHostToSelectCategories => 'Waiting for host to select categories...';

  @override
  String get gameTitle => 'DORAK Game';

  @override
  String get time => 'TIME';

  @override
  String get seconds => 'seconds';

  @override
  String get players => 'Players';

  @override
  String get generalKnowledge => 'General Knowledge';

  @override
  String questionOfTotal(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String get selectAnswer => 'Select your answer:';

  @override
  String get submitVote => 'SUBMIT VOTE';

  @override
  String get teamVotes => 'Team Votes';

  @override
  String votesCount(Object count) {
    return '$count votes';
  }

  @override
  String get votingInProgress => 'Voting in progress...';

  @override
  String voteSubmitted(Object option) {
    return 'Vote submitted for option $option';
  }

  @override
  String get questionSkipped => 'Question skipped!';

  @override
  String get votingStarted => 'Voting started! Teams can now submit answers.';

  @override
  String answerRevealed(Object a, Object b) {
    return 'Answer revealed! Team A: +$a, Team B: +$b';
  }

  @override
  String powerCardActivated(Object card) {
    return '$card activated!';
  }

  @override
  String get hostControls => 'Host Controls';

  @override
  String get hostControlTooltip => 'Open host control panel';

  @override
  String get dorakGameTitle => 'DORAK Game';

  @override
  String get hostControlsTooltip => 'Host Controls';

  @override
  String get timeLabel => 'TIME';

  @override
  String get secondsLabel => 'seconds';

  @override
  String playersCount(Object count) {
    return '$count players';
  }

  @override
  String questionNumber(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String get selectYourAnswer => 'Select your answer:';

  @override
  String voteSubmittedOption(Object option) {
    return 'Vote submitted for option $option';
  }

  @override
  String get hostControlsTitle => 'Host Controls';

  @override
  String get gameStateLabel => 'Game State';

  @override
  String get timerControlLabel => 'Timer Control';

  @override
  String get pause => 'Pause';

  @override
  String get start => 'Start';

  @override
  String get reset => 'Reset';

  @override
  String get quickAdjust => 'Quick Adjust:';

  @override
  String get pointsControlLabel => 'Points Control';

  @override
  String teamLabel(Object team) {
    return 'Team $team';
  }

  @override
  String get awardPoints => 'Award Points:';

  @override
  String get votingStatusLabel => 'Voting Status';

  @override
  String get teamAVotesLabel => 'Team A Votes';

  @override
  String get teamBVotesLabel => 'Team B Votes';

  @override
  String get startVoting => 'Start Voting';

  @override
  String get revealAnswer => 'Reveal Answer';

  @override
  String get questionControls => 'Question Controls';

  @override
  String get nextQuestion => 'Next Question';

  @override
  String get skip => 'Skip';

  @override
  String get powerCards => 'Power Cards';

  @override
  String get doublePoints => 'Double Points';

  @override
  String get stealPoints => 'Steal Points';

  @override
  String get reverseTurn => 'Reverse Turn';

  @override
  String get skipRound => 'Skip Round';

  @override
  String get endGame => 'End Game';

  @override
  String get endGameDialogTitle => 'End Game?';

  @override
  String get endGameDialogContent => 'Are you sure you want to end the current game? This cannot be undone.';

  @override
  String get endGameConfirm => 'End Game';

  @override
  String get timesUp => 'Time\'s up!';

  @override
  String get doublePointsDesc => 'Next correct answer will be worth double points!';

  @override
  String get stealPointsDesc => 'Steal 2 points from the other team!';

  @override
  String get reverseTurnDesc => 'Question goes to the other team!';

  @override
  String get skipRoundDesc => 'Skipping to next question!';

  @override
  String activatedFallback(Object card) {
    return '$card activated!';
  }

  @override
  String get points => 'points';

  @override
  String get doublePointsEffect => 'Next correct answer will be worth double points!';

  @override
  String get stealPointsEffect => 'Steal 2 points from the other team!';

  @override
  String get reverseTurnEffect => 'Question goes to the other team!';

  @override
  String get skipRoundEffect => 'Skipping to next question!';

  @override
  String get activated => 'activated';

  @override
  String get roomCode => 'Room Code';

  @override
  String get gameState => 'Game State';

  @override
  String get waiting => 'Waiting';

  @override
  String get inGame => 'In Game';

  @override
  String get roundComplete => 'Round Complete';

  @override
  String get gameComplete => 'Game Complete';

  @override
  String get timerControl => 'Timer Control';

  @override
  String get minus10s => '-10s';

  @override
  String get minus5s => '-5s';

  @override
  String get plus5s => '+5s';

  @override
  String get plus10s => '+10s';

  @override
  String get pointsControl => 'Points Control';

  @override
  String get correct => 'Correct!';

  @override
  String get great => 'Great!';

  @override
  String get team => 'Team';

  @override
  String get votingStatus => 'Voting Status';

  @override
  String get votes => 'votes';

  @override
  String get doubleNextPoints => 'Double next points';

  @override
  String get steal2Points => 'Steal 2 points';

  @override
  String get reverseQuestion => 'Reverse question';

  @override
  String get skipQuestion => 'Skip question';

  @override
  String get endGameQ => 'End Game?';

  @override
  String get endGameWarning => 'Are you sure you want to end the current game? This cannot be undone.';

  @override
  String get gameResultsTitle => 'Game Results';

  @override
  String get itsATie => 'It\'s a Tie!';

  @override
  String get teamAWins => '🎉 Team A Wins!';

  @override
  String get teamBWins => '🎉 Team B Wins!';

  @override
  String get finalScores => 'Final Scores';

  @override
  String pointsAbbreviation(Object score) {
    return '$score pts';
  }

  @override
  String get backToHome => 'Back to Home';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get unknownPlayer => 'Unknown Player';

  @override
  String get winnerBannerPath => 'assets/images/winner.png';

  @override
  String get loserBannerPath => 'assets/images/loser.png';

  @override
  String get categoryGeneralKnowledge => 'General Knowledge';

  @override
  String get categoryGeneralKnowledgeDesc => 'Test your general knowledge';

  @override
  String get categoryFamilyLife => 'Family Life';

  @override
  String get categoryFamilyLifeDesc => 'Fun questions about family';

  @override
  String get categoryGulfCulture => 'Gulf Culture';

  @override
  String get categoryGulfCultureDesc => 'Questions about Gulf traditions';

  @override
  String get categoryMoviesTV => 'Movies & TV';

  @override
  String get categoryMoviesTVDesc => 'Guess movies and TV shows';

  @override
  String get categoryMusic => 'Music';

  @override
  String get categoryMusicDesc => 'Music trivia and karaoke';

  @override
  String get categoryFunnyChallenges => 'Funny Challenges';

  @override
  String get categoryFunnyChallengesDesc => 'Hilarious physical challenges';

  @override
  String get categoryKidsCorner => 'Kids Corner';

  @override
  String get categoryKidsCornerDesc => 'Fun for the little ones';

  @override
  String get categoryQuickThinking => 'Quick Thinking';

  @override
  String get categoryQuickThinkingDesc => 'Fast-paced brain teasers';

  @override
  String get selectCountLabel => 'Select 5-8 Categories';

  @override
  String selectedCountStatus(Object count) {
    return '$count selected (Min: 5, Max: 8)';
  }

  @override
  String get maxCategoriesWarning => 'Maximum 8 categories allowed';

  @override
  String get tieResult => 'It\'s a Tie!';

  @override
  String get gameResults => 'Game Results';

  @override
  String get cat_1Name => 'General Knowledge';

  @override
  String get cat_1Desc => 'Test your general knowledge';

  @override
  String get cat_2Name => 'Family Life';

  @override
  String get cat_2Desc => 'Fun questions about family';

  @override
  String get cat_3Name => 'Gulf Culture';

  @override
  String get cat_3Desc => 'Questions about Gulf traditions';

  @override
  String get cat_4Name => 'Movies & TV';

  @override
  String get cat_4Desc => 'Guess movies and TV shows';

  @override
  String get cat_5Name => 'Music';

  @override
  String get cat_5Desc => 'Music trivia and karaoke';

  @override
  String get cat_6Name => 'Funny Challenges';

  @override
  String get cat_6Desc => 'Hilarious physical challenges';

  @override
  String get cat_7Name => 'Kids Corner';

  @override
  String get cat_7Desc => 'Fun for the little ones';

  @override
  String get cat_8Name => 'Quick Thinking';

  @override
  String get cat_8Desc => 'Fast-paced brain teasers';

  @override
  String get q_gk_001_text => 'What is the capital of Saudi Arabia?';

  @override
  String get q_gk_001_opt1 => 'Riyadh';

  @override
  String get q_gk_001_opt2 => 'Jeddah';

  @override
  String get q_gk_001_opt3 => 'Doha';

  @override
  String get q_gk_001_opt4 => 'Dubai';

  @override
  String get q_gk_002_text => 'What color is a ripe banana?';

  @override
  String get q_gk_002_opt1 => 'Green';

  @override
  String get q_gk_002_opt2 => 'Yellow';

  @override
  String get q_gk_002_opt3 => 'Red';

  @override
  String get q_gk_002_opt4 => 'Blue';

  @override
  String get q_gk_003_text => 'How many days are there in one week?';

  @override
  String get q_gk_003_opt1 => '5';

  @override
  String get q_gk_003_opt2 => '6';

  @override
  String get q_gk_003_opt3 => '7';

  @override
  String get q_gk_003_opt4 => '8';

  @override
  String get q_gk_004_text => 'Which planet is known as the Red Planet?';

  @override
  String get q_gk_004_opt1 => 'Venus';

  @override
  String get q_gk_004_opt2 => 'Mars';

  @override
  String get q_gk_004_opt3 => 'Jupiter';

  @override
  String get q_gk_004_opt4 => 'Mercury';

  @override
  String get q_gk_005_text => 'How many letters are in the English alphabet?';

  @override
  String get q_gk_005_opt1 => '24';

  @override
  String get q_gk_005_opt2 => '25';

  @override
  String get q_gk_005_opt3 => '26';

  @override
  String get q_gk_005_opt4 => '27';

  @override
  String get q_gk_006_text => 'What do bees make?';

  @override
  String get q_gk_006_opt1 => 'Honey';

  @override
  String get q_gk_006_opt2 => 'Milk';

  @override
  String get q_gk_006_opt3 => 'Wax';

  @override
  String get q_gk_006_opt4 => 'Sugar';

  @override
  String get q_gk_007_text => 'Which ocean is the largest?';

  @override
  String get q_gk_007_opt1 => 'Atlantic';

  @override
  String get q_gk_007_opt2 => 'Indian';

  @override
  String get q_gk_007_opt3 => 'Pacific';

  @override
  String get q_gk_007_opt4 => 'Arctic';

  @override
  String get q_gk_008_text => 'How many sides does a triangle have?';

  @override
  String get q_gk_008_opt1 => '2';

  @override
  String get q_gk_008_opt2 => '3';

  @override
  String get q_gk_008_opt3 => '4';

  @override
  String get q_gk_008_opt4 => '5';

  @override
  String get q_gk_009_text => 'What is H₂O commonly known as?';

  @override
  String get q_gk_009_opt1 => 'Oxygen';

  @override
  String get q_gk_009_opt2 => 'Salt';

  @override
  String get q_gk_009_opt3 => 'Water';

  @override
  String get q_gk_009_opt4 => 'Hydrogen';

  @override
  String get q_gk_010_text => 'Which animal is known as the King of the Jungle?';

  @override
  String get q_gk_010_opt1 => 'Tiger';

  @override
  String get q_gk_010_opt2 => 'Lion';

  @override
  String get q_gk_010_opt3 => 'Elephant';

  @override
  String get q_gk_010_opt4 => 'Leopard';

  @override
  String get q_gk_011_text => 'Who wrote the famous play “Romeo and Juliet”?';

  @override
  String get q_gk_011_opt1 => 'Shakespeare';

  @override
  String get q_gk_011_opt2 => 'Homer';

  @override
  String get q_gk_011_opt3 => 'Tolstoy';

  @override
  String get q_gk_011_opt4 => 'Charles Dickens';

  @override
  String get q_gk_012_text => 'What gas do plants produce during photosynthesis?';

  @override
  String get q_gk_012_opt1 => 'Oxygen';

  @override
  String get q_gk_012_opt2 => 'Carbon dioxide';

  @override
  String get q_gk_012_opt3 => 'Nitrogen';

  @override
  String get q_gk_012_opt4 => 'Hydrogen';

  @override
  String get q_gk_013_text => 'What is the largest desert in the world?';

  @override
  String get q_gk_013_opt1 => 'Sahara';

  @override
  String get q_gk_013_opt2 => 'Arabian';

  @override
  String get q_gk_013_opt3 => 'Gobi';

  @override
  String get q_gk_013_opt4 => 'Antarctic';

  @override
  String get q_gk_014_text => 'Which metal is liquid at room temperature?';

  @override
  String get q_gk_014_opt1 => 'Mercury';

  @override
  String get q_gk_014_opt2 => 'Gold';

  @override
  String get q_gk_014_opt3 => 'Silver';

  @override
  String get q_gk_014_opt4 => 'Aluminum';

  @override
  String get q_gk_015_text => 'Who was the first person to walk on the Moon?';

  @override
  String get q_gk_015_opt1 => 'Neil Armstrong';

  @override
  String get q_gk_015_opt2 => 'Buzz Aldrin';

  @override
  String get q_gk_015_opt3 => 'Yuri Gagarin';

  @override
  String get q_gk_015_opt4 => 'Alan Shepard';

  @override
  String get q_gk_016_text => 'Which continent has the most countries?';

  @override
  String get q_gk_016_opt1 => 'Asia';

  @override
  String get q_gk_016_opt2 => 'Europe';

  @override
  String get q_gk_016_opt3 => 'Africa';

  @override
  String get q_gk_016_opt4 => 'South America';

  @override
  String get q_gk_017_text => 'What is the longest river in the world?';

  @override
  String get q_gk_017_opt1 => 'Nile';

  @override
  String get q_gk_017_opt2 => 'Amazon';

  @override
  String get q_gk_017_opt3 => 'Yangtze';

  @override
  String get q_gk_017_opt4 => 'Mississippi';

  @override
  String get q_gk_018_text => 'Which country invented paper?';

  @override
  String get q_gk_018_opt1 => 'China';

  @override
  String get q_gk_018_opt2 => 'Egypt';

  @override
  String get q_gk_018_opt3 => 'India';

  @override
  String get q_gk_018_opt4 => 'Greece';

  @override
  String get q_gk_019_text => 'In which year did World War II end?';

  @override
  String get q_gk_019_opt1 => '1942';

  @override
  String get q_gk_019_opt2 => '1943';

  @override
  String get q_gk_019_opt3 => '1945';

  @override
  String get q_gk_019_opt4 => '1948';

  @override
  String get q_gk_020_text => 'Which Gulf city is known as the “City of Gold”?';

  @override
  String get q_gk_020_opt1 => 'Dubai';

  @override
  String get q_gk_020_opt2 => 'Kuwait City';

  @override
  String get q_gk_020_opt3 => 'Riyadh';

  @override
  String get q_gk_020_opt4 => 'Doha';

  @override
  String get q_gk_021_text => 'What is the chemical symbol for gold?';

  @override
  String get q_gk_021_opt1 => 'Au';

  @override
  String get q_gk_021_opt2 => 'Ag';

  @override
  String get q_gk_021_opt3 => 'Gd';

  @override
  String get q_gk_021_opt4 => 'Pt';

  @override
  String get q_gk_022_text => 'Who discovered the law of gravity?';

  @override
  String get q_gk_022_opt1 => 'Isaac Newton';

  @override
  String get q_gk_022_opt2 => 'Albert Einstein';

  @override
  String get q_gk_022_opt3 => 'Galileo';

  @override
  String get q_gk_022_opt4 => 'Archimedes';

  @override
  String get q_gk_023_text => 'What is the smallest bone in the human body?';

  @override
  String get q_gk_023_opt1 => 'Stapes';

  @override
  String get q_gk_023_opt2 => 'Femur';

  @override
  String get q_gk_023_opt3 => 'Tibia';

  @override
  String get q_gk_023_opt4 => 'Ulna';

  @override
  String get q_gk_024_text => 'Which planet has the most moons?';

  @override
  String get q_gk_024_opt1 => 'Jupiter';

  @override
  String get q_gk_024_opt2 => 'Saturn';

  @override
  String get q_gk_024_opt3 => 'Neptune';

  @override
  String get q_gk_024_opt4 => 'Mars';

  @override
  String get q_gk_025_text => 'In which year was the United Nations founded?';

  @override
  String get q_gk_025_opt1 => '1940';

  @override
  String get q_gk_025_opt2 => '1945';

  @override
  String get q_gk_025_opt3 => '1950';

  @override
  String get q_gk_025_opt4 => '1955';

  @override
  String get q_gk_026_text => 'What is the hardest natural substance on Earth?';

  @override
  String get q_gk_026_opt1 => 'Gold';

  @override
  String get q_gk_026_opt2 => 'Iron';

  @override
  String get q_gk_026_opt3 => 'Diamond';

  @override
  String get q_gk_026_opt4 => 'Steel';

  @override
  String get q_gk_027_text => 'What is the currency of Japan?';

  @override
  String get q_gk_027_opt1 => 'Yuan';

  @override
  String get q_gk_027_opt2 => 'Yen';

  @override
  String get q_gk_027_opt3 => 'Won';

  @override
  String get q_gk_027_opt4 => 'Ringgit';

  @override
  String get q_gk_028_text => 'Which element has the chemical symbol “Na”?';

  @override
  String get q_gk_028_opt1 => 'Sodium';

  @override
  String get q_gk_028_opt2 => 'Nitrogen';

  @override
  String get q_gk_028_opt3 => 'Nickel';

  @override
  String get q_gk_028_opt4 => 'Neon';

  @override
  String get q_gk_029_text => 'What is the capital city of Canada?';

  @override
  String get q_gk_029_opt1 => 'Toronto';

  @override
  String get q_gk_029_opt2 => 'Vancouver';

  @override
  String get q_gk_029_opt3 => 'Ottawa';

  @override
  String get q_gk_029_opt4 => 'Montreal';

  @override
  String get q_gk_030_text => 'Who proposed the theory of relativity?';

  @override
  String get q_gk_030_opt1 => 'Einstein';

  @override
  String get q_gk_030_opt2 => 'Newton';

  @override
  String get q_gk_030_opt3 => 'Tesla';

  @override
  String get q_gk_030_opt4 => 'Curie';

  @override
  String get q_fl_001_text => 'What is something families often do together on weekends?';

  @override
  String get q_fl_001_opt1 => 'Watch movies';

  @override
  String get q_fl_001_opt2 => 'Go shopping';

  @override
  String get q_fl_001_opt3 => 'Stay silent';

  @override
  String get q_fl_001_opt4 => 'Work overtime';

  @override
  String get q_fl_002_text => 'Who is usually the oldest member in a family?';

  @override
  String get q_fl_002_opt1 => 'Father';

  @override
  String get q_fl_002_opt2 => 'Grandfather';

  @override
  String get q_fl_002_opt3 => 'Brother';

  @override
  String get q_fl_002_opt4 => 'Uncle';

  @override
  String get q_fl_003_text => 'What do most families eat together on Fridays in the Gulf?';

  @override
  String get q_fl_003_opt1 => 'Lunch';

  @override
  String get q_fl_003_opt2 => 'Breakfast';

  @override
  String get q_fl_003_opt3 => 'Dinner';

  @override
  String get q_fl_003_opt4 => 'Snacks';

  @override
  String get q_fl_004_text => 'What do parents always tell their kids to finish before playing?';

  @override
  String get q_fl_004_opt1 => 'Homework';

  @override
  String get q_fl_004_opt2 => 'TV shows';

  @override
  String get q_fl_004_opt3 => 'Games';

  @override
  String get q_fl_004_opt4 => 'Calls';

  @override
  String get q_fl_005_text => 'Who is usually in charge of cooking in most households?';

  @override
  String get q_fl_005_opt1 => 'Mother';

  @override
  String get q_fl_005_opt2 => 'Father';

  @override
  String get q_fl_005_opt3 => 'Children';

  @override
  String get q_fl_005_opt4 => 'Neighbor';

  @override
  String get q_fl_006_text => 'What’s something you say to your parents before leaving the house?';

  @override
  String get q_fl_006_opt1 => 'Goodbye';

  @override
  String get q_fl_006_opt2 => 'See you';

  @override
  String get q_fl_006_opt3 => 'I’m off';

  @override
  String get q_fl_006_opt4 => 'All of the above';

  @override
  String get q_fl_007_text => 'What’s the most common family pet?';

  @override
  String get q_fl_007_opt1 => 'Dog';

  @override
  String get q_fl_007_opt2 => 'Cat';

  @override
  String get q_fl_007_opt3 => 'Fish';

  @override
  String get q_fl_007_opt4 => 'Parrot';

  @override
  String get q_fl_008_text => 'Who teaches manners and respect at home?';

  @override
  String get q_fl_008_opt1 => 'Parents';

  @override
  String get q_fl_008_opt2 => 'Friends';

  @override
  String get q_fl_008_opt3 => 'Teachers';

  @override
  String get q_fl_008_opt4 => 'TV';

  @override
  String get q_fl_009_text => 'What do families usually celebrate together?';

  @override
  String get q_fl_009_opt1 => 'Eid';

  @override
  String get q_fl_009_opt2 => 'Birthdays';

  @override
  String get q_fl_009_opt3 => 'Graduations';

  @override
  String get q_fl_009_opt4 => 'All of the above';

  @override
  String get q_fl_010_text => 'Which room in the house brings the family together?';

  @override
  String get q_fl_010_opt1 => 'Living room';

  @override
  String get q_fl_010_opt2 => 'Kitchen';

  @override
  String get q_fl_010_opt3 => 'Garage';

  @override
  String get q_fl_010_opt4 => 'Bedroom';

  @override
  String get q_fl_011_text => 'What’s one good way to make your family members happy?';

  @override
  String get q_fl_011_opt1 => 'Help them';

  @override
  String get q_fl_011_opt2 => 'Complain';

  @override
  String get q_fl_011_opt3 => 'Ignore them';

  @override
  String get q_fl_011_opt4 => 'Blame them';

  @override
  String get q_fl_012_text => 'What is something families do during Ramadan evenings?';

  @override
  String get q_fl_012_opt1 => 'Eat together';

  @override
  String get q_fl_012_opt2 => 'Watch TV';

  @override
  String get q_fl_012_opt3 => 'Pray together';

  @override
  String get q_fl_012_opt4 => 'All of the above';

  @override
  String get q_fl_013_text => 'Who usually decides family vacation plans?';

  @override
  String get q_fl_013_opt1 => 'Parents';

  @override
  String get q_fl_013_opt2 => 'Children';

  @override
  String get q_fl_013_opt3 => 'Grandparents';

  @override
  String get q_fl_013_opt4 => 'Neighbors';

  @override
  String get q_fl_014_text => 'What does a good family always show to one another?';

  @override
  String get q_fl_014_opt1 => 'Respect';

  @override
  String get q_fl_014_opt2 => 'Anger';

  @override
  String get q_fl_014_opt3 => 'Jealousy';

  @override
  String get q_fl_014_opt4 => 'Competition';

  @override
  String get q_fl_015_text => 'What’s something families do together during Eid?';

  @override
  String get q_fl_015_opt1 => 'Visit relatives';

  @override
  String get q_fl_015_opt2 => 'Go to work';

  @override
  String get q_fl_015_opt3 => 'Sleep all day';

  @override
  String get q_fl_015_opt4 => 'Travel alone';

  @override
  String get q_fl_016_text => 'What should you say when a family member sneezes?';

  @override
  String get q_fl_016_opt1 => 'Bless you';

  @override
  String get q_fl_016_opt2 => 'Excuse me';

  @override
  String get q_fl_016_opt3 => 'Goodbye';

  @override
  String get q_fl_016_opt4 => 'Hello';

  @override
  String get q_fl_017_text => 'What helps families stay connected when living far apart?';

  @override
  String get q_fl_017_opt1 => 'Phone calls';

  @override
  String get q_fl_017_opt2 => 'Ignoring each other';

  @override
  String get q_fl_017_opt3 => 'No contact';

  @override
  String get q_fl_017_opt4 => 'Letters only';

  @override
  String get q_fl_018_text => 'Which activity can strengthen family bonds?';

  @override
  String get q_fl_018_opt1 => 'Cooking together';

  @override
  String get q_fl_018_opt2 => 'Arguing';

  @override
  String get q_fl_018_opt3 => 'Playing separately';

  @override
  String get q_fl_018_opt4 => 'Silent meals';

  @override
  String get q_fl_019_text => 'What do families in the Gulf enjoy doing at the beach?';

  @override
  String get q_fl_019_opt1 => 'Picnics';

  @override
  String get q_fl_019_opt2 => 'Volleyball';

  @override
  String get q_fl_019_opt3 => 'Swimming';

  @override
  String get q_fl_019_opt4 => 'All of the above';

  @override
  String get q_fl_020_text => 'What’s a family value that is highly respected in Gulf culture?';

  @override
  String get q_fl_020_opt1 => 'Obedience to parents';

  @override
  String get q_fl_020_opt2 => 'Competition';

  @override
  String get q_fl_020_opt3 => 'Silence';

  @override
  String get q_fl_020_opt4 => 'Independence';

  @override
  String get q_fl_021_text => 'What’s one major benefit of eating together as a family?';

  @override
  String get q_fl_021_opt1 => 'Better communication';

  @override
  String get q_fl_021_opt2 => 'Faster eating';

  @override
  String get q_fl_021_opt3 => 'Less cleanup';

  @override
  String get q_fl_021_opt4 => 'More screen time';

  @override
  String get q_fl_022_text => 'Which family tradition helps pass down values between generations?';

  @override
  String get q_fl_022_opt1 => 'Storytelling';

  @override
  String get q_fl_022_opt2 => 'Shopping';

  @override
  String get q_fl_022_opt3 => 'Online gaming';

  @override
  String get q_fl_022_opt4 => 'Watching TV alone';

  @override
  String get q_fl_023_text => 'What can cause distance between family members?';

  @override
  String get q_fl_023_opt1 => 'Lack of communication';

  @override
  String get q_fl_023_opt2 => 'Respect';

  @override
  String get q_fl_023_opt3 => 'Love';

  @override
  String get q_fl_023_opt4 => 'Laughter';

  @override
  String get q_fl_024_text => 'Why is honesty important in a family?';

  @override
  String get q_fl_024_opt1 => 'It builds trust';

  @override
  String get q_fl_024_opt2 => 'It causes fights';

  @override
  String get q_fl_024_opt3 => 'It wastes time';

  @override
  String get q_fl_024_opt4 => 'It makes things boring';

  @override
  String get q_fl_025_text => 'What’s one way parents can teach responsibility to kids?';

  @override
  String get q_fl_025_opt1 => 'Assign chores';

  @override
  String get q_fl_025_opt2 => 'Ignore mistakes';

  @override
  String get q_fl_025_opt3 => 'Do everything for them';

  @override
  String get q_fl_025_opt4 => 'Reward laziness';

  @override
  String get q_fl_026_text => 'Why is patience important in family life?';

  @override
  String get q_fl_026_opt1 => 'To handle differences calmly';

  @override
  String get q_fl_026_opt2 => 'To argue better';

  @override
  String get q_fl_026_opt3 => 'To win';

  @override
  String get q_fl_026_opt4 => 'To avoid help';

  @override
  String get q_fl_027_text => 'Which Gulf family event brings everyone together each year?';

  @override
  String get q_fl_027_opt1 => 'Eid gathering';

  @override
  String get q_fl_027_opt2 => 'National Day parade';

  @override
  String get q_fl_027_opt3 => 'Solo trip';

  @override
  String get q_fl_027_opt4 => 'TV marathon';

  @override
  String get q_fl_028_text => 'What’s an example of family teamwork?';

  @override
  String get q_fl_028_opt1 => 'Cleaning the house together';

  @override
  String get q_fl_028_opt2 => 'Arguing';

  @override
  String get q_fl_028_opt3 => 'Staying quiet';

  @override
  String get q_fl_028_opt4 => 'Ignoring chores';

  @override
  String get q_fl_029_text => 'Why should families practice gratitude?';

  @override
  String get q_fl_029_opt1 => 'It improves happiness';

  @override
  String get q_fl_029_opt2 => 'It wastes time';

  @override
  String get q_fl_029_opt3 => 'It causes problems';

  @override
  String get q_fl_029_opt4 => 'It creates envy';

  @override
  String get q_fl_030_text => 'What can children teach parents in modern families?';

  @override
  String get q_fl_030_opt1 => 'New technology';

  @override
  String get q_fl_030_opt2 => 'Old traditions';

  @override
  String get q_fl_030_opt3 => 'More rules';

  @override
  String get q_fl_030_opt4 => 'Less respect';

  @override
  String get q_gc_001_text => 'Which drink is traditionally served first to guests in the Gulf?';

  @override
  String get q_gc_001_opt1 => 'Arabic coffee (Gahwa)';

  @override
  String get q_gc_001_opt2 => 'Tea';

  @override
  String get q_gc_001_opt3 => 'Juice';

  @override
  String get q_gc_001_opt4 => 'Water';

  @override
  String get q_gc_002_text => 'What is the traditional Gulf bread called?';

  @override
  String get q_gc_002_opt1 => 'Regag';

  @override
  String get q_gc_002_opt2 => 'Tortilla';

  @override
  String get q_gc_002_opt3 => 'Chapati';

  @override
  String get q_gc_002_opt4 => 'Pita';

  @override
  String get q_gc_003_text => 'What is the traditional clothing worn by Gulf men?';

  @override
  String get q_gc_003_opt1 => 'Kandura/Thobe';

  @override
  String get q_gc_003_opt2 => 'Kimono';

  @override
  String get q_gc_003_opt3 => 'Kurta';

  @override
  String get q_gc_003_opt4 => 'Suit';

  @override
  String get q_gc_004_text => 'Which Gulf country is famous for pearl diving?';

  @override
  String get q_gc_004_opt1 => 'Bahrain';

  @override
  String get q_gc_004_opt2 => 'Kuwait';

  @override
  String get q_gc_004_opt3 => 'Oman';

  @override
  String get q_gc_004_opt4 => 'Qatar';

  @override
  String get q_gc_005_text => 'What do Gulf people usually eat to break their fast during Ramadan?';

  @override
  String get q_gc_005_opt1 => 'Dates';

  @override
  String get q_gc_005_opt2 => 'Rice';

  @override
  String get q_gc_005_opt3 => 'Soup';

  @override
  String get q_gc_005_opt4 => 'Salad';

  @override
  String get q_gc_006_text => 'Which Gulf country has the tallest building in the world?';

  @override
  String get q_gc_006_opt1 => 'UAE';

  @override
  String get q_gc_006_opt2 => 'Kuwait';

  @override
  String get q_gc_006_opt3 => 'Qatar';

  @override
  String get q_gc_006_opt4 => 'Oman';

  @override
  String get q_gc_007_text => 'What is a traditional Gulf dance called?';

  @override
  String get q_gc_007_opt1 => 'Ardah';

  @override
  String get q_gc_007_opt2 => 'Salsa';

  @override
  String get q_gc_007_opt3 => 'Ballet';

  @override
  String get q_gc_007_opt4 => 'Tango';

  @override
  String get q_gc_008_text => 'Which Gulf country’s capital city is Doha?';

  @override
  String get q_gc_008_opt1 => 'Qatar';

  @override
  String get q_gc_008_opt2 => 'Oman';

  @override
  String get q_gc_008_opt3 => 'Kuwait';

  @override
  String get q_gc_008_opt4 => 'Bahrain';

  @override
  String get q_gc_009_text => 'What is a traditional Gulf boat called?';

  @override
  String get q_gc_009_opt1 => 'Dhow';

  @override
  String get q_gc_009_opt2 => 'Canoe';

  @override
  String get q_gc_009_opt3 => 'Yacht';

  @override
  String get q_gc_009_opt4 => 'Submarine';

  @override
  String get q_gc_010_text => 'What does the Arabic word “Yalla” mean?';

  @override
  String get q_gc_010_opt1 => 'Let’s go';

  @override
  String get q_gc_010_opt2 => 'Stop';

  @override
  String get q_gc_010_opt3 => 'Goodbye';

  @override
  String get q_gc_010_opt4 => 'Wait';

  @override
  String get q_gc_011_text => 'What is the Gulf traditional dish made of rice, meat, and spices?';

  @override
  String get q_gc_011_opt1 => 'Machboos';

  @override
  String get q_gc_011_opt2 => 'Pizza';

  @override
  String get q_gc_011_opt3 => 'Burger';

  @override
  String get q_gc_011_opt4 => 'Biryani';

  @override
  String get q_gc_012_text => 'Which Gulf city is home to the famous Souq Waqif?';

  @override
  String get q_gc_012_opt1 => 'Doha';

  @override
  String get q_gc_012_opt2 => 'Dubai';

  @override
  String get q_gc_012_opt3 => 'Muscat';

  @override
  String get q_gc_012_opt4 => 'Manama';

  @override
  String get q_gc_013_text => 'What is the Gulf traditional fragrance made from wood?';

  @override
  String get q_gc_013_opt1 => 'Oud';

  @override
  String get q_gc_013_opt2 => 'Rose oil';

  @override
  String get q_gc_013_opt3 => 'Lavender';

  @override
  String get q_gc_013_opt4 => 'Musk';

  @override
  String get q_gc_014_text => 'Which Gulf country celebrates National Day on December 2?';

  @override
  String get q_gc_014_opt1 => 'UAE';

  @override
  String get q_gc_014_opt2 => 'Kuwait';

  @override
  String get q_gc_014_opt3 => 'Bahrain';

  @override
  String get q_gc_014_opt4 => 'Oman';

  @override
  String get q_gc_015_text => 'What type of headwear is traditionally worn by Gulf men?';

  @override
  String get q_gc_015_opt1 => 'Ghutra';

  @override
  String get q_gc_015_opt2 => 'Cap';

  @override
  String get q_gc_015_opt3 => 'Hat';

  @override
  String get q_gc_015_opt4 => 'Turban';

  @override
  String get q_gc_016_text => 'What are traditional Gulf women’s dresses often decorated with?';

  @override
  String get q_gc_016_opt1 => 'Gold thread embroidery';

  @override
  String get q_gc_016_opt2 => 'Beads';

  @override
  String get q_gc_016_opt3 => 'Paint';

  @override
  String get q_gc_016_opt4 => 'Buttons';

  @override
  String get q_gc_017_text => 'Which Gulf country is known as the “Land of Frankincense”?';

  @override
  String get q_gc_017_opt1 => 'Oman';

  @override
  String get q_gc_017_opt2 => 'Qatar';

  @override
  String get q_gc_017_opt3 => 'Kuwait';

  @override
  String get q_gc_017_opt4 => 'UAE';

  @override
  String get q_gc_018_text => 'What is the Gulf term for a close family gathering or evening meeting?';

  @override
  String get q_gc_018_opt1 => 'Diwaniya/Majlis';

  @override
  String get q_gc_018_opt2 => 'Bazaar';

  @override
  String get q_gc_018_opt3 => 'Cafe';

  @override
  String get q_gc_018_opt4 => 'Market';

  @override
  String get q_gc_019_text => 'Which Gulf country has the island city of Muharraq?';

  @override
  String get q_gc_019_opt1 => 'Bahrain';

  @override
  String get q_gc_019_opt2 => 'Qatar';

  @override
  String get q_gc_019_opt3 => 'UAE';

  @override
  String get q_gc_019_opt4 => 'Saudi Arabia';

  @override
  String get q_gc_020_text => 'What is the Gulf traditional hospitality gesture when guests arrive?';

  @override
  String get q_gc_020_opt1 => 'Serve coffee and dates';

  @override
  String get q_gc_020_opt2 => 'Turn on music';

  @override
  String get q_gc_020_opt3 => 'Offer gifts';

  @override
  String get q_gc_020_opt4 => 'Cook a feast immediately';

  @override
  String get q_gc_021_text => 'Which Gulf country’s flag has a serrated white edge with nine points?';

  @override
  String get q_gc_021_opt1 => 'Qatar';

  @override
  String get q_gc_021_opt2 => 'Bahrain';

  @override
  String get q_gc_021_opt3 => 'Oman';

  @override
  String get q_gc_021_opt4 => 'Kuwait';

  @override
  String get q_gc_022_text => 'In which Gulf country is the Wahiba Sands desert located?';

  @override
  String get q_gc_022_opt1 => 'Oman';

  @override
  String get q_gc_022_opt2 => 'Saudi Arabia';

  @override
  String get q_gc_022_opt3 => 'Kuwait';

  @override
  String get q_gc_022_opt4 => 'Qatar';

  @override
  String get q_gc_023_text => 'What was the main economic activity in the Gulf before oil discovery?';

  @override
  String get q_gc_023_opt1 => 'Pearl diving and trading';

  @override
  String get q_gc_023_opt2 => 'Fishing only';

  @override
  String get q_gc_023_opt3 => 'Farming';

  @override
  String get q_gc_023_opt4 => 'Gold mining';

  @override
  String get q_gc_024_text => 'What does the word “Habibi” mean in Arabic?';

  @override
  String get q_gc_024_opt1 => 'My dear';

  @override
  String get q_gc_024_opt2 => 'My friend';

  @override
  String get q_gc_024_opt3 => 'My teacher';

  @override
  String get q_gc_024_opt4 => 'My child';

  @override
  String get q_gc_025_text => 'Which Gulf festival celebrates heritage and traditional sports like camel racing?';

  @override
  String get q_gc_025_opt1 => 'Janadriyah Festival';

  @override
  String get q_gc_025_opt2 => 'Eid Al-Fitr';

  @override
  String get q_gc_025_opt3 => 'Hala February';

  @override
  String get q_gc_025_opt4 => 'Ramadan Market';

  @override
  String get q_gc_026_text => 'Which Gulf port city was historically called “the Venice of the Gulf”?';

  @override
  String get q_gc_026_opt1 => 'Kuwait City';

  @override
  String get q_gc_026_opt2 => 'Manama';

  @override
  String get q_gc_026_opt3 => 'Dubai';

  @override
  String get q_gc_026_opt4 => 'Muscat';

  @override
  String get q_gc_027_text => 'Which traditional Gulf game is played with small seashells or stones?';

  @override
  String get q_gc_027_opt1 => 'Al-karam';

  @override
  String get q_gc_027_opt2 => 'Al-siniyah';

  @override
  String get q_gc_027_opt3 => 'Al-karamoh';

  @override
  String get q_gc_027_opt4 => 'Hawaleen';

  @override
  String get q_gc_028_text => 'Which Gulf poet is known as the “Poet of a Million”?';

  @override
  String get q_gc_028_opt1 => 'Mohammed bin Rashid Al Maktoum';

  @override
  String get q_gc_028_opt2 => 'Nizar Qabbani';

  @override
  String get q_gc_028_opt3 => 'Prince Khalid Al-Faisal';

  @override
  String get q_gc_028_opt4 => 'Abdulaziz Al-Qasimi';

  @override
  String get q_gc_029_text => 'What traditional Gulf jewelry piece is worn around the head or forehead by women?';

  @override
  String get q_gc_029_opt1 => 'Tikka';

  @override
  String get q_gc_029_opt2 => 'Burqa';

  @override
  String get q_gc_029_opt3 => 'Matha Patti';

  @override
  String get q_gc_029_opt4 => 'Mask of gold (Burqa)';

  @override
  String get q_gc_030_text => 'What do the colors of most Gulf flags symbolize? (Red, White, Green, Black)';

  @override
  String get q_gc_030_opt1 => 'Arab unity and courage';

  @override
  String get q_gc_030_opt2 => 'Nature and peace';

  @override
  String get q_gc_030_opt3 => 'Modernity';

  @override
  String get q_gc_030_opt4 => 'Trade and culture';

  @override
  String get q_mv_001_text => 'Which Gulf TV show is famous for its funny sketches during Ramadan?';

  @override
  String get q_mv_001_opt1 => 'Tash Ma Tash';

  @override
  String get q_mv_001_opt2 => 'Selfie';

  @override
  String get q_mv_001_opt3 => 'Shabab Al Bomb';

  @override
  String get q_mv_001_opt4 => 'All of the above';

  @override
  String get q_mv_002_text => 'Who is known as the “Father of Kuwaiti Theatre”?';

  @override
  String get q_mv_002_opt1 => 'Abdulhussain Abdulredha';

  @override
  String get q_mv_002_opt2 => 'Saad Al-Faraj';

  @override
  String get q_mv_002_opt3 => 'Nayef Al-Rodan';

  @override
  String get q_mv_002_opt4 => 'Hayat Al-Fahad';

  @override
  String get q_mv_003_text => 'Which country produced the popular TV show “Tash Ma Tash”?';

  @override
  String get q_mv_003_opt1 => 'Saudi Arabia';

  @override
  String get q_mv_003_opt2 => 'Kuwait';

  @override
  String get q_mv_003_opt3 => 'UAE';

  @override
  String get q_mv_003_opt4 => 'Bahrain';

  @override
  String get q_mv_004_text => 'Which Arab country is famous for its film industry called “Hollywood of the Middle East”?';

  @override
  String get q_mv_004_opt1 => 'Egypt';

  @override
  String get q_mv_004_opt2 => 'Lebanon';

  @override
  String get q_mv_004_opt3 => 'Jordan';

  @override
  String get q_mv_004_opt4 => 'UAE';

  @override
  String get q_mv_005_text => 'Which actress is considered a legend of Kuwaiti TV drama?';

  @override
  String get q_mv_005_opt1 => 'Hayat Al-Fahad';

  @override
  String get q_mv_005_opt2 => 'Soad Abdullah';

  @override
  String get q_mv_005_opt3 => 'Haya Abdul Salam';

  @override
  String get q_mv_005_opt4 => 'Muna Shaddad';

  @override
  String get q_mv_006_text => 'Which Gulf country often produces Ramadan TV dramas every year?';

  @override
  String get q_mv_006_opt1 => 'Kuwait';

  @override
  String get q_mv_006_opt2 => 'Oman';

  @override
  String get q_mv_006_opt3 => 'Bahrain';

  @override
  String get q_mv_006_opt4 => 'Yemen';

  @override
  String get q_mv_007_text => 'What language are most Gulf TV series filmed in?';

  @override
  String get q_mv_007_opt1 => 'Khaliji Arabic';

  @override
  String get q_mv_007_opt2 => 'English';

  @override
  String get q_mv_007_opt3 => 'Egyptian Arabic';

  @override
  String get q_mv_007_opt4 => 'French';

  @override
  String get q_mv_008_text => 'What is the name of the famous Emirati comedy show featuring daily life humor?';

  @override
  String get q_mv_008_opt1 => 'Freej';

  @override
  String get q_mv_008_opt2 => 'Tash Ma Tash';

  @override
  String get q_mv_008_opt3 => 'Al Douri';

  @override
  String get q_mv_008_opt4 => 'Selfie';

  @override
  String get q_mv_009_text => 'Which TV show features old Gulf traditions and wisdom in a comedic way?';

  @override
  String get q_mv_009_opt1 => 'Darb Al Zalag';

  @override
  String get q_mv_009_opt2 => 'Freej';

  @override
  String get q_mv_009_opt3 => 'Selfie';

  @override
  String get q_mv_009_opt4 => 'Shaabiyat Al Cartoon';

  @override
  String get q_mv_010_text => 'Who played the role of “Hassan” in “Darb Al Zalag”?';

  @override
  String get q_mv_010_opt1 => 'Abdulhussain Abdulredha';

  @override
  String get q_mv_010_opt2 => 'Saad Al-Faraj';

  @override
  String get q_mv_010_opt3 => 'Khaled Al-Nafisi';

  @override
  String get q_mv_010_opt4 => 'Ali Al-Mufidi';

  @override
  String get q_mv_011_text => 'What is the main theme of the Syrian series “Bab Al-Hara”?';

  @override
  String get q_mv_011_opt1 => 'Life in old Damascus';

  @override
  String get q_mv_011_opt2 => 'Crime solving';

  @override
  String get q_mv_011_opt3 => 'Science fiction';

  @override
  String get q_mv_011_opt4 => 'Comedy';

  @override
  String get q_mv_012_text => 'Which Gulf actor starred in “Selfie,” known for social satire?';

  @override
  String get q_mv_012_opt1 => 'Nasser Al-Qasabi';

  @override
  String get q_mv_012_opt2 => 'Abdulhussain Abdulredha';

  @override
  String get q_mv_012_opt3 => 'Tariq Al-Ali';

  @override
  String get q_mv_012_opt4 => 'Saad Al-Faraj';

  @override
  String get q_mv_013_text => 'Which Kuwaiti actress is known as the “Queen of Drama”?';

  @override
  String get q_mv_013_opt1 => 'Hayat Al-Fahad';

  @override
  String get q_mv_013_opt2 => 'Soad Abdullah';

  @override
  String get q_mv_013_opt3 => 'Haya Abdul Salam';

  @override
  String get q_mv_013_opt4 => 'Laila Abdullah';

  @override
  String get q_mv_014_text => 'In which month do Gulf families usually enjoy new drama releases?';

  @override
  String get q_mv_014_opt1 => 'Ramadan';

  @override
  String get q_mv_014_opt2 => 'January';

  @override
  String get q_mv_014_opt3 => 'June';

  @override
  String get q_mv_014_opt4 => 'December';

  @override
  String get q_mv_015_text => 'Which Arab singer starred in the movie “The Message”?';

  @override
  String get q_mv_015_opt1 => 'Abdallah Al Rowaished';

  @override
  String get q_mv_015_opt2 => 'Omar Sharif';

  @override
  String get q_mv_015_opt3 => 'Mohammed Abdo';

  @override
  String get q_mv_015_opt4 => 'Mustafa Akkad';

  @override
  String get q_mv_016_text => 'Which Emirati animated series celebrates traditional life and women’s friendship?';

  @override
  String get q_mv_016_opt1 => 'Freej';

  @override
  String get q_mv_016_opt2 => 'Shaabiyat Al Cartoon';

  @override
  String get q_mv_016_opt3 => 'Kids TV';

  @override
  String get q_mv_016_opt4 => 'Tash Ma Tash';

  @override
  String get q_mv_017_text => 'Which Gulf TV series was one of the first to tackle social issues openly?';

  @override
  String get q_mv_017_opt1 => 'Selfie';

  @override
  String get q_mv_017_opt2 => 'Tash Ma Tash';

  @override
  String get q_mv_017_opt3 => 'Shabab Al Bomb';

  @override
  String get q_mv_017_opt4 => 'Hob Wahd';

  @override
  String get q_mv_018_text => 'Which Egyptian actor is famous for his role in “The Yacoubian Building”?';

  @override
  String get q_mv_018_opt1 => 'Adel Imam';

  @override
  String get q_mv_018_opt2 => 'Ahmed Helmy';

  @override
  String get q_mv_018_opt3 => 'Amr Diab';

  @override
  String get q_mv_018_opt4 => 'Mohamed Ramadan';

  @override
  String get q_mv_019_text => 'What is a common theme in Gulf family TV dramas?';

  @override
  String get q_mv_019_opt1 => 'Tradition and family values';

  @override
  String get q_mv_019_opt2 => 'Fantasy worlds';

  @override
  String get q_mv_019_opt3 => 'Action scenes';

  @override
  String get q_mv_019_opt4 => 'Science fiction';

  @override
  String get q_mv_020_text => 'Which Gulf actor is known for his comedic roles and popular stage performances?';

  @override
  String get q_mv_020_opt1 => 'Tariq Al-Ali';

  @override
  String get q_mv_020_opt2 => 'Saad Al-Faraj';

  @override
  String get q_mv_020_opt3 => 'Nasser Al-Qasabi';

  @override
  String get q_mv_020_opt4 => 'Hayat Al-Fahad';

  @override
  String get q_mv_021_text => 'What was the first color TV series produced in Kuwait?';

  @override
  String get q_mv_021_opt1 => 'Darb Al Zalag';

  @override
  String get q_mv_021_opt2 => 'Al Assouf';

  @override
  String get q_mv_021_opt3 => 'Al Darb Al Taweel';

  @override
  String get q_mv_021_opt4 => 'Bayt Al Tawa';

  @override
  String get q_mv_022_text => 'Which Gulf director is known for blending modern storytelling with tradition?';

  @override
  String get q_mv_022_opt1 => 'Saud Al-Khalaf';

  @override
  String get q_mv_022_opt2 => 'Ali Al-Kandari';

  @override
  String get q_mv_022_opt3 => 'Hamad Al-Humaid';

  @override
  String get q_mv_022_opt4 => 'Fahad Al-Mufarrej';

  @override
  String get q_mv_023_text => 'Which Arab TV channel is most known for premiering Ramadan dramas?';

  @override
  String get q_mv_023_opt1 => 'MBC';

  @override
  String get q_mv_023_opt2 => 'Dubai TV';

  @override
  String get q_mv_023_opt3 => 'Al Jazeera';

  @override
  String get q_mv_023_opt4 => 'Rotana Cinema';

  @override
  String get q_mv_024_text => 'Which Kuwaiti film was nominated at international festivals for best short film?';

  @override
  String get q_mv_024_opt1 => 'The Watermelon';

  @override
  String get q_mv_024_opt2 => 'The Intruder';

  @override
  String get q_mv_024_opt3 => 'Between the Sand and the Sea';

  @override
  String get q_mv_024_opt4 => 'Hob El Awal';

  @override
  String get q_mv_025_text => 'What was the first Gulf movie to screen at Cannes Film Festival?';

  @override
  String get q_mv_025_opt1 => 'City of Life';

  @override
  String get q_mv_025_opt2 => 'Letters to Palestine';

  @override
  String get q_mv_025_opt3 => 'Wadjda';

  @override
  String get q_mv_025_opt4 => 'Sea Shadow';

  @override
  String get q_mv_026_text => 'Which Saudi film made history as the first directed by a woman?';

  @override
  String get q_mv_026_opt1 => 'Wadjda';

  @override
  String get q_mv_026_opt2 => 'Barakah Meets Barakah';

  @override
  String get q_mv_026_opt3 => 'The Perfect Candidate';

  @override
  String get q_mv_026_opt4 => 'Scales';

  @override
  String get q_mv_027_text => 'Which Gulf actor is nicknamed “The Professor of Comedy”?';

  @override
  String get q_mv_027_opt1 => 'Abdulhussain Abdulredha';

  @override
  String get q_mv_027_opt2 => 'Tariq Al-Ali';

  @override
  String get q_mv_027_opt3 => 'Nasser Al-Qasabi';

  @override
  String get q_mv_027_opt4 => 'Hayat Al-Fahad';

  @override
  String get q_mv_028_text => 'Which UAE film told the story of friendship across generations?';

  @override
  String get q_mv_028_opt1 => 'Sea Shadow';

  @override
  String get q_mv_028_opt2 => 'City of Life';

  @override
  String get q_mv_028_opt3 => 'The Dreamer';

  @override
  String get q_mv_028_opt4 => 'The Diver';

  @override
  String get q_mv_029_text => 'Which Saudi TV drama follows family struggles during the 1970s oil boom?';

  @override
  String get q_mv_029_opt1 => 'Al Assouf';

  @override
  String get q_mv_029_opt2 => 'Selfie';

  @override
  String get q_mv_029_opt3 => 'Shabab Al Bomb';

  @override
  String get q_mv_029_opt4 => 'Hob Wahd';

  @override
  String get q_mv_030_text => 'Who is the famous Egyptian comedian known as “El Zaeem”?';

  @override
  String get q_mv_030_opt1 => 'Adel Imam';

  @override
  String get q_mv_030_opt2 => 'Mohamed Henedy';

  @override
  String get q_mv_030_opt3 => 'Ahmed Mekky';

  @override
  String get q_mv_030_opt4 => 'Omar Sharif';

  @override
  String get q_mu_001_text => 'Who is known as the “Artist of the Arabs”?';

  @override
  String get q_mu_001_opt1 => 'Mohammed Abdu';

  @override
  String get q_mu_001_opt2 => 'Rashed Al-Majed';

  @override
  String get q_mu_001_opt3 => 'Abdallah Al Rowaished';

  @override
  String get q_mu_001_opt4 => 'Kadim Al Sahir';

  @override
  String get q_mu_002_text => 'Which Kuwaiti singer is known for the song “Ya Tayr El Hob”?';

  @override
  String get q_mu_002_opt1 => 'Abdallah Al Rowaished';

  @override
  String get q_mu_002_opt2 => 'Nabeel Shuail';

  @override
  String get q_mu_002_opt3 => 'Rashed Al-Majed';

  @override
  String get q_mu_002_opt4 => 'Talal Maddah';

  @override
  String get q_mu_003_text => 'What instrument is commonly used in traditional Gulf music?';

  @override
  String get q_mu_003_opt1 => 'Oud';

  @override
  String get q_mu_003_opt2 => 'Guitar';

  @override
  String get q_mu_003_opt3 => 'Piano';

  @override
  String get q_mu_003_opt4 => 'Violin';

  @override
  String get q_mu_004_text => 'Which Saudi singer performed “El Amaken”?';

  @override
  String get q_mu_004_opt1 => 'Mohammed Abdu';

  @override
  String get q_mu_004_opt2 => 'Abdul Majeed Abdullah';

  @override
  String get q_mu_004_opt3 => 'Rashed Al-Majed';

  @override
  String get q_mu_004_opt4 => 'Nabeel Shuail';

  @override
  String get q_mu_005_text => 'Which Emirati singer is known for the hit “Ahebbak”?';

  @override
  String get q_mu_005_opt1 => 'Hussain Al Jassmi';

  @override
  String get q_mu_005_opt2 => 'Balqees Fathi';

  @override
  String get q_mu_005_opt3 => 'Fahad Al Kubaisi';

  @override
  String get q_mu_005_opt4 => 'Abdul Majeed Abdullah';

  @override
  String get q_mu_006_text => 'Which musical style features drums and rhythmic clapping at weddings?';

  @override
  String get q_mu_006_opt1 => 'Laywa';

  @override
  String get q_mu_006_opt2 => 'Hip hop';

  @override
  String get q_mu_006_opt3 => 'Jazz';

  @override
  String get q_mu_006_opt4 => 'Techno';

  @override
  String get q_mu_007_text => 'Which country is singer Rashed Al-Majed from?';

  @override
  String get q_mu_007_opt1 => 'Saudi Arabia';

  @override
  String get q_mu_007_opt2 => 'Kuwait';

  @override
  String get q_mu_007_opt3 => 'Qatar';

  @override
  String get q_mu_007_opt4 => 'UAE';

  @override
  String get q_mu_008_text => 'Which Emirati singer became popular with “Boshret Khair”?';

  @override
  String get q_mu_008_opt1 => 'Hussain Al Jassmi';

  @override
  String get q_mu_008_opt2 => 'Majid Al Mohandis';

  @override
  String get q_mu_008_opt3 => 'Abdul Majeed Abdullah';

  @override
  String get q_mu_008_opt4 => 'Balqees Fathi';

  @override
  String get q_mu_009_text => 'What is the traditional dance performed to live drumming in Gulf weddings?';

  @override
  String get q_mu_009_opt1 => 'Ardah';

  @override
  String get q_mu_009_opt2 => 'Samba';

  @override
  String get q_mu_009_opt3 => 'Ballet';

  @override
  String get q_mu_009_opt4 => 'Salsa';

  @override
  String get q_mu_010_text => 'Which Kuwaiti artist is called “The Voice of Kuwait”?';

  @override
  String get q_mu_010_opt1 => 'Nabeel Shuail';

  @override
  String get q_mu_010_opt2 => 'Abdallah Al Rowaished';

  @override
  String get q_mu_010_opt3 => 'Bader Al Shuaibi';

  @override
  String get q_mu_010_opt4 => 'Rashed Al-Majed';

  @override
  String get q_mu_011_text => 'Which Iraqi artist is known as “The Caesar of Arabic Song”?';

  @override
  String get q_mu_011_opt1 => 'Kadim Al Sahir';

  @override
  String get q_mu_011_opt2 => 'Majid Al Mohandis';

  @override
  String get q_mu_011_opt3 => 'Saber Rebai';

  @override
  String get q_mu_011_opt4 => 'Amr Diab';

  @override
  String get q_mu_012_text => 'Which Saudi artist is known for the song “Ya Taib El Galb”?';

  @override
  String get q_mu_012_opt1 => 'Abdul Majeed Abdullah';

  @override
  String get q_mu_012_opt2 => 'Mohammed Abdu';

  @override
  String get q_mu_012_opt3 => 'Majid Al Mohandis';

  @override
  String get q_mu_012_opt4 => 'Rashed Al-Majed';

  @override
  String get q_mu_013_text => 'Which female Emirati singer is the daughter of Ahmed Fathi?';

  @override
  String get q_mu_013_opt1 => 'Balqees Fathi';

  @override
  String get q_mu_013_opt2 => 'Ahlam Al Shamsi';

  @override
  String get q_mu_013_opt3 => 'Diana Haddad';

  @override
  String get q_mu_013_opt4 => 'Shamma Hamdan';

  @override
  String get q_mu_014_text => 'Which Egyptian pop singer is famous for “Tamally Maak”?';

  @override
  String get q_mu_014_opt1 => 'Amr Diab';

  @override
  String get q_mu_014_opt2 => 'Tamer Hosny';

  @override
  String get q_mu_014_opt3 => 'Mohamed Hamaki';

  @override
  String get q_mu_014_opt4 => 'Ramy Sabry';

  @override
  String get q_mu_015_text => 'Which Gulf traditional instrument produces deep drum beats?';

  @override
  String get q_mu_015_opt1 => 'Mirwas';

  @override
  String get q_mu_015_opt2 => 'Tabla';

  @override
  String get q_mu_015_opt3 => 'Tambourine';

  @override
  String get q_mu_015_opt4 => 'Cajón';

  @override
  String get q_mu_016_text => 'Which Lebanese singer is known for her hit “Ya Tabtab”?';

  @override
  String get q_mu_016_opt1 => 'Nancy Ajram';

  @override
  String get q_mu_016_opt2 => 'Elissa';

  @override
  String get q_mu_016_opt3 => 'Haifa Wehbe';

  @override
  String get q_mu_016_opt4 => 'Myriam Fares';

  @override
  String get q_mu_017_text => 'Which Gulf artist famously sang at Expo 2020 Dubai opening?';

  @override
  String get q_mu_017_opt1 => 'Ahlam Al Shamsi';

  @override
  String get q_mu_017_opt2 => 'Hussain Al Jassmi';

  @override
  String get q_mu_017_opt3 => 'Balqees Fathi';

  @override
  String get q_mu_017_opt4 => 'Rashed Al-Majed';

  @override
  String get q_mu_018_text => 'Which Saudi musician is known for blending pop and traditional sounds?';

  @override
  String get q_mu_018_opt1 => 'Abdul Majeed Abdullah';

  @override
  String get q_mu_018_opt2 => 'Tariq Al-Harbi';

  @override
  String get q_mu_018_opt3 => 'Rashed Al-Majed';

  @override
  String get q_mu_018_opt4 => 'Talal Maddah';

  @override
  String get q_mu_019_text => 'Which Gulf female singer is known as “Queen of Stage”?';

  @override
  String get q_mu_019_opt1 => 'Ahlam Al Shamsi';

  @override
  String get q_mu_019_opt2 => 'Balqees Fathi';

  @override
  String get q_mu_019_opt3 => 'Diana Haddad';

  @override
  String get q_mu_019_opt4 => 'Shamma Hamdan';

  @override
  String get q_mu_020_text => 'Which Arabic song became a global hit with its “Habibi” lyrics?';

  @override
  String get q_mu_020_opt1 => 'Habibi Ya Nour El Ain';

  @override
  String get q_mu_020_opt2 => 'Ya Tabtab';

  @override
  String get q_mu_020_opt3 => 'Ahebbak';

  @override
  String get q_mu_020_opt4 => 'Tamally Maak';

  @override
  String get q_mu_021_text => 'Who composed the Saudi national anthem?';

  @override
  String get q_mu_021_opt1 => 'Ibrahim Khafaji';

  @override
  String get q_mu_021_opt2 => 'Talal Maddah';

  @override
  String get q_mu_021_opt3 => 'Abdulrahman Al-Khateeb';

  @override
  String get q_mu_021_opt4 => 'Abdul Majeed Abdullah';

  @override
  String get q_mu_022_text => 'Which Kuwaiti composer is known for shaping the Gulf musical identity?';

  @override
  String get q_mu_022_opt1 => 'Ahmad Baqer';

  @override
  String get q_mu_022_opt2 => 'Bader Al Shuaibi';

  @override
  String get q_mu_022_opt3 => 'Mohammed Shams';

  @override
  String get q_mu_022_opt4 => 'Nabeel Shuail';

  @override
  String get q_mu_023_text => 'Which Gulf singer was called “The Golden Voice of Arabia”?';

  @override
  String get q_mu_023_opt1 => 'Talal Maddah';

  @override
  String get q_mu_023_opt2 => 'Mohammed Abdu';

  @override
  String get q_mu_023_opt3 => 'Abdul Majeed Abdullah';

  @override
  String get q_mu_023_opt4 => 'Rashed Al-Majed';

  @override
  String get q_mu_024_text => 'Which country is home to the annual “Winter at Tantora” music festival?';

  @override
  String get q_mu_024_opt1 => 'Saudi Arabia';

  @override
  String get q_mu_024_opt2 => 'Kuwait';

  @override
  String get q_mu_024_opt3 => 'UAE';

  @override
  String get q_mu_024_opt4 => 'Bahrain';

  @override
  String get q_mu_025_text => 'Which musical form combines poetry and rhythm in Gulf tradition?';

  @override
  String get q_mu_025_opt1 => 'Samri';

  @override
  String get q_mu_025_opt2 => 'Ardah';

  @override
  String get q_mu_025_opt3 => 'Laywa';

  @override
  String get q_mu_025_opt4 => 'Khaleeji pop';

  @override
  String get q_mu_026_text => 'Which Gulf singer collaborated with international artist RedOne?';

  @override
  String get q_mu_026_opt1 => 'Ahlam Al Shamsi';

  @override
  String get q_mu_026_opt2 => 'Balqees Fathi';

  @override
  String get q_mu_026_opt3 => 'Rashed Al-Majed';

  @override
  String get q_mu_026_opt4 => 'Abdul Majeed Abdullah';

  @override
  String get q_mu_027_text => 'Which Bahraini singer is known for the song “Ma’ak Rouh”?';

  @override
  String get q_mu_027_opt1 => 'Hala Al Turk';

  @override
  String get q_mu_027_opt2 => 'Ahmed Al Jumairi';

  @override
  String get q_mu_027_opt3 => 'Isa Qattan';

  @override
  String get q_mu_027_opt4 => 'Khaled Fouad';

  @override
  String get q_mu_028_text => 'Which legendary Egyptian singer was known as “Kawkab El Sharq” (Star of the East)?';

  @override
  String get q_mu_028_opt1 => 'Umm Kulthum';

  @override
  String get q_mu_028_opt2 => 'Fairouz';

  @override
  String get q_mu_028_opt3 => 'Abdel Halim Hafez';

  @override
  String get q_mu_028_opt4 => 'Warda Al Jazairia';

  @override
  String get q_mu_029_text => 'Which Gulf musician pioneered the modern “Khaleeji pop” genre?';

  @override
  String get q_mu_029_opt1 => 'Rashed Al-Majed';

  @override
  String get q_mu_029_opt2 => 'Talal Maddah';

  @override
  String get q_mu_029_opt3 => 'Abdallah Al Rowaished';

  @override
  String get q_mu_029_opt4 => 'Mohammed Abdu';

  @override
  String get q_mu_030_text => 'Which Arabic singer performed the famous song “Enta Omri”?';

  @override
  String get q_mu_030_opt1 => 'Umm Kulthum';

  @override
  String get q_mu_030_opt2 => 'Fairouz';

  @override
  String get q_mu_030_opt3 => 'Warda';

  @override
  String get q_mu_030_opt4 => 'Samira Said';

  @override
  String get q_fc_001_text => 'Make your teammates laugh in under 15 seconds!';

  @override
  String get q_fc_002_text => 'Talk like a robot for the next 20 seconds.';

  @override
  String get q_fc_003_text => 'Act like a cat trying to catch a laser pointer.';

  @override
  String get q_fc_004_text => 'Say your full name backward as fast as you can.';

  @override
  String get q_fc_005_text => 'Pretend you are a famous singer performing on stage.';

  @override
  String get q_fc_006_text => 'Dance without music for 10 seconds.';

  @override
  String get q_fc_007_text => 'Imitate a crying baby until everyone laughs.';

  @override
  String get q_fc_008_text => 'Say “Dorak” five times as fast as possible without mistakes.';

  @override
  String get q_fc_009_text => 'Pretend your hand is a phone and talk to your “best friend.”';

  @override
  String get q_fc_010_text => 'Stand on one leg for 10 seconds while saying the alphabet backward.';

  @override
  String get q_fc_011_text => 'Do 10 jumping jacks while making a funny sound after each one.';

  @override
  String get q_fc_012_text => 'Act like an animal your team chooses for 15 seconds.';

  @override
  String get q_fc_013_text => 'Hold a silly face for 10 seconds without laughing.';

  @override
  String get q_fc_014_text => 'Pretend you are stuck inside a box and try to get out.';

  @override
  String get q_fc_015_text => 'Spin around three times, then walk in a straight line.';

  @override
  String get q_fc_016_text => 'Say everything you speak for the next 30 seconds in song.';

  @override
  String get q_fc_017_text => 'Act out brushing your teeth in slow motion.';

  @override
  String get q_fc_018_text => 'Pretend to interview your teammate as if they are a celebrity.';

  @override
  String get q_fc_019_text => 'Make up a dance move and name it after yourself.';

  @override
  String get q_fc_020_text => 'Tell a one-minute story using only animal sounds.';

  @override
  String get q_fc_021_text => 'Balance something on your head for 20 seconds without dropping it.';

  @override
  String get q_fc_022_text => 'Do 10 push-ups while your team cheers you on.';

  @override
  String get q_fc_023_text => 'Act like a news reporter giving “breaking news” about your team.';

  @override
  String get q_fc_024_text => 'Imitate your teammate’s laugh until everyone laughs.';

  @override
  String get q_fc_025_text => 'Say a tongue twister five times correctly: “She sells seashells by the seashore.”';

  @override
  String get q_fc_026_text => 'Make up a commercial for an imaginary product (like “Invisible Shoes”).';

  @override
  String get q_fc_027_text => 'Pretend to be a chef teaching how to cook “air soup.”';

  @override
  String get q_fc_028_text => 'Spin in a circle while singing your favorite song.';

  @override
  String get q_fc_029_text => 'Pass the phone to another player while clapping rhythmically.';

  @override
  String get q_fc_030_text => 'Do your best imitation of a famous movie villain for 20 seconds.';

  @override
  String get q_kc_001_text => 'What color is the sky on a clear, sunny day?';

  @override
  String get q_kc_001_opt1 => 'Blue';

  @override
  String get q_kc_001_opt2 => 'Green';

  @override
  String get q_kc_001_opt3 => 'Red';

  @override
  String get q_kc_001_opt4 => 'Purple';

  @override
  String get q_kc_002_text => 'How many legs does a cat have?';

  @override
  String get q_kc_002_opt1 => 'Four';

  @override
  String get q_kc_002_opt2 => 'Two';

  @override
  String get q_kc_002_opt3 => 'Six';

  @override
  String get q_kc_002_opt4 => 'Eight';

  @override
  String get q_kc_003_text => 'Which animal says “Moo”?';

  @override
  String get q_kc_003_opt1 => 'Cow';

  @override
  String get q_kc_003_opt2 => 'Dog';

  @override
  String get q_kc_003_opt3 => 'Sheep';

  @override
  String get q_kc_003_opt4 => 'Cat';

  @override
  String get q_kc_004_text => 'What do bees make?';

  @override
  String get q_kc_004_opt1 => 'Honey';

  @override
  String get q_kc_004_opt2 => 'Milk';

  @override
  String get q_kc_004_opt3 => 'Butter';

  @override
  String get q_kc_004_opt4 => 'Juice';

  @override
  String get q_kc_005_text => 'What is 2 + 3?';

  @override
  String get q_kc_005_opt1 => '4';

  @override
  String get q_kc_005_opt2 => '5';

  @override
  String get q_kc_005_opt3 => '6';

  @override
  String get q_kc_005_opt4 => '3';

  @override
  String get q_kc_006_text => 'Which fruit keeps the doctor away if you eat one every day?';

  @override
  String get q_kc_006_opt1 => 'Apple';

  @override
  String get q_kc_006_opt2 => 'Banana';

  @override
  String get q_kc_006_opt3 => 'Orange';

  @override
  String get q_kc_006_opt4 => 'Mango';

  @override
  String get q_kc_007_text => 'What color are bananas when they are ripe?';

  @override
  String get q_kc_007_opt1 => 'Yellow';

  @override
  String get q_kc_007_opt2 => 'Green';

  @override
  String get q_kc_007_opt3 => 'Red';

  @override
  String get q_kc_007_opt4 => 'Brown';

  @override
  String get q_kc_008_text => 'Which planet do we live on?';

  @override
  String get q_kc_008_opt1 => 'Earth';

  @override
  String get q_kc_008_opt2 => 'Mars';

  @override
  String get q_kc_008_opt3 => 'Venus';

  @override
  String get q_kc_008_opt4 => 'Jupiter';

  @override
  String get q_kc_009_text => 'What do you call a baby dog?';

  @override
  String get q_kc_009_opt1 => 'Puppy';

  @override
  String get q_kc_009_opt2 => 'Kitten';

  @override
  String get q_kc_009_opt3 => 'Cub';

  @override
  String get q_kc_009_opt4 => 'Chick';

  @override
  String get q_kc_010_text => 'Which shape has three sides?';

  @override
  String get q_kc_010_opt1 => 'Triangle';

  @override
  String get q_kc_010_opt2 => 'Square';

  @override
  String get q_kc_010_opt3 => 'Circle';

  @override
  String get q_kc_010_opt4 => 'Star';

  @override
  String get q_kc_011_text => 'What do plants need to make their food?';

  @override
  String get q_kc_011_opt1 => 'Sunlight';

  @override
  String get q_kc_011_opt2 => 'Moonlight';

  @override
  String get q_kc_011_opt3 => 'Wind';

  @override
  String get q_kc_011_opt4 => 'Snow';

  @override
  String get q_kc_012_text => 'Which animal is known as the “King of the Jungle”?';

  @override
  String get q_kc_012_opt1 => 'Lion';

  @override
  String get q_kc_012_opt2 => 'Elephant';

  @override
  String get q_kc_012_opt3 => 'Tiger';

  @override
  String get q_kc_012_opt4 => 'Bear';

  @override
  String get q_kc_013_text => 'What do you call the person who flies an airplane?';

  @override
  String get q_kc_013_opt1 => 'Pilot';

  @override
  String get q_kc_013_opt2 => 'Driver';

  @override
  String get q_kc_013_opt3 => 'Captain';

  @override
  String get q_kc_013_opt4 => 'Mechanic';

  @override
  String get q_kc_014_text => 'How many days are there in a week?';

  @override
  String get q_kc_014_opt1 => '7';

  @override
  String get q_kc_014_opt2 => '5';

  @override
  String get q_kc_014_opt3 => '10';

  @override
  String get q_kc_014_opt4 => '12';

  @override
  String get q_kc_015_text => 'Which animal can live both in water and on land?';

  @override
  String get q_kc_015_opt1 => 'Frog';

  @override
  String get q_kc_015_opt2 => 'Fish';

  @override
  String get q_kc_015_opt3 => 'Dog';

  @override
  String get q_kc_015_opt4 => 'Bird';

  @override
  String get q_kc_016_text => 'What do you use to brush your teeth?';

  @override
  String get q_kc_016_opt1 => 'Toothbrush';

  @override
  String get q_kc_016_opt2 => 'Spoon';

  @override
  String get q_kc_016_opt3 => 'Comb';

  @override
  String get q_kc_016_opt4 => 'Towel';

  @override
  String get q_kc_017_text => 'Which Gulf country has the Burj Khalifa?';

  @override
  String get q_kc_017_opt1 => 'UAE';

  @override
  String get q_kc_017_opt2 => 'Qatar';

  @override
  String get q_kc_017_opt3 => 'Saudi Arabia';

  @override
  String get q_kc_017_opt4 => 'Bahrain';

  @override
  String get q_kc_018_text => 'What color do you get when you mix blue and yellow?';

  @override
  String get q_kc_018_opt1 => 'Green';

  @override
  String get q_kc_018_opt2 => 'Red';

  @override
  String get q_kc_018_opt3 => 'Purple';

  @override
  String get q_kc_018_opt4 => 'Orange';

  @override
  String get q_kc_019_text => 'What is the opposite of “hot”?';

  @override
  String get q_kc_019_opt1 => 'Cold';

  @override
  String get q_kc_019_opt2 => 'Warm';

  @override
  String get q_kc_019_opt3 => 'Wet';

  @override
  String get q_kc_019_opt4 => 'Cool';

  @override
  String get q_kc_020_text => 'Which season comes after spring?';

  @override
  String get q_kc_020_opt1 => 'Summer';

  @override
  String get q_kc_020_opt2 => 'Winter';

  @override
  String get q_kc_020_opt3 => 'Autumn';

  @override
  String get q_kc_020_opt4 => 'Rainy';

  @override
  String get q_kc_021_text => 'What gas do humans breathe in to live?';

  @override
  String get q_kc_021_opt1 => 'Oxygen';

  @override
  String get q_kc_021_opt2 => 'Carbon Dioxide';

  @override
  String get q_kc_021_opt3 => 'Nitrogen';

  @override
  String get q_kc_021_opt4 => 'Hydrogen';

  @override
  String get q_kc_022_text => 'Which planet is known as the Red Planet?';

  @override
  String get q_kc_022_opt1 => 'Mars';

  @override
  String get q_kc_022_opt2 => 'Venus';

  @override
  String get q_kc_022_opt3 => 'Mercury';

  @override
  String get q_kc_022_opt4 => 'Jupiter';

  @override
  String get q_kc_023_text => 'What do you call a baby cow?';

  @override
  String get q_kc_023_opt1 => 'Calf';

  @override
  String get q_kc_023_opt2 => 'Foal';

  @override
  String get q_kc_023_opt3 => 'Cub';

  @override
  String get q_kc_023_opt4 => 'Pup';

  @override
  String get q_kc_024_text => 'What is the largest mammal in the world?';

  @override
  String get q_kc_024_opt1 => 'Blue Whale';

  @override
  String get q_kc_024_opt2 => 'Elephant';

  @override
  String get q_kc_024_opt3 => 'Shark';

  @override
  String get q_kc_024_opt4 => 'Giraffe';

  @override
  String get q_kc_025_text => 'Which country is famous for making pizza?';

  @override
  String get q_kc_025_opt1 => 'Italy';

  @override
  String get q_kc_025_opt2 => 'France';

  @override
  String get q_kc_025_opt3 => 'Egypt';

  @override
  String get q_kc_025_opt4 => 'Greece';

  @override
  String get q_kc_026_text => 'Which instrument has black and white keys?';

  @override
  String get q_kc_026_opt1 => 'Piano';

  @override
  String get q_kc_026_opt2 => 'Drum';

  @override
  String get q_kc_026_opt3 => 'Guitar';

  @override
  String get q_kc_026_opt4 => 'Violin';

  @override
  String get q_kc_027_text => 'What is the process called when water turns into vapor?';

  @override
  String get q_kc_027_opt1 => 'Evaporation';

  @override
  String get q_kc_027_opt2 => 'Condensation';

  @override
  String get q_kc_027_opt3 => 'Freezing';

  @override
  String get q_kc_027_opt4 => 'Boiling';

  @override
  String get q_kc_028_text => 'Which Gulf city is known for its man-made Palm Island?';

  @override
  String get q_kc_028_opt1 => 'Dubai';

  @override
  String get q_kc_028_opt2 => 'Doha';

  @override
  String get q_kc_028_opt3 => 'Muscat';

  @override
  String get q_kc_028_opt4 => 'Manama';

  @override
  String get q_kc_029_text => 'What is the fastest land animal?';

  @override
  String get q_kc_029_opt1 => 'Cheetah';

  @override
  String get q_kc_029_opt2 => 'Lion';

  @override
  String get q_kc_029_opt3 => 'Horse';

  @override
  String get q_kc_029_opt4 => 'Gazelle';

  @override
  String get q_kc_030_text => 'What do you call the small holes on your skin that sweat comes from?';

  @override
  String get q_kc_030_opt1 => 'Pores';

  @override
  String get q_kc_030_opt2 => 'Spots';

  @override
  String get q_kc_030_opt3 => 'Cells';

  @override
  String get q_kc_030_opt4 => 'Glands';

  @override
  String get q_qt_001_text => 'Name a fruit that is yellow.';

  @override
  String get q_qt_001_opt1 => 'Banana';

  @override
  String get q_qt_001_opt2 => 'Lemon';

  @override
  String get q_qt_001_opt3 => 'Mango';

  @override
  String get q_qt_001_opt4 => 'Pineapple';

  @override
  String get q_qt_002_text => 'What color do you get when you mix red and white?';

  @override
  String get q_qt_002_opt1 => 'Pink';

  @override
  String get q_qt_002_opt2 => 'Orange';

  @override
  String get q_qt_002_opt3 => 'Brown';

  @override
  String get q_qt_002_opt4 => 'Purple';

  @override
  String get q_qt_003_text => 'Say the word “fast” five times without stopping!';

  @override
  String get q_qt_004_text => 'Name something you can wear on your head.';

  @override
  String get q_qt_004_opt1 => 'Hat';

  @override
  String get q_qt_004_opt2 => 'Cap';

  @override
  String get q_qt_004_opt3 => 'Scarf';

  @override
  String get q_qt_004_opt4 => 'Helmet';

  @override
  String get q_qt_005_text => 'Clap your hands 10 times as fast as you can!';

  @override
  String get q_qt_006_text => 'What is 10 - 3?';

  @override
  String get q_qt_006_opt1 => '7';

  @override
  String get q_qt_006_opt2 => '6';

  @override
  String get q_qt_006_opt3 => '8';

  @override
  String get q_qt_006_opt4 => '5';

  @override
  String get q_qt_007_text => 'Spell the word “GAME” backward.';

  @override
  String get q_qt_008_text => 'Name any animal that can fly.';

  @override
  String get q_qt_008_opt1 => 'Bird';

  @override
  String get q_qt_008_opt2 => 'Bat';

  @override
  String get q_qt_008_opt3 => 'Eagle';

  @override
  String get q_qt_008_opt4 => 'Butterfly';

  @override
  String get q_qt_009_text => 'Say the names of 3 Gulf countries in 10 seconds!';

  @override
  String get q_qt_010_text => 'Name something you use every morning.';

  @override
  String get q_qt_010_opt1 => 'Toothbrush';

  @override
  String get q_qt_010_opt2 => 'Phone';

  @override
  String get q_qt_010_opt3 => 'Towel';

  @override
  String get q_qt_010_opt4 => 'All of the above';

  @override
  String get q_qt_011_text => 'List 3 animals that live in water.';

  @override
  String get q_qt_012_text => 'Name something round other than a ball.';

  @override
  String get q_qt_012_opt1 => 'Plate';

  @override
  String get q_qt_012_opt2 => 'Coin';

  @override
  String get q_qt_012_opt3 => 'Clock';

  @override
  String get q_qt_012_opt4 => 'All of the above';

  @override
  String get q_qt_013_text => 'Say 5 words that start with the letter “S.”';

  @override
  String get q_qt_014_text => 'Name 3 Gulf countries that start with a vowel.';

  @override
  String get q_qt_015_text => 'Count from 1 to 10 in under 3 seconds!';

  @override
  String get q_qt_016_text => 'If you have 5 apples and give 2 away, how many are left?';

  @override
  String get q_qt_016_opt1 => '3';

  @override
  String get q_qt_016_opt2 => '2';

  @override
  String get q_qt_016_opt3 => '5';

  @override
  String get q_qt_016_opt4 => '1';

  @override
  String get q_qt_017_text => 'Name 3 things that use electricity.';

  @override
  String get q_qt_017_opt1 => 'Phone';

  @override
  String get q_qt_017_opt2 => 'TV';

  @override
  String get q_qt_017_opt3 => 'Fan';

  @override
  String get q_qt_017_opt4 => 'All of the above';

  @override
  String get q_qt_018_text => 'Say the alphabet without the letter “A.”';

  @override
  String get q_qt_019_text => 'Name one Gulf country and its capital.';

  @override
  String get q_qt_019_opt1 => 'Kuwait – Kuwait City';

  @override
  String get q_qt_019_opt2 => 'UAE – Abu Dhabi';

  @override
  String get q_qt_019_opt3 => 'Qatar – Doha';

  @override
  String get q_qt_019_opt4 => 'All of the above';

  @override
  String get q_qt_020_text => 'Name 3 things that are cold.';

  @override
  String get q_qt_020_opt1 => 'Ice';

  @override
  String get q_qt_020_opt2 => 'Snow';

  @override
  String get q_qt_020_opt3 => 'Juice';

  @override
  String get q_qt_020_opt4 => 'All of the above';

  @override
  String get q_qt_021_text => 'Name 5 fruits in 10 seconds!';

  @override
  String get q_qt_022_text => 'Say the word “banana” backward without pausing.';

  @override
  String get q_qt_023_text => 'Name something that is both a food and a color.';

  @override
  String get q_qt_023_opt1 => 'Orange';

  @override
  String get q_qt_023_opt2 => 'Peach';

  @override
  String get q_qt_023_opt3 => 'Lemon';

  @override
  String get q_qt_023_opt4 => 'All of the above';

  @override
  String get q_qt_024_text => 'Say 5 Gulf cities as fast as you can.';

  @override
  String get q_qt_025_text => 'List 3 things that can melt.';

  @override
  String get q_qt_025_opt1 => 'Ice';

  @override
  String get q_qt_025_opt2 => 'Chocolate';

  @override
  String get q_qt_025_opt3 => 'Butter';

  @override
  String get q_qt_025_opt4 => 'All of the above';

  @override
  String get q_qt_026_text => 'If you rearrange the letters of “DORAK,” what new word can you make?';

  @override
  String get q_qt_026_opt1 => 'Road';

  @override
  String get q_qt_026_opt2 => 'Dark';

  @override
  String get q_qt_026_opt3 => 'Radko';

  @override
  String get q_qt_026_opt4 => 'None';

  @override
  String get q_qt_027_text => 'Say a word that rhymes with “Game.”';

  @override
  String get q_qt_027_opt1 => 'Name';

  @override
  String get q_qt_027_opt2 => 'Same';

  @override
  String get q_qt_027_opt3 => 'Flame';

  @override
  String get q_qt_027_opt4 => 'All of the above';

  @override
  String get q_qt_028_text => 'Name 3 things you’d take to the beach.';

  @override
  String get q_qt_028_opt1 => 'Towel';

  @override
  String get q_qt_028_opt2 => 'Sunscreen';

  @override
  String get q_qt_028_opt3 => 'Water';

  @override
  String get q_qt_028_opt4 => 'All of the above';

  @override
  String get q_qt_029_text => 'Say your birth month and the name of an animal that starts with the same letter.';

  @override
  String get q_qt_030_text => 'Spell the word “challenge” correctly — but fast!';
}
