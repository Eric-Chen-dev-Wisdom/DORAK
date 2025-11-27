// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get nicknameLabel => 'الاسم المستعار';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get createNewRoom => 'إنشاء غرفة جديدة';

  @override
  String get continueGuest => 'العب كضيف';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get welcome => 'مرحبًا بك في دوراك!';

  @override
  String get viewMatchHistory => 'عرض سجل المباريات';

  @override
  String get selectCategories => 'اختر الفئات';

  @override
  String get selectCategoriesHint => 'اختر من 5 إلى 8 فئات لبدء اللعبة';

  @override
  String get difficulty => 'الصعوبة';

  @override
  String get numberOfQuestions => 'عدد الأسئلة';

  @override
  String startGame(Object count) {
    return 'ابدأ اللعبة ($count/٥)';
  }

  @override
  String get waitingForHost => 'في انتظار المضيف لاختيار الفئات...';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get invalidEmail => 'الرجاء إدخال بريد إلكتروني صالح';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get passwordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟ قم بتسجيل الدخول';

  @override
  String get signInTitle => 'تسجيل الدخول';

  @override
  String get welcomeTitle => 'مرحبًا بك في دورك!';

  @override
  String get welcomeSubtitle => 'سجّل الدخول لحفظ تقدمك والتنافس مع الأصدقاء';

  @override
  String get signInButton => 'تسجيل الدخول بالبريد الإلكتروني';

  @override
  String get noAccount => 'ليس لديك حساب؟ أنشئ حسابًا';

  @override
  String get googleButton => 'المتابعة باستخدام Google';

  @override
  String get appleButton => 'المتابعة باستخدام Apple';

  @override
  String get guestButton => 'المتابعة كضيف';

  @override
  String get firebaseInitError => 'فشل تهيئة Firebase';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get back => 'رجوع';

  @override
  String get gameLobbyTitle => 'الردهة';

  @override
  String get connectingRoom => 'جارٍ الاتصال بالغرفة...';

  @override
  String get enterNickname => 'أدخل اسمك المستعار';

  @override
  String get createRoom => 'إنشاء غرفة';

  @override
  String get joinExistingRoom => 'الانضمام إلى غرفة موجودة';

  @override
  String get roomCodeLabel => 'رمز الغرفة';

  @override
  String get roomCodeHint => 'أدخل رمزاً مكوناً من 6 أحرف';

  @override
  String get teamA => 'الفريق أ';

  @override
  String get teamB => 'الفريق ب';

  @override
  String get joinRoom => 'انضم إلى الغرفة';

  @override
  String get roomCreated => 'تم إنشاء الغرفة!';

  @override
  String code(Object roomCode) {
    return 'الرمز: $roomCode';
  }

  @override
  String get shareRoomCode => 'مشاركة رمز الغرفة';

  @override
  String liveStatus(Object playerCount) {
    return 'متصل - $playerCount لاعب متصل';
  }

  @override
  String get noPlayersYet => 'لا يوجد لاعبون بعد';

  @override
  String get guestLabel => 'ضيف';

  @override
  String get memberLabel => 'عضو';

  @override
  String get liveChat => 'الدردشة المباشرة';

  @override
  String get noMessagesYet => 'لا توجد رسائل بعد\nابدأ المحادثة!';

  @override
  String get typeMessageHint => 'اكتب رسالة...';

  @override
  String get chatOn => 'مفعل';

  @override
  String get chatOff => 'متوقف';

  @override
  String get startGameDialogTitle => 'بدء اللعبة؟';

  @override
  String startGameDialogContent(Object playerCount) {
    return 'هل أنت مستعد لبدء اللعبة مع $playerCount لاعبين؟';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get startGameNow => 'ابدأ اللعبة الآن!';

  @override
  String copyCodeSuccess(Object roomCode) {
    return 'تم نسخ رمز الغرفة $roomCode إلى الحافظة! شاركه مع أصدقائك.';
  }

  @override
  String get copyCodeFailed => 'فشل في مشاركة رمز الغرفة. حاول مرة أخرى.';

  @override
  String errorConnectingRoom(Object error) {
    return 'حدث خطأ أثناء الاتصال بالغرفة: $error';
  }

  @override
  String get roomJoinFailed => 'لم يتم العثور على الغرفة أو فشل الانضمام.';

  @override
  String createRoomFailed(Object error) {
    return 'فشل في إنشاء الغرفة: $error';
  }

  @override
  String get needMorePlayers => 'يجب أن يكون هناك لاعبان على الأقل لبدء اللعبة!';

  @override
  String get onlyHostCanStart => 'فقط المضيف يمكنه بدء اللعبة.';

  @override
  String get invalidRoomCode => 'يرجى إدخال رمز مكون من ٦ أحرف.';

  @override
  String errorJoiningRoom(Object error) {
    return 'خطأ أثناء الانضمام إلى الغرفة: $error';
  }

  @override
  String get or => 'أو';

  @override
  String chatError(Object error) {
    return 'خطأ في الدردشة: $error';
  }

  @override
  String get on => 'تشغيل';

  @override
  String get off => 'إيقاف';

  @override
  String get chatControlsComingSoon => 'عناصر التحكم في الدردشة قريباً!';

  @override
  String get unknownUser => 'مستخدم غير معروف';

  @override
  String get you => 'أنت';

  @override
  String get selectRange => 'اختر من ٥ إلى ٨ فئات';

  @override
  String selectedCount(Object count) {
    return '$count محددة (الحد الأدنى: ٥، الحد الأقصى: ٨)';
  }

  @override
  String get maximumCategories => 'الحد الأقصى ٨ فئات فقط';

  @override
  String get minimumCategories => 'يرجى اختيار فئة واحدة على الأقل';

  @override
  String get categoryAll => 'الكل';

  @override
  String get categoryEasy => 'سهل';

  @override
  String get categoryMedium => 'متوسط';

  @override
  String get categoryHard => 'صعب';

  @override
  String get maxEightCategories => 'الحد الأقصى ٨ فئات فقط';

  @override
  String get pleaseSelectAtLeastOneCategory => 'يرجى اختيار فئة واحدة على الأقل';

  @override
  String get selectCategoriesTitle => 'اختر الفئات';

  @override
  String get select58Categories => 'اختر من ٥ إلى ٨ فئات';

  @override
  String selectedCategoriesCount(Object count) {
    return '$count محددة (الحد الأدنى: ٥، الحد الأقصى: ٨)';
  }

  @override
  String get difficultyAll => 'الكل';

  @override
  String get difficultyEasy => 'سهل';

  @override
  String get difficultyMedium => 'متوسط';

  @override
  String get difficultyHard => 'صعب';

  @override
  String get difficultyLabel => 'مستوى الصعوبة';

  @override
  String questionCount(Object count) {
    return '$count سؤال';
  }

  @override
  String get questionsLabel => 'عدد الأسئلة';

  @override
  String startGameButton(Object count) {
    return 'ابدأ اللعبة ($count/٥)';
  }

  @override
  String get waitingForHostToSelectCategories => 'في انتظار المضيف لاختيار الفئات...';

  @override
  String get gameTitle => 'لعبة دورك';

  @override
  String get time => 'الوقت';

  @override
  String get seconds => 'ثوانٍ';

  @override
  String get players => 'اللاعبون';

  @override
  String get generalKnowledge => 'معلومات عامة';

  @override
  String questionOfTotal(Object current, Object total) {
    return 'السؤال $current من $total';
  }

  @override
  String get selectAnswer => 'اختر إجابتك:';

  @override
  String get submitVote => 'إرسال الإجابة';

  @override
  String get teamVotes => 'أصوات الفرق';

  @override
  String votesCount(Object count) {
    return '$count صوت';
  }

  @override
  String get votingInProgress => 'التصويت جارٍ...';

  @override
  String voteSubmitted(Object option) {
    return 'تم إرسال التصويت للخيار $option';
  }

  @override
  String get questionSkipped => 'تم تخطي السؤال!';

  @override
  String get votingStarted => 'بدأ التصويت! يمكن للفرق إرسال الإجابات الآن.';

  @override
  String answerRevealed(Object a, Object b) {
    return 'تم الكشف عن الإجابة! الفريق أ: +$a، الفريق ب: +$b';
  }

  @override
  String powerCardActivated(Object card) {
    return 'تم تفعيل $card!';
  }

  @override
  String get hostControls => 'خيارات المضيف';

  @override
  String get hostControlTooltip => 'فتح لوحة تحكم المضيف';

  @override
  String get dorakGameTitle => 'لعبة دورك';

  @override
  String get hostControlsTooltip => 'خيارات المضيف';

  @override
  String get timeLabel => 'الوقت';

  @override
  String get secondsLabel => 'ثوانٍ';

  @override
  String playersCount(Object count) {
    return '$count لاعب';
  }

  @override
  String questionNumber(Object current, Object total) {
    return 'السؤال $current من $total';
  }

  @override
  String get selectYourAnswer => 'اختر إجابتك:';

  @override
  String voteSubmittedOption(Object option) {
    return 'تم إرسال التصويت للخيار $option';
  }

  @override
  String get hostControlsTitle => 'خيارات المضيف';

  @override
  String get gameStateLabel => 'حالة اللعبة';

  @override
  String get timerControlLabel => 'التحكم في المؤقت';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get start => 'ابدأ';

  @override
  String get reset => 'إعادة ضبط';

  @override
  String get quickAdjust => 'تعديل سريع:';

  @override
  String get pointsControlLabel => 'التحكم في النقاط';

  @override
  String teamLabel(Object team) {
    return 'الفريق $team';
  }

  @override
  String get awardPoints => 'منح النقاط:';

  @override
  String get votingStatusLabel => 'حالة التصويت';

  @override
  String get teamAVotesLabel => 'أصوات الفريق أ';

  @override
  String get teamBVotesLabel => 'أصوات الفريق ب';

  @override
  String get startVoting => 'بدء التصويت';

  @override
  String get revealAnswer => 'كشف الإجابة';

  @override
  String get questionControls => 'التحكم في الأسئلة';

  @override
  String get nextQuestion => 'السؤال التالي';

  @override
  String get skip => 'تخطي';

  @override
  String get powerCards => 'بطاقات القوة';

  @override
  String get doublePoints => 'نقاط مضاعفة';

  @override
  String get stealPoints => 'سرقة النقاط';

  @override
  String get reverseTurn => 'عكس الدور';

  @override
  String get skipRound => 'تخطي الجولة';

  @override
  String get endGame => 'إنهاء اللعبة';

  @override
  String get endGameDialogTitle => 'إنهاء اللعبة؟';

  @override
  String get endGameDialogContent => 'هل أنت متأكد أنك تريد إنهاء اللعبة الحالية؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get endGameConfirm => 'إنهاء اللعبة';

  @override
  String get timesUp => 'انتهى الوقت!';

  @override
  String get doublePointsDesc => 'الإجابة الصحيحة التالية ستكون بنقاط مضاعفة!';

  @override
  String get stealPointsDesc => 'اسرق نقطتين من الفريق الآخر!';

  @override
  String get reverseTurnDesc => 'يذهب السؤال إلى الفريق الآخر!';

  @override
  String get skipRoundDesc => 'يتم تخطي السؤال الحالي!';

  @override
  String activatedFallback(Object card) {
    return 'تم تفعيل $card!';
  }

  @override
  String get points => 'نقطة';

  @override
  String get doublePointsEffect => 'الإجابة الصحيحة التالية ستكون بنقاط مضاعفة!';

  @override
  String get stealPointsEffect => 'اسرق نقطتين من الفريق الآخر!';

  @override
  String get reverseTurnEffect => 'يذهب السؤال إلى الفريق الآخر!';

  @override
  String get skipRoundEffect => 'يتم تخطي السؤال الحالي!';

  @override
  String get activated => 'تم التفعيل';

  @override
  String get roomCode => 'رمز الغرفة';

  @override
  String get gameState => 'حالة اللعبة';

  @override
  String get waiting => 'في الانتظار';

  @override
  String get inGame => 'قيد اللعب';

  @override
  String get roundComplete => 'الجولة مكتملة';

  @override
  String get gameComplete => 'اللعبة مكتملة';

  @override
  String get timerControl => 'التحكم في المؤقت';

  @override
  String get minus10s => '-10 ثوانٍ';

  @override
  String get minus5s => '-5 ثوانٍ';

  @override
  String get plus5s => '+5 ثوانٍ';

  @override
  String get plus10s => '+10 ثوانٍ';

  @override
  String get pointsControl => 'التحكم في النقاط';

  @override
  String get correct => 'صحيح!';

  @override
  String get great => 'رائع!';

  @override
  String get team => 'فريق';

  @override
  String get votingStatus => 'حالة التصويت';

  @override
  String get votes => 'أصوات';

  @override
  String get doubleNextPoints => 'نقاط مضاعفة تالية';

  @override
  String get steal2Points => 'سرقة نقطتين';

  @override
  String get reverseQuestion => 'عكس السؤال';

  @override
  String get skipQuestion => 'تخطي السؤال';

  @override
  String get endGameQ => 'إنهاء اللعبة؟';

  @override
  String get endGameWarning => 'هل أنت متأكد أنك تريد إنهاء اللعبة الحالية؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get gameResultsTitle => 'نتائج اللعبة';

  @override
  String get itsATie => 'إنها تعادل!';

  @override
  String get teamAWins => '🎉 الفريق أ فاز!';

  @override
  String get teamBWins => '🎉 الفريق ب فاز!';

  @override
  String get finalScores => 'النتائج النهائية';

  @override
  String pointsAbbreviation(Object score) {
    return '$score نقطة';
  }

  @override
  String get backToHome => 'العودة إلى الصفحة الرئيسية';

  @override
  String get tryAgain => 'أعد المحاولة';

  @override
  String get unknownPlayer => 'لاعب غير معروف';

  @override
  String get winnerBannerPath => 'assets/images/winner.png';

  @override
  String get loserBannerPath => 'assets/images/loser.png';

  @override
  String get categoryGeneralKnowledge => 'المعارف العامة';

  @override
  String get categoryGeneralKnowledgeDesc => 'اختبر معلوماتك العامة';

  @override
  String get categoryFamilyLife => 'الحياة العائلية';

  @override
  String get categoryFamilyLifeDesc => 'أسئلة ممتعة عن العائلة';

  @override
  String get categoryGulfCulture => 'الثقافة الخليجية';

  @override
  String get categoryGulfCultureDesc => 'أسئلة عن التقاليد الخليجية';

  @override
  String get categoryMoviesTV => 'الأفلام والتلفزيون';

  @override
  String get categoryMoviesTVDesc => 'خمن الأفلام والبرامج التلفزيونية';

  @override
  String get categoryMusic => 'الموسيقى';

  @override
  String get categoryMusicDesc => 'مسابقة موسيقية وكاريوكي';

  @override
  String get categoryFunnyChallenges => 'تحديات مضحكة';

  @override
  String get categoryFunnyChallengesDesc => 'تحديات بدنية مرحة';

  @override
  String get categoryKidsCorner => 'زاوية الأطفال';

  @override
  String get categoryKidsCornerDesc => 'مرح للأطفال الصغار';

  @override
  String get categoryQuickThinking => 'سرعة التفكير';

  @override
  String get categoryQuickThinkingDesc => 'ألغاز ذهنية سريعة الإيقاع';

  @override
  String get selectCountLabel => 'اختر من ٥ إلى ٨ فئات';

  @override
  String selectedCountStatus(Object count) {
    return '$count فئات مختارة (الحد الأدنى: ٥، الحد الأقصى: ٨)';
  }

  @override
  String get maxCategoriesWarning => 'الحد الأقصى ٨ فئات فقط';

  @override
  String get tieResult => 'تعادل!';

  @override
  String get gameResults => 'نتائج اللعبة';

  @override
  String get cat_1Name => 'ثقافة عامة';

  @override
  String get cat_1Desc => 'اختبر معلوماتك العامة';

  @override
  String get cat_2Name => 'حياة عائلية';

  @override
  String get cat_2Desc => 'أسئلة ممتعة عن العائلة';

  @override
  String get cat_3Name => 'ثقافة الخليج';

  @override
  String get cat_3Desc => 'أسئلة عن عادات وتقاليد الخليج';

  @override
  String get cat_4Name => 'أفلام وتلفزيون';

  @override
  String get cat_4Desc => 'خمن الأفلام والمسلسلات';

  @override
  String get cat_5Name => 'موسيقى';

  @override
  String get cat_5Desc => 'أسئلة موسيقية وكاريوكي';

  @override
  String get cat_6Name => 'تحديات مضحكة';

  @override
  String get cat_6Desc => 'تحديات حركية مضحكة';

  @override
  String get cat_7Name => 'ركن الأطفال';

  @override
  String get cat_7Desc => 'متعة للصغار';

  @override
  String get cat_8Name => 'تفكير سريع';

  @override
  String get cat_8Desc => 'ألغاز سريعة الإيقاع';

  @override
  String get q_gk_001_text => 'ما عاصمة المملكة العربية السعودية؟';

  @override
  String get q_gk_001_opt1 => 'الرياض';

  @override
  String get q_gk_001_opt2 => 'جدة';

  @override
  String get q_gk_001_opt3 => 'الدوحة';

  @override
  String get q_gk_001_opt4 => 'دبي';

  @override
  String get q_gk_002_text => 'ما لون الموز الناضج؟';

  @override
  String get q_gk_002_opt1 => 'أخضر';

  @override
  String get q_gk_002_opt2 => 'أصفر';

  @override
  String get q_gk_002_opt3 => 'أحمر';

  @override
  String get q_gk_002_opt4 => 'أزرق';

  @override
  String get q_gk_003_text => 'كم عدد الأيام في الأسبوع؟';

  @override
  String get q_gk_003_opt1 => '5';

  @override
  String get q_gk_003_opt2 => '6';

  @override
  String get q_gk_003_opt3 => '7';

  @override
  String get q_gk_003_opt4 => '8';

  @override
  String get q_gk_004_text => 'أي كوكب يُعرف بالكوكب الأحمر؟';

  @override
  String get q_gk_004_opt1 => 'الزهرة';

  @override
  String get q_gk_004_opt2 => 'المريخ';

  @override
  String get q_gk_004_opt3 => 'المشتري';

  @override
  String get q_gk_004_opt4 => 'عطارد';

  @override
  String get q_gk_005_text => 'كم عدد حروف الأبجدية الإنجليزية؟';

  @override
  String get q_gk_005_opt1 => '24';

  @override
  String get q_gk_005_opt2 => '25';

  @override
  String get q_gk_005_opt3 => '26';

  @override
  String get q_gk_005_opt4 => '27';

  @override
  String get q_gk_006_text => 'ماذا تصنع النحل؟';

  @override
  String get q_gk_006_opt1 => 'العسل';

  @override
  String get q_gk_006_opt2 => 'الحليب';

  @override
  String get q_gk_006_opt3 => 'الشمع';

  @override
  String get q_gk_006_opt4 => 'السكر';

  @override
  String get q_gk_007_text => 'ما هو أكبر محيط في العالم؟';

  @override
  String get q_gk_007_opt1 => 'الأطلسي';

  @override
  String get q_gk_007_opt2 => 'الهندي';

  @override
  String get q_gk_007_opt3 => 'الهادئ';

  @override
  String get q_gk_007_opt4 => 'القطبي';

  @override
  String get q_gk_008_text => 'كم عدد أضلاع المثلث؟';

  @override
  String get q_gk_008_opt1 => '2';

  @override
  String get q_gk_008_opt2 => '3';

  @override
  String get q_gk_008_opt3 => '4';

  @override
  String get q_gk_008_opt4 => '5';

  @override
  String get q_gk_009_text => 'ما هو الاسم الشائع لـ H₂O؟';

  @override
  String get q_gk_009_opt1 => 'الأكسجين';

  @override
  String get q_gk_009_opt2 => 'الملح';

  @override
  String get q_gk_009_opt3 => 'الماء';

  @override
  String get q_gk_009_opt4 => 'الهيدروجين';

  @override
  String get q_gk_010_text => 'أي حيوان يُعرف بملك الغابة؟';

  @override
  String get q_gk_010_opt1 => 'النمر';

  @override
  String get q_gk_010_opt2 => 'الأسد';

  @override
  String get q_gk_010_opt3 => 'الفيل';

  @override
  String get q_gk_010_opt4 => 'الفهد';

  @override
  String get q_gk_011_text => 'من كتب المسرحية الشهيرة \"روميو وجولييت\"؟';

  @override
  String get q_gk_011_opt1 => 'شكسبير';

  @override
  String get q_gk_011_opt2 => 'هوميروس';

  @override
  String get q_gk_011_opt3 => 'تولستوي';

  @override
  String get q_gk_011_opt4 => 'تشارلز ديكنز';

  @override
  String get q_gk_012_text => 'ما الغاز الذي تنتجه النباتات أثناء عملية التمثيل الضوئي؟';

  @override
  String get q_gk_012_opt1 => 'الأكسجين';

  @override
  String get q_gk_012_opt2 => 'ثاني أكسيد الكربون';

  @override
  String get q_gk_012_opt3 => 'النيتروجين';

  @override
  String get q_gk_012_opt4 => 'الهيدروجين';

  @override
  String get q_gk_013_text => 'ما هو أكبر صحراء في العالم؟';

  @override
  String get q_gk_013_opt1 => 'الصحراء الكبرى';

  @override
  String get q_gk_013_opt2 => 'الصحراء العربية';

  @override
  String get q_gk_013_opt3 => 'صحراء جوبي';

  @override
  String get q_gk_013_opt4 => 'القارة القطبية الجنوبية';

  @override
  String get q_gk_014_text => 'أي معدن يكون سائلاً في درجة حرارة الغرفة؟';

  @override
  String get q_gk_014_opt1 => 'الزئبق';

  @override
  String get q_gk_014_opt2 => 'الذهب';

  @override
  String get q_gk_014_opt3 => 'الفضة';

  @override
  String get q_gk_014_opt4 => 'الألومنيوم';

  @override
  String get q_gk_015_text => 'من كان أول شخص يمشي على سطح القمر؟';

  @override
  String get q_gk_015_opt1 => 'نيل أرمسترونغ';

  @override
  String get q_gk_015_opt2 => 'باز ألدرين';

  @override
  String get q_gk_015_opt3 => 'يوري غاغارين';

  @override
  String get q_gk_015_opt4 => 'آلان شيبرد';

  @override
  String get q_gk_016_text => 'أي قارة تحتوي على أكبر عدد من الدول؟';

  @override
  String get q_gk_016_opt1 => 'آسيا';

  @override
  String get q_gk_016_opt2 => 'أوروبا';

  @override
  String get q_gk_016_opt3 => 'أفريقيا';

  @override
  String get q_gk_016_opt4 => 'أمريكا الجنوبية';

  @override
  String get q_gk_017_text => 'ما هو أطول نهر في العالم؟';

  @override
  String get q_gk_017_opt1 => 'النيل';

  @override
  String get q_gk_017_opt2 => 'الأمازون';

  @override
  String get q_gk_017_opt3 => 'اليانغتسي';

  @override
  String get q_gk_017_opt4 => 'المسيسيبي';

  @override
  String get q_gk_018_text => 'أي دولة اخترعت الورق؟';

  @override
  String get q_gk_018_opt1 => 'الصين';

  @override
  String get q_gk_018_opt2 => 'مصر';

  @override
  String get q_gk_018_opt3 => 'الهند';

  @override
  String get q_gk_018_opt4 => 'اليونان';

  @override
  String get q_gk_019_text => 'في أي عام انتهت الحرب العالمية الثانية؟';

  @override
  String get q_gk_019_opt1 => '1942';

  @override
  String get q_gk_019_opt2 => '1943';

  @override
  String get q_gk_019_opt3 => '1945';

  @override
  String get q_gk_019_opt4 => '1948';

  @override
  String get q_gk_020_text => 'أي مدينة خليجية تُعرف باسم \"مدينة الذهب\"؟';

  @override
  String get q_gk_020_opt1 => 'دبي';

  @override
  String get q_gk_020_opt2 => 'مدينة الكويت';

  @override
  String get q_gk_020_opt3 => 'الرياض';

  @override
  String get q_gk_020_opt4 => 'الدوحة';

  @override
  String get q_gk_021_text => 'ما هو الرمز الكيميائي للذهب؟';

  @override
  String get q_gk_021_opt1 => 'Au';

  @override
  String get q_gk_021_opt2 => 'Ag';

  @override
  String get q_gk_021_opt3 => 'Gd';

  @override
  String get q_gk_021_opt4 => 'Pt';

  @override
  String get q_gk_022_text => 'من اكتشف قانون الجاذبية؟';

  @override
  String get q_gk_022_opt1 => 'إسحاق نيوتن';

  @override
  String get q_gk_022_opt2 => 'ألبرت أينشتاين';

  @override
  String get q_gk_022_opt3 => 'جاليليو';

  @override
  String get q_gk_022_opt4 => 'أرخميدس';

  @override
  String get q_gk_023_text => 'ما هي أصغر عظمة في جسم الإنسان؟';

  @override
  String get q_gk_023_opt1 => 'الركاب';

  @override
  String get q_gk_023_opt2 => 'الفخذ';

  @override
  String get q_gk_023_opt3 => 'القصبة';

  @override
  String get q_gk_023_opt4 => 'الزند';

  @override
  String get q_gk_024_text => 'أي كوكب يحتوي على أكبر عدد من الأقمار؟';

  @override
  String get q_gk_024_opt1 => 'المشتري';

  @override
  String get q_gk_024_opt2 => 'زحل';

  @override
  String get q_gk_024_opt3 => 'نبتون';

  @override
  String get q_gk_024_opt4 => 'المريخ';

  @override
  String get q_gk_025_text => 'في أي عام تأسست الأمم المتحدة؟';

  @override
  String get q_gk_025_opt1 => '1940';

  @override
  String get q_gk_025_opt2 => '1945';

  @override
  String get q_gk_025_opt3 => '1950';

  @override
  String get q_gk_025_opt4 => '1955';

  @override
  String get q_gk_026_text => 'ما هي أقسى مادة طبيعية على الأرض؟';

  @override
  String get q_gk_026_opt1 => 'الذهب';

  @override
  String get q_gk_026_opt2 => 'الحديد';

  @override
  String get q_gk_026_opt3 => 'الماس';

  @override
  String get q_gk_026_opt4 => 'الفولاذ';

  @override
  String get q_gk_027_text => 'ما هي عملة اليابان؟';

  @override
  String get q_gk_027_opt1 => 'يوان';

  @override
  String get q_gk_027_opt2 => 'ين';

  @override
  String get q_gk_027_opt3 => 'وون';

  @override
  String get q_gk_027_opt4 => 'رينغيت';

  @override
  String get q_gk_028_text => 'أي عنصر كيميائي رمزه “Na”؟';

  @override
  String get q_gk_028_opt1 => 'الصوديوم';

  @override
  String get q_gk_028_opt2 => 'النيتروجين';

  @override
  String get q_gk_028_opt3 => 'النيكل';

  @override
  String get q_gk_028_opt4 => 'النيون';

  @override
  String get q_gk_029_text => 'ما هي عاصمة كندا؟';

  @override
  String get q_gk_029_opt1 => 'تورونتو';

  @override
  String get q_gk_029_opt2 => 'فانكوفر';

  @override
  String get q_gk_029_opt3 => 'أوتاوا';

  @override
  String get q_gk_029_opt4 => 'مونتريال';

  @override
  String get q_gk_030_text => 'من اقترح نظرية النسبية؟';

  @override
  String get q_gk_030_opt1 => 'أينشتاين';

  @override
  String get q_gk_030_opt2 => 'نيوتن';

  @override
  String get q_gk_030_opt3 => 'تسلا';

  @override
  String get q_gk_030_opt4 => 'كوري';

  @override
  String get q_fl_001_text => 'ما الشيء الذي تفعله العائلات غالبًا معًا في عطلة نهاية الأسبوع؟';

  @override
  String get q_fl_001_opt1 => 'مشاهدة الأفلام';

  @override
  String get q_fl_001_opt2 => 'التسوق';

  @override
  String get q_fl_001_opt3 => 'السكوت';

  @override
  String get q_fl_001_opt4 => 'العمل الإضافي';

  @override
  String get q_fl_002_text => 'من هو عادة أكبر أفراد العائلة سنًا؟';

  @override
  String get q_fl_002_opt1 => 'الأب';

  @override
  String get q_fl_002_opt2 => 'الجد';

  @override
  String get q_fl_002_opt3 => 'الأخ';

  @override
  String get q_fl_002_opt4 => 'العم';

  @override
  String get q_fl_003_text => 'ماذا تتناول معظم العائلات في الخليج معًا يوم الجمعة؟';

  @override
  String get q_fl_003_opt1 => 'الغداء';

  @override
  String get q_fl_003_opt2 => 'الإفطار';

  @override
  String get q_fl_003_opt3 => 'العشاء';

  @override
  String get q_fl_003_opt4 => 'الوجبات الخفيفة';

  @override
  String get q_fl_004_text => 'ما الذي يخبر به الآباء أطفالهم دائمًا بإنهائه قبل اللعب؟';

  @override
  String get q_fl_004_opt1 => 'الواجب المنزلي';

  @override
  String get q_fl_004_opt2 => 'البرامج التلفزيونية';

  @override
  String get q_fl_004_opt3 => 'الألعاب';

  @override
  String get q_fl_004_opt4 => 'المكالمات';

  @override
  String get q_fl_005_text => 'من المسؤول عادة عن الطبخ في معظم المنازل؟';

  @override
  String get q_fl_005_opt1 => 'الأم';

  @override
  String get q_fl_005_opt2 => 'الأب';

  @override
  String get q_fl_005_opt3 => 'الأطفال';

  @override
  String get q_fl_005_opt4 => 'الجار';

  @override
  String get q_fl_006_text => 'ماذا تقول لوالديك قبل مغادرة المنزل؟';

  @override
  String get q_fl_006_opt1 => 'وداعًا';

  @override
  String get q_fl_006_opt2 => 'أراك لاحقًا';

  @override
  String get q_fl_006_opt3 => 'أنا ذاهب';

  @override
  String get q_fl_006_opt4 => 'جميع ما سبق';

  @override
  String get q_fl_007_text => 'ما هو الحيوان الأليف الأكثر شيوعًا في العائلات؟';

  @override
  String get q_fl_007_opt1 => 'الكلب';

  @override
  String get q_fl_007_opt2 => 'القط';

  @override
  String get q_fl_007_opt3 => 'السمك';

  @override
  String get q_fl_007_opt4 => 'الببغاء';

  @override
  String get q_fl_008_text => 'من الذي يُعلم الأدب والاحترام في المنزل؟';

  @override
  String get q_fl_008_opt1 => 'الوالدان';

  @override
  String get q_fl_008_opt2 => 'الأصدقاء';

  @override
  String get q_fl_008_opt3 => 'المعلمون';

  @override
  String get q_fl_008_opt4 => 'التلفاز';

  @override
  String get q_fl_009_text => 'ما الذي تحتفل به العائلات عادة معًا؟';

  @override
  String get q_fl_009_opt1 => 'العيد';

  @override
  String get q_fl_009_opt2 => 'أعياد الميلاد';

  @override
  String get q_fl_009_opt3 => 'حفلات التخرج';

  @override
  String get q_fl_009_opt4 => 'كل ما سبق';

  @override
  String get q_fl_010_text => 'أي غرفة في المنزل تجمع العائلة معًا؟';

  @override
  String get q_fl_010_opt1 => 'غرفة المعيشة';

  @override
  String get q_fl_010_opt2 => 'المطبخ';

  @override
  String get q_fl_010_opt3 => 'المرآب';

  @override
  String get q_fl_010_opt4 => 'غرفة النوم';

  @override
  String get q_fl_011_text => 'ما هي طريقة جيدة لإسعاد أفراد عائلتك؟';

  @override
  String get q_fl_011_opt1 => 'مساعدتهم';

  @override
  String get q_fl_011_opt2 => 'الشكوى';

  @override
  String get q_fl_011_opt3 => 'تجاهلهم';

  @override
  String get q_fl_011_opt4 => 'لومهم';

  @override
  String get q_fl_012_text => 'ما الذي تفعله العائلات خلال أمسيات رمضان؟';

  @override
  String get q_fl_012_opt1 => 'يتناولون الطعام معًا';

  @override
  String get q_fl_012_opt2 => 'يشاهدون التلفاز';

  @override
  String get q_fl_012_opt3 => 'يصلون معًا';

  @override
  String get q_fl_012_opt4 => 'كل ما سبق';

  @override
  String get q_fl_013_text => 'من يقرر عادة خطط الإجازة العائلية؟';

  @override
  String get q_fl_013_opt1 => 'الوالدان';

  @override
  String get q_fl_013_opt2 => 'الأطفال';

  @override
  String get q_fl_013_opt3 => 'الأجداد';

  @override
  String get q_fl_013_opt4 => 'الجيران';

  @override
  String get q_fl_014_text => 'ما الذي يظهره أفراد العائلة الجيدة لبعضهم البعض؟';

  @override
  String get q_fl_014_opt1 => 'الاحترام';

  @override
  String get q_fl_014_opt2 => 'الغضب';

  @override
  String get q_fl_014_opt3 => 'الغيرة';

  @override
  String get q_fl_014_opt4 => 'المنافسة';

  @override
  String get q_fl_015_text => 'ما الذي تفعله العائلات معًا خلال العيد؟';

  @override
  String get q_fl_015_opt1 => 'زيارة الأقارب';

  @override
  String get q_fl_015_opt2 => 'الذهاب إلى العمل';

  @override
  String get q_fl_015_opt3 => 'النوم طوال اليوم';

  @override
  String get q_fl_015_opt4 => 'السفر بمفردهم';

  @override
  String get q_fl_016_text => 'ماذا تقول عندما يعطس أحد أفراد العائلة؟';

  @override
  String get q_fl_016_opt1 => 'يرحمك الله';

  @override
  String get q_fl_016_opt2 => 'عذرًا';

  @override
  String get q_fl_016_opt3 => 'وداعًا';

  @override
  String get q_fl_016_opt4 => 'مرحبًا';

  @override
  String get q_fl_017_text => 'ما الذي يساعد العائلات على البقاء متصلة رغم البعد؟';

  @override
  String get q_fl_017_opt1 => 'المكالمات الهاتفية';

  @override
  String get q_fl_017_opt2 => 'تجاهل بعضهم البعض';

  @override
  String get q_fl_017_opt3 => 'عدم التواصل';

  @override
  String get q_fl_017_opt4 => 'الرسائل فقط';

  @override
  String get q_fl_018_text => 'أي نشاط يقوّي الروابط الأسرية؟';

  @override
  String get q_fl_018_opt1 => 'الطبخ معًا';

  @override
  String get q_fl_018_opt2 => 'الجدال';

  @override
  String get q_fl_018_opt3 => 'اللعب منفصلين';

  @override
  String get q_fl_018_opt4 => 'تناول الطعام بصمت';

  @override
  String get q_fl_019_text => 'ما الذي تستمتع به العائلات الخليجية على الشاطئ؟';

  @override
  String get q_fl_019_opt1 => 'النزهات';

  @override
  String get q_fl_019_opt2 => 'الكرة الطائرة';

  @override
  String get q_fl_019_opt3 => 'السباحة';

  @override
  String get q_fl_019_opt4 => 'كل ما سبق';

  @override
  String get q_fl_020_text => 'ما هي القيمة الأسرية التي تُحترم بشدة في ثقافة الخليج؟';

  @override
  String get q_fl_020_opt1 => 'طاعة الوالدين';

  @override
  String get q_fl_020_opt2 => 'المنافسة';

  @override
  String get q_fl_020_opt3 => 'الصمت';

  @override
  String get q_fl_020_opt4 => 'الاستقلالية';

  @override
  String get q_fl_021_text => 'ما الفائدة الأساسية من تناول الطعام معًا كعائلة؟';

  @override
  String get q_fl_021_opt1 => 'تحسين التواصل';

  @override
  String get q_fl_021_opt2 => 'الأكل بسرعة';

  @override
  String get q_fl_021_opt3 => 'تنظيف أقل';

  @override
  String get q_fl_021_opt4 => 'وقت أطول أمام الشاشة';

  @override
  String get q_fl_022_text => 'أي تقليد عائلي يساعد في نقل القيم بين الأجيال؟';

  @override
  String get q_fl_022_opt1 => 'رواية القصص';

  @override
  String get q_fl_022_opt2 => 'التسوق';

  @override
  String get q_fl_022_opt3 => 'الألعاب الإلكترونية';

  @override
  String get q_fl_022_opt4 => 'مشاهدة التلفاز بمفردك';

  @override
  String get q_fl_023_text => 'ما الذي يمكن أن يسبب البعد بين أفراد العائلة؟';

  @override
  String get q_fl_023_opt1 => 'قلة التواصل';

  @override
  String get q_fl_023_opt2 => 'الاحترام';

  @override
  String get q_fl_023_opt3 => 'المحبة';

  @override
  String get q_fl_023_opt4 => 'الضحك';

  @override
  String get q_fl_024_text => 'لماذا تعتبر الصدق مهمًا في العائلة؟';

  @override
  String get q_fl_024_opt1 => 'لأنه يبني الثقة';

  @override
  String get q_fl_024_opt2 => 'لأنه يسبب المشاجرات';

  @override
  String get q_fl_024_opt3 => 'لأنه يضيع الوقت';

  @override
  String get q_fl_024_opt4 => 'لأنه يجعل الأمور مملة';

  @override
  String get q_fl_025_text => 'ما الطريقة التي يمكن للوالدين بها تعليم المسؤولية للأطفال؟';

  @override
  String get q_fl_025_opt1 => 'توزيع المهام المنزلية';

  @override
  String get q_fl_025_opt2 => 'تجاهل الأخطاء';

  @override
  String get q_fl_025_opt3 => 'القيام بكل شيء عنهم';

  @override
  String get q_fl_025_opt4 => 'مكافأة الكسل';

  @override
  String get q_fl_026_text => 'لماذا الصبر مهم في الحياة الأسرية؟';

  @override
  String get q_fl_026_opt1 => 'للتعامل مع الاختلافات بهدوء';

  @override
  String get q_fl_026_opt2 => 'للنقاش بشكل أفضل';

  @override
  String get q_fl_026_opt3 => 'للفوز دائمًا';

  @override
  String get q_fl_026_opt4 => 'لتجنب المساعدة';

  @override
  String get q_fl_027_text => 'أي حدث عائلي خليجي يجمع الجميع سنويًا؟';

  @override
  String get q_fl_027_opt1 => 'تجمع العيد';

  @override
  String get q_fl_027_opt2 => 'عرض اليوم الوطني';

  @override
  String get q_fl_027_opt3 => 'رحلة فردية';

  @override
  String get q_fl_027_opt4 => 'ماراثون تلفزيوني';

  @override
  String get q_fl_028_text => 'ما مثال على العمل الجماعي الأسري؟';

  @override
  String get q_fl_028_opt1 => 'تنظيف المنزل معًا';

  @override
  String get q_fl_028_opt2 => 'الجدال';

  @override
  String get q_fl_028_opt3 => 'البقاء صامتين';

  @override
  String get q_fl_028_opt4 => 'تجاهل الأعمال المنزلية';

  @override
  String get q_fl_029_text => 'لماذا يجب على العائلات ممارسة الامتنان؟';

  @override
  String get q_fl_029_opt1 => 'لأنه يزيد السعادة';

  @override
  String get q_fl_029_opt2 => 'لأنه يضيع الوقت';

  @override
  String get q_fl_029_opt3 => 'لأنه يسبب المشاكل';

  @override
  String get q_fl_029_opt4 => 'لأنه يولد الحسد';

  @override
  String get q_fl_030_text => 'ما الذي يمكن أن يتعلمه الآباء من الأبناء في العائلات الحديثة؟';

  @override
  String get q_fl_030_opt1 => 'التكنولوجيا الحديثة';

  @override
  String get q_fl_030_opt2 => 'التقاليد القديمة';

  @override
  String get q_fl_030_opt3 => 'القواعد الصارمة';

  @override
  String get q_fl_030_opt4 => 'Less respect';

  @override
  String get q_gc_001_text => 'أي مشروب يُقدَّم تقليديًا أولًا للضيوف في الخليج؟';

  @override
  String get q_gc_001_opt1 => 'القهوة العربية (قهوة)';

  @override
  String get q_gc_001_opt2 => 'الشاي';

  @override
  String get q_gc_001_opt3 => 'العصير';

  @override
  String get q_gc_001_opt4 => 'الماء';

  @override
  String get q_gc_002_text => 'ما هو اسم الخبز التقليدي في الخليج؟';

  @override
  String get q_gc_002_opt1 => 'الرقاق';

  @override
  String get q_gc_002_opt2 => 'التورتيلا';

  @override
  String get q_gc_002_opt3 => 'الشباتي';

  @override
  String get q_gc_002_opt4 => 'الخبز العربي';

  @override
  String get q_gc_003_text => 'ما هو الزي التقليدي الذي يرتديه الرجال في الخليج؟';

  @override
  String get q_gc_003_opt1 => 'الكندورة / الثوب';

  @override
  String get q_gc_003_opt2 => 'الكيمونو';

  @override
  String get q_gc_003_opt3 => 'الكرتا';

  @override
  String get q_gc_003_opt4 => 'البدلة';

  @override
  String get q_gc_004_text => 'أي دولة خليجية مشهورة بالغوص بحثًا عن اللؤلؤ؟';

  @override
  String get q_gc_004_opt1 => 'البحرين';

  @override
  String get q_gc_004_opt2 => 'الكويت';

  @override
  String get q_gc_004_opt3 => 'عُمان';

  @override
  String get q_gc_004_opt4 => 'قطر';

  @override
  String get q_gc_005_text => 'بماذا يفطر الناس في الخليج عادة خلال رمضان؟';

  @override
  String get q_gc_005_opt1 => 'التمر';

  @override
  String get q_gc_005_opt2 => 'الأرز';

  @override
  String get q_gc_005_opt3 => 'الشوربة';

  @override
  String get q_gc_005_opt4 => 'السلطة';

  @override
  String get q_gc_006_text => 'أي دولة خليجية تضم أطول مبنى في العالم؟';

  @override
  String get q_gc_006_opt1 => 'الإمارات العربية المتحدة';

  @override
  String get q_gc_006_opt2 => 'الكويت';

  @override
  String get q_gc_006_opt3 => 'قطر';

  @override
  String get q_gc_006_opt4 => 'عُمان';

  @override
  String get q_gc_007_text => 'ما هو اسم الرقصة التقليدية في الخليج؟';

  @override
  String get q_gc_007_opt1 => 'العرضة';

  @override
  String get q_gc_007_opt2 => 'السالسا';

  @override
  String get q_gc_007_opt3 => 'الباليه';

  @override
  String get q_gc_007_opt4 => 'التانغو';

  @override
  String get q_gc_008_text => 'أي دولة خليجية عاصمتها الدوحة؟';

  @override
  String get q_gc_008_opt1 => 'قطر';

  @override
  String get q_gc_008_opt2 => 'عُمان';

  @override
  String get q_gc_008_opt3 => 'الكويت';

  @override
  String get q_gc_008_opt4 => 'البحرين';

  @override
  String get q_gc_009_text => 'ما هو اسم القارب التقليدي في الخليج؟';

  @override
  String get q_gc_009_opt1 => 'الدهو';

  @override
  String get q_gc_009_opt2 => 'الكانو';

  @override
  String get q_gc_009_opt3 => 'اليخت';

  @override
  String get q_gc_009_opt4 => 'الغواصة';

  @override
  String get q_gc_010_text => 'ماذا تعني الكلمة العربية “يلا”؟';

  @override
  String get q_gc_010_opt1 => 'هيا بنا';

  @override
  String get q_gc_010_opt2 => 'توقف';

  @override
  String get q_gc_010_opt3 => 'وداعًا';

  @override
  String get q_gc_010_opt4 => 'انتظر';

  @override
  String get q_gc_011_text => 'ما هو الطبق الخليجي التقليدي المصنوع من الأرز واللحم والتوابل؟';

  @override
  String get q_gc_011_opt1 => 'المجبوس';

  @override
  String get q_gc_011_opt2 => 'البيتزا';

  @override
  String get q_gc_011_opt3 => 'البرغر';

  @override
  String get q_gc_011_opt4 => 'البرياني';

  @override
  String get q_gc_012_text => 'أي مدينة خليجية تضم سوق واقف الشهير؟';

  @override
  String get q_gc_012_opt1 => 'الدوحة';

  @override
  String get q_gc_012_opt2 => 'دبي';

  @override
  String get q_gc_012_opt3 => 'مسقط';

  @override
  String get q_gc_012_opt4 => 'المنامة';

  @override
  String get q_gc_013_text => 'ما هو العطر الخليجي التقليدي المصنوع من الخشب؟';

  @override
  String get q_gc_013_opt1 => 'العود';

  @override
  String get q_gc_013_opt2 => 'زيت الورد';

  @override
  String get q_gc_013_opt3 => 'الخزامى';

  @override
  String get q_gc_013_opt4 => 'المسك';

  @override
  String get q_gc_014_text => 'أي دولة خليجية تحتفل باليوم الوطني في 2 ديسمبر؟';

  @override
  String get q_gc_014_opt1 => 'الإمارات العربية المتحدة';

  @override
  String get q_gc_014_opt2 => 'الكويت';

  @override
  String get q_gc_014_opt3 => 'البحرين';

  @override
  String get q_gc_014_opt4 => 'عُمان';

  @override
  String get q_gc_015_text => 'ما نوع غطاء الرأس الذي يرتديه الرجال في الخليج؟';

  @override
  String get q_gc_015_opt1 => 'الغترة';

  @override
  String get q_gc_015_opt2 => 'القبعة';

  @override
  String get q_gc_015_opt3 => 'الطاقية';

  @override
  String get q_gc_015_opt4 => 'العمامة';

  @override
  String get q_gc_016_text => 'بماذا تُزيَّن عادة فساتين النساء التقليدية في الخليج؟';

  @override
  String get q_gc_016_opt1 => 'تطريز بخيوط الذهب';

  @override
  String get q_gc_016_opt2 => 'الخرز';

  @override
  String get q_gc_016_opt3 => 'الطلاء';

  @override
  String get q_gc_016_opt4 => 'الأزرار';

  @override
  String get q_gc_017_text => 'أي دولة خليجية تُعرف باسم “أرض اللبان”؟';

  @override
  String get q_gc_017_opt1 => 'عُمان';

  @override
  String get q_gc_017_opt2 => 'قطر';

  @override
  String get q_gc_017_opt3 => 'الكويت';

  @override
  String get q_gc_017_opt4 => 'الإمارات';

  @override
  String get q_gc_018_text => 'ما المصطلح الخليجي الذي يُطلق على التجمع أو المجلس العائلي المسائي؟';

  @override
  String get q_gc_018_opt1 => 'الديوانية / المجلس';

  @override
  String get q_gc_018_opt2 => 'البازار';

  @override
  String get q_gc_018_opt3 => 'المقهى';

  @override
  String get q_gc_018_opt4 => 'السوق';

  @override
  String get q_gc_019_text => 'أي دولة خليجية تضم جزيرة المحرق؟';

  @override
  String get q_gc_019_opt1 => 'البحرين';

  @override
  String get q_gc_019_opt2 => 'قطر';

  @override
  String get q_gc_019_opt3 => 'الإمارات';

  @override
  String get q_gc_019_opt4 => 'السعودية';

  @override
  String get q_gc_020_text => 'ما هي اللفتة التقليدية للضيافة عند استقبال الضيوف في الخليج؟';

  @override
  String get q_gc_020_opt1 => 'تقديم القهوة والتمر';

  @override
  String get q_gc_020_opt2 => 'تشغيل الموسيقى';

  @override
  String get q_gc_020_opt3 => 'تقديم الهدايا';

  @override
  String get q_gc_020_opt4 => 'الطبخ فورًا';

  @override
  String get q_gc_021_text => 'أي دولة خليجية علمها يحتوي على حافة بيضاء مسننة بتسع نقاط؟';

  @override
  String get q_gc_021_opt1 => 'قطر';

  @override
  String get q_gc_021_opt2 => 'البحرين';

  @override
  String get q_gc_021_opt3 => 'عُمان';

  @override
  String get q_gc_021_opt4 => 'الكويت';

  @override
  String get q_gc_022_text => 'في أي دولة خليجية تقع صحراء وهيبة؟';

  @override
  String get q_gc_022_opt1 => 'عُمان';

  @override
  String get q_gc_022_opt2 => 'السعودية';

  @override
  String get q_gc_022_opt3 => 'الكويت';

  @override
  String get q_gc_022_opt4 => 'قطر';

  @override
  String get q_gc_023_text => 'ما هو النشاط الاقتصادي الرئيسي في الخليج قبل اكتشاف النفط؟';

  @override
  String get q_gc_023_opt1 => 'الغوص على اللؤلؤ والتجارة';

  @override
  String get q_gc_023_opt2 => 'الصيد فقط';

  @override
  String get q_gc_023_opt3 => 'الزراعة';

  @override
  String get q_gc_023_opt4 => 'تعدين الذهب';

  @override
  String get q_gc_024_text => 'ماذا تعني كلمة “حبيبي” في اللغة العربية؟';

  @override
  String get q_gc_024_opt1 => 'عزيزي';

  @override
  String get q_gc_024_opt2 => 'صديقي';

  @override
  String get q_gc_024_opt3 => 'معلمي';

  @override
  String get q_gc_024_opt4 => 'طفلي';

  @override
  String get q_gc_025_text => 'أي مهرجان خليجي يحتفل بالتراث والرياضات التقليدية مثل سباقات الهجن؟';

  @override
  String get q_gc_025_opt1 => 'مهرجان الجنادرية';

  @override
  String get q_gc_025_opt2 => 'عيد الفطر';

  @override
  String get q_gc_025_opt3 => 'هلا فبراير';

  @override
  String get q_gc_025_opt4 => 'سوق رمضان';

  @override
  String get q_gc_026_text => 'أي مدينة ميناء خليجية كانت تُعرف سابقًا باسم “فينيسيا الخليج”؟';

  @override
  String get q_gc_026_opt1 => 'مدينة الكويت';

  @override
  String get q_gc_026_opt2 => 'المنامة';

  @override
  String get q_gc_026_opt3 => 'دبي';

  @override
  String get q_gc_026_opt4 => 'مسقط';

  @override
  String get q_gc_027_text => 'ما هي اللعبة الخليجية التقليدية التي تُلعب بالأصداف أو الحجارة الصغيرة؟';

  @override
  String get q_gc_027_opt1 => 'الكرم';

  @override
  String get q_gc_027_opt2 => 'الصينية';

  @override
  String get q_gc_027_opt3 => 'الكرموح';

  @override
  String get q_gc_027_opt4 => 'الحوالين';

  @override
  String get q_gc_028_text => 'من هو الشاعر الخليجي المعروف بلقب “شاعر المليون”؟';

  @override
  String get q_gc_028_opt1 => 'محمد بن راشد آل مكتوم';

  @override
  String get q_gc_028_opt2 => 'نزار قباني';

  @override
  String get q_gc_028_opt3 => 'الأمير خالد الفيصل';

  @override
  String get q_gc_028_opt4 => 'عبدالعزيز القاسمي';

  @override
  String get q_gc_029_text => 'ما هو اسم قطعة المجوهرات التقليدية التي تُرتدى على الرأس أو الجبهة من قبل النساء؟';

  @override
  String get q_gc_029_opt1 => 'التيكة';

  @override
  String get q_gc_029_opt2 => 'البرقع';

  @override
  String get q_gc_029_opt3 => 'ماثا باتي';

  @override
  String get q_gc_029_opt4 => 'قناع الذهب (برقع)';

  @override
  String get q_gc_030_text => 'ماذا ترمز ألوان أعلام الخليج (الأحمر، الأبيض، الأخضر، الأسود)؟';

  @override
  String get q_gc_030_opt1 => 'الوحدة العربية والشجاعة';

  @override
  String get q_gc_030_opt2 => 'الطبيعة والسلام';

  @override
  String get q_gc_030_opt3 => 'الحداثة';

  @override
  String get q_gc_030_opt4 => 'التجارة والثقافة';

  @override
  String get q_mv_001_text => 'أي مسلسل خليجي اشتهر بمقاطعه الكوميدية خلال رمضان؟';

  @override
  String get q_mv_001_opt1 => 'طاش ما طاش';

  @override
  String get q_mv_001_opt2 => 'سيلفي';

  @override
  String get q_mv_001_opt3 => 'شباب البومب';

  @override
  String get q_mv_001_opt4 => 'جميع ما سبق';

  @override
  String get q_mv_002_text => 'من هو المعروف بلقب \"أب المسرح الكويتي\"؟';

  @override
  String get q_mv_002_opt1 => 'عبدالحسين عبدالرضا';

  @override
  String get q_mv_002_opt2 => 'سعد الفرج';

  @override
  String get q_mv_002_opt3 => 'نايف الرضوان';

  @override
  String get q_mv_002_opt4 => 'حياة الفهد';

  @override
  String get q_mv_003_text => 'أي دولة أنتجت المسلسل الشهير \"طاش ما طاش\"؟';

  @override
  String get q_mv_003_opt1 => 'المملكة العربية السعودية';

  @override
  String get q_mv_003_opt2 => 'الكويت';

  @override
  String get q_mv_003_opt3 => 'الإمارات العربية المتحدة';

  @override
  String get q_mv_003_opt4 => 'البحرين';

  @override
  String get q_mv_004_text => 'أي دولة عربية تُعرف بصناعة السينما باسم \"هوليوود الشرق الأوسط\"؟';

  @override
  String get q_mv_004_opt1 => 'مصر';

  @override
  String get q_mv_004_opt2 => 'لبنان';

  @override
  String get q_mv_004_opt3 => 'الأردن';

  @override
  String get q_mv_004_opt4 => 'الإمارات';

  @override
  String get q_mv_005_text => 'من هي الممثلة التي تُعد من أساطير الدراما الكويتية؟';

  @override
  String get q_mv_005_opt1 => 'حياة الفهد';

  @override
  String get q_mv_005_opt2 => 'سعاد عبدالله';

  @override
  String get q_mv_005_opt3 => 'هيا عبدالسلام';

  @override
  String get q_mv_005_opt4 => 'منى شداد';

  @override
  String get q_mv_006_text => 'أي دولة خليجية تنتج سنويًا دراما رمضانية؟';

  @override
  String get q_mv_006_opt1 => 'الكويت';

  @override
  String get q_mv_006_opt2 => 'عُمان';

  @override
  String get q_mv_006_opt3 => 'البحرين';

  @override
  String get q_mv_006_opt4 => 'اليمن';

  @override
  String get q_mv_007_text => 'بأي لهجة تُصور أغلب المسلسلات الخليجية؟';

  @override
  String get q_mv_007_opt1 => 'اللهجة الخليجية';

  @override
  String get q_mv_007_opt2 => 'الإنجليزية';

  @override
  String get q_mv_007_opt3 => 'اللهجة المصرية';

  @override
  String get q_mv_007_opt4 => 'الفرنسية';

  @override
  String get q_mv_008_text => 'ما اسم البرنامج الكوميدي الإماراتي الشهير الذي يصور الحياة اليومية؟';

  @override
  String get q_mv_008_opt1 => 'فريج';

  @override
  String get q_mv_008_opt2 => 'طاش ما طاش';

  @override
  String get q_mv_008_opt3 => 'الدوري';

  @override
  String get q_mv_008_opt4 => 'سيلفي';

  @override
  String get q_mv_009_text => 'أي مسلسل يعرض التقاليد الخليجية القديمة بطريقة كوميدية؟';

  @override
  String get q_mv_009_opt1 => 'درب الزلق';

  @override
  String get q_mv_009_opt2 => 'فريج';

  @override
  String get q_mv_009_opt3 => 'سيلفي';

  @override
  String get q_mv_009_opt4 => 'شعبية الكرتون';

  @override
  String get q_mv_010_text => 'من الذي جسد دور \"حسن\" في مسلسل \"درب الزلق\"؟';

  @override
  String get q_mv_010_opt1 => 'عبدالحسين عبدالرضا';

  @override
  String get q_mv_010_opt2 => 'سعد الفرج';

  @override
  String get q_mv_010_opt3 => 'خالد النفيسي';

  @override
  String get q_mv_010_opt4 => 'علي المفيدي';

  @override
  String get q_mv_011_text => 'ما هو الموضوع الرئيسي لمسلسل \"باب الحارة\" السوري؟';

  @override
  String get q_mv_011_opt1 => 'الحياة في دمشق القديمة';

  @override
  String get q_mv_011_opt2 => 'حل الجرائم';

  @override
  String get q_mv_011_opt3 => 'الخيال العلمي';

  @override
  String get q_mv_011_opt4 => 'الكوميديا';

  @override
  String get q_mv_012_text => 'أي ممثل خليجي شارك في مسلسل \"سيلفي\" المعروف بالطرح الاجتماعي الساخر؟';

  @override
  String get q_mv_012_opt1 => 'ناصر القصبي';

  @override
  String get q_mv_012_opt2 => 'عبدالحسين عبدالرضا';

  @override
  String get q_mv_012_opt3 => 'طارق العلي';

  @override
  String get q_mv_012_opt4 => 'سعد الفرج';

  @override
  String get q_mv_013_text => 'من هي الممثلة الكويتية المعروفة بلقب \"ملكة الدراما\"؟';

  @override
  String get q_mv_013_opt1 => 'حياة الفهد';

  @override
  String get q_mv_013_opt2 => 'سعاد عبدالله';

  @override
  String get q_mv_013_opt3 => 'هيا عبدالسلام';

  @override
  String get q_mv_013_opt4 => 'ليلى عبدالله';

  @override
  String get q_mv_014_text => 'في أي شهر تستمتع العائلات الخليجية عادة بإصدارات الدراما الجديدة؟';

  @override
  String get q_mv_014_opt1 => 'رمضان';

  @override
  String get q_mv_014_opt2 => 'يناير';

  @override
  String get q_mv_014_opt3 => 'يونيو';

  @override
  String get q_mv_014_opt4 => 'ديسمبر';

  @override
  String get q_mv_015_text => 'أي مطرب عربي شارك في فيلم \"الرسالة\"؟';

  @override
  String get q_mv_015_opt1 => 'عبدالله الرويشد';

  @override
  String get q_mv_015_opt2 => 'عمر الشريف';

  @override
  String get q_mv_015_opt3 => 'محمد عبده';

  @override
  String get q_mv_015_opt4 => 'مصطفى العقاد';

  @override
  String get q_mv_016_text => 'أي مسلسل إماراتي كرتوني يحتفي بالحياة التقليدية وصداقة النساء؟';

  @override
  String get q_mv_016_opt1 => 'فريج';

  @override
  String get q_mv_016_opt2 => 'شعبية الكرتون';

  @override
  String get q_mv_016_opt3 => 'قناة الأطفال';

  @override
  String get q_mv_016_opt4 => 'طاش ما طاش';

  @override
  String get q_mv_017_text => 'أي مسلسل خليجي كان من أوائل الأعمال التي ناقشت القضايا الاجتماعية بصراحة؟';

  @override
  String get q_mv_017_opt1 => 'سيلفي';

  @override
  String get q_mv_017_opt2 => 'طاش ما طاش';

  @override
  String get q_mv_017_opt3 => 'شباب البومب';

  @override
  String get q_mv_017_opt4 => 'حب وحد';

  @override
  String get q_mv_018_text => 'من هو الممثل المصري الشهير بدوره في فيلم \"عمارة يعقوبيان\"؟';

  @override
  String get q_mv_018_opt1 => 'عادل إمام';

  @override
  String get q_mv_018_opt2 => 'أحمد حلمي';

  @override
  String get q_mv_018_opt3 => 'عمرو دياب';

  @override
  String get q_mv_018_opt4 => 'محمد رمضان';

  @override
  String get q_mv_019_text => 'ما هو الموضوع المشترك في الدراما العائلية الخليجية؟';

  @override
  String get q_mv_019_opt1 => 'التقاليد والقيم الأسرية';

  @override
  String get q_mv_019_opt2 => 'عوالم الخيال';

  @override
  String get q_mv_019_opt3 => 'مشاهد الأكشن';

  @override
  String get q_mv_019_opt4 => 'الخيال العلمي';

  @override
  String get q_mv_020_text => 'أي ممثل خليجي معروف بأدواره الكوميدية وأعماله المسرحية؟';

  @override
  String get q_mv_020_opt1 => 'طارق العلي';

  @override
  String get q_mv_020_opt2 => 'سعد الفرج';

  @override
  String get q_mv_020_opt3 => 'ناصر القصبي';

  @override
  String get q_mv_020_opt4 => 'حياة الفهد';

  @override
  String get q_mv_021_text => 'ما هو أول مسلسل كويتي تم إنتاجه بالألوان؟';

  @override
  String get q_mv_021_opt1 => 'درب الزلق';

  @override
  String get q_mv_021_opt2 => 'العاصوف';

  @override
  String get q_mv_021_opt3 => 'الطريق الطويل';

  @override
  String get q_mv_021_opt4 => 'بيت الطوا';

  @override
  String get q_mv_022_text => 'أي مخرج خليجي معروف بدمج القصص الحديثة مع التراث؟';

  @override
  String get q_mv_022_opt1 => 'سعود الخلف';

  @override
  String get q_mv_022_opt2 => 'علي الكندري';

  @override
  String get q_mv_022_opt3 => 'حمد الحميد';

  @override
  String get q_mv_022_opt4 => 'فهد المفرج';

  @override
  String get q_mv_023_text => 'أي قناة عربية معروفة بعرض مسلسلات رمضان الجديدة؟';

  @override
  String get q_mv_023_opt1 => 'MBC';

  @override
  String get q_mv_023_opt2 => 'تلفزيون دبي';

  @override
  String get q_mv_023_opt3 => 'الجزيرة';

  @override
  String get q_mv_023_opt4 => 'روتانا سينما';

  @override
  String get q_mv_024_text => 'أي فيلم كويتي رُشح في مهرجانات دولية كأفضل فيلم قصير؟';

  @override
  String get q_mv_024_opt1 => 'البطيخ';

  @override
  String get q_mv_024_opt2 => 'المتسلل';

  @override
  String get q_mv_024_opt3 => 'بين الرمال والبحر';

  @override
  String get q_mv_024_opt4 => 'حب أول';

  @override
  String get q_mv_025_text => 'ما هو أول فيلم خليجي عُرض في مهرجان كان السينمائي؟';

  @override
  String get q_mv_025_opt1 => 'مدينة الحياة';

  @override
  String get q_mv_025_opt2 => 'رسائل إلى فلسطين';

  @override
  String get q_mv_025_opt3 => 'وجدة';

  @override
  String get q_mv_025_opt4 => 'ظل البحر';

  @override
  String get q_mv_026_text => 'أي فيلم سعودي صنع التاريخ كأول فيلم من إخراج امرأة؟';

  @override
  String get q_mv_026_opt1 => 'وجدة';

  @override
  String get q_mv_026_opt2 => 'بركة يقابل بركة';

  @override
  String get q_mv_026_opt3 => 'المرشحة المثالية';

  @override
  String get q_mv_026_opt4 => 'ميزان';

  @override
  String get q_mv_027_text => 'أي ممثل خليجي يُلقب بـ\"أستاذ الكوميديا\"؟';

  @override
  String get q_mv_027_opt1 => 'عبدالحسين عبدالرضا';

  @override
  String get q_mv_027_opt2 => 'طارق العلي';

  @override
  String get q_mv_027_opt3 => 'ناصر القصبي';

  @override
  String get q_mv_027_opt4 => 'حياة الفهد';

  @override
  String get q_mv_028_text => 'أي فيلم إماراتي روى قصة صداقة بين الأجيال؟';

  @override
  String get q_mv_028_opt1 => 'ظل البحر';

  @override
  String get q_mv_028_opt2 => 'مدينة الحياة';

  @override
  String get q_mv_028_opt3 => 'الحالم';

  @override
  String get q_mv_028_opt4 => 'الغواص';

  @override
  String get q_mv_029_text => 'أي مسلسل سعودي تناول حياة العائلات خلال الطفرة النفطية في السبعينات؟';

  @override
  String get q_mv_029_opt1 => 'العاصوف';

  @override
  String get q_mv_029_opt2 => 'سيلفي';

  @override
  String get q_mv_029_opt3 => 'شباب البومب';

  @override
  String get q_mv_029_opt4 => 'حب وحد';

  @override
  String get q_mv_030_text => 'من هو الممثل الكوميدي المصري المعروف بلقب \"الزعيم\"؟';

  @override
  String get q_mv_030_opt1 => 'عادل إمام';

  @override
  String get q_mv_030_opt2 => 'محمد هنيدي';

  @override
  String get q_mv_030_opt3 => 'أحمد مكي';

  @override
  String get q_mv_030_opt4 => 'عمر الشريف';

  @override
  String get q_mu_001_text => 'من هو المعروف بلقب \"فنان العرب\"؟';

  @override
  String get q_mu_001_opt1 => 'محمد عبده';

  @override
  String get q_mu_001_opt2 => 'راشد الماجد';

  @override
  String get q_mu_001_opt3 => 'عبدالله الرويشد';

  @override
  String get q_mu_001_opt4 => 'كاظم الساهر';

  @override
  String get q_mu_002_text => 'أي مطرب كويتي اشتهر بأغنية \"يا طير الحب\"؟';

  @override
  String get q_mu_002_opt1 => 'عبدالله الرويشد';

  @override
  String get q_mu_002_opt2 => 'نبيل شعيل';

  @override
  String get q_mu_002_opt3 => 'راشد الماجد';

  @override
  String get q_mu_002_opt4 => 'طلال مداح';

  @override
  String get q_mu_003_text => 'ما هي الآلة الموسيقية الشائعة في الموسيقى الخليجية التقليدية؟';

  @override
  String get q_mu_003_opt1 => 'العود';

  @override
  String get q_mu_003_opt2 => 'الغيتار';

  @override
  String get q_mu_003_opt3 => 'البيانو';

  @override
  String get q_mu_003_opt4 => 'الكمان';

  @override
  String get q_mu_004_text => 'أي مطرب سعودي غنى أغنية \"الأماكن\"؟';

  @override
  String get q_mu_004_opt1 => 'محمد عبده';

  @override
  String get q_mu_004_opt2 => 'عبدالمجيد عبدالله';

  @override
  String get q_mu_004_opt3 => 'راشد الماجد';

  @override
  String get q_mu_004_opt4 => 'نبيل شعيل';

  @override
  String get q_mu_005_text => 'أي مطرب إماراتي اشتهر بأغنية \"أحبك\"؟';

  @override
  String get q_mu_005_opt1 => 'حسين الجسمي';

  @override
  String get q_mu_005_opt2 => 'بلقيس فتحي';

  @override
  String get q_mu_005_opt3 => 'فهد الكبيسي';

  @override
  String get q_mu_005_opt4 => 'عبدالمجيد عبدالله';

  @override
  String get q_mu_006_text => 'أي نوع موسيقي يتضمن الطبول والتصفيق الإيقاعي في الأعراس؟';

  @override
  String get q_mu_006_opt1 => 'الليوة';

  @override
  String get q_mu_006_opt2 => 'الهيب هوب';

  @override
  String get q_mu_006_opt3 => 'الجاز';

  @override
  String get q_mu_006_opt4 => 'التكنو';

  @override
  String get q_mu_007_text => 'من أي دولة ينحدر الفنان راشد الماجد؟';

  @override
  String get q_mu_007_opt1 => 'المملكة العربية السعودية';

  @override
  String get q_mu_007_opt2 => 'الكويت';

  @override
  String get q_mu_007_opt3 => 'قطر';

  @override
  String get q_mu_007_opt4 => 'الإمارات العربية المتحدة';

  @override
  String get q_mu_008_text => 'أي مطرب إماراتي اشتهر بأغنية \"بشرة خير\"؟';

  @override
  String get q_mu_008_opt1 => 'حسين الجسمي';

  @override
  String get q_mu_008_opt2 => 'ماجد المهندس';

  @override
  String get q_mu_008_opt3 => 'عبدالمجيد عبدالله';

  @override
  String get q_mu_008_opt4 => 'بلقيس فتحي';

  @override
  String get q_mu_009_text => 'ما هو الرقص التقليدي المصحوب بالطبول في الأعراس الخليجية؟';

  @override
  String get q_mu_009_opt1 => 'العرضة';

  @override
  String get q_mu_009_opt2 => 'السامبا';

  @override
  String get q_mu_009_opt3 => 'الباليه';

  @override
  String get q_mu_009_opt4 => 'السالسا';

  @override
  String get q_mu_010_text => 'أي فنان كويتي يُعرف بلقب \"صوت الكويت\"؟';

  @override
  String get q_mu_010_opt1 => 'نبيل شعيل';

  @override
  String get q_mu_010_opt2 => 'عبدالله الرويشد';

  @override
  String get q_mu_010_opt3 => 'بدر الشعيبي';

  @override
  String get q_mu_010_opt4 => 'راشد الماجد';

  @override
  String get q_mu_011_text => 'أي فنان عراقي يُعرف بلقب \"قيصر الأغنية العربية\"؟';

  @override
  String get q_mu_011_opt1 => 'كاظم الساهر';

  @override
  String get q_mu_011_opt2 => 'ماجد المهندس';

  @override
  String get q_mu_011_opt3 => 'صابر الرباعي';

  @override
  String get q_mu_011_opt4 => 'عمرو دياب';

  @override
  String get q_mu_012_text => 'أي مطرب سعودي معروف بأغنية \"يا طيب القلب\"؟';

  @override
  String get q_mu_012_opt1 => 'عبدالمجيد عبدالله';

  @override
  String get q_mu_012_opt2 => 'محمد عبده';

  @override
  String get q_mu_012_opt3 => 'ماجد المهندس';

  @override
  String get q_mu_012_opt4 => 'راشد الماجد';

  @override
  String get q_mu_013_text => 'من هي المطربة الإماراتية ابنة الفنان أحمد فتحي؟';

  @override
  String get q_mu_013_opt1 => 'بلقيس فتحي';

  @override
  String get q_mu_013_opt2 => 'أحلام الشامسي';

  @override
  String get q_mu_013_opt3 => 'ديانا حداد';

  @override
  String get q_mu_013_opt4 => 'شما حمدان';

  @override
  String get q_mu_014_text => 'أي مطرب مصري اشتهر بأغنية \"تملي معاك\"؟';

  @override
  String get q_mu_014_opt1 => 'عمرو دياب';

  @override
  String get q_mu_014_opt2 => 'تامر حسني';

  @override
  String get q_mu_014_opt3 => 'محمد حماقي';

  @override
  String get q_mu_014_opt4 => 'رامي صبري';

  @override
  String get q_mu_015_text => 'أي آلة موسيقية خليجية تصدر أصواتًا طبولية عميقة؟';

  @override
  String get q_mu_015_opt1 => 'المرواس';

  @override
  String get q_mu_015_opt2 => 'الطبلة';

  @override
  String get q_mu_015_opt3 => 'الدف';

  @override
  String get q_mu_015_opt4 => 'الكاجون';

  @override
  String get q_mu_016_text => 'أي مطربة لبنانية اشتهرت بأغنية \"يا طبطب\"؟';

  @override
  String get q_mu_016_opt1 => 'نانسي عجرم';

  @override
  String get q_mu_016_opt2 => 'إليسا';

  @override
  String get q_mu_016_opt3 => 'هيفاء وهبي';

  @override
  String get q_mu_016_opt4 => 'ميريام فارس';

  @override
  String get q_mu_017_text => 'أي فنان خليجي غنى في افتتاح إكسبو 2020 دبي؟';

  @override
  String get q_mu_017_opt1 => 'أحلام الشامسي';

  @override
  String get q_mu_017_opt2 => 'حسين الجسمي';

  @override
  String get q_mu_017_opt3 => 'بلقيس فتحي';

  @override
  String get q_mu_017_opt4 => 'راشد الماجد';

  @override
  String get q_mu_018_text => 'أي موسيقي سعودي معروف بدمجه بين البوب والإيقاعات التقليدية؟';

  @override
  String get q_mu_018_opt1 => 'عبدالمجيد عبدالله';

  @override
  String get q_mu_018_opt2 => 'طارق الحربي';

  @override
  String get q_mu_018_opt3 => 'راشد الماجد';

  @override
  String get q_mu_018_opt4 => 'طلال مداح';

  @override
  String get q_mu_019_text => 'أي مطربة خليجية تُعرف بلقب \"ملكة المسرح\"؟';

  @override
  String get q_mu_019_opt1 => 'أحلام الشامسي';

  @override
  String get q_mu_019_opt2 => 'بلقيس فتحي';

  @override
  String get q_mu_019_opt3 => 'ديانا حداد';

  @override
  String get q_mu_019_opt4 => 'شما حمدان';

  @override
  String get q_mu_020_text => 'أي أغنية عربية أصبحت عالمية بكلمة \"حبيبي\"؟';

  @override
  String get q_mu_020_opt1 => 'حبيبي يا نور العين';

  @override
  String get q_mu_020_opt2 => 'يا طبطب';

  @override
  String get q_mu_020_opt3 => 'أحبك';

  @override
  String get q_mu_020_opt4 => 'تملي معاك';

  @override
  String get q_mu_021_text => 'من كتب النشيد الوطني السعودي؟';

  @override
  String get q_mu_021_opt1 => 'إبراهيم خفاجي';

  @override
  String get q_mu_021_opt2 => 'طلال مداح';

  @override
  String get q_mu_021_opt3 => 'عبدالرحمن الخطيب';

  @override
  String get q_mu_021_opt4 => 'عبدالمجيد عبدالله';

  @override
  String get q_mu_022_text => 'أي ملحن كويتي ساهم في تشكيل هوية الموسيقى الخليجية؟';

  @override
  String get q_mu_022_opt1 => 'أحمد باقر';

  @override
  String get q_mu_022_opt2 => 'بدر الشعيبي';

  @override
  String get q_mu_022_opt3 => 'محمد شمس';

  @override
  String get q_mu_022_opt4 => 'نبيل شعيل';

  @override
  String get q_mu_023_text => 'أي مطرب خليجي لُقب بـ\"صوت الجزيرة الذهبي\"؟';

  @override
  String get q_mu_023_opt1 => 'طلال مداح';

  @override
  String get q_mu_023_opt2 => 'محمد عبده';

  @override
  String get q_mu_023_opt3 => 'عبدالمجيد عبدالله';

  @override
  String get q_mu_023_opt4 => 'راشد الماجد';

  @override
  String get q_mu_024_text => 'في أي دولة يُقام مهرجان \"شتاء طنطورة\" الموسيقي؟';

  @override
  String get q_mu_024_opt1 => 'المملكة العربية السعودية';

  @override
  String get q_mu_024_opt2 => 'الكويت';

  @override
  String get q_mu_024_opt3 => 'الإمارات';

  @override
  String get q_mu_024_opt4 => 'البحرين';

  @override
  String get q_mu_025_text => 'أي نوع موسيقي يجمع بين الشعر والإيقاع في التراث الخليجي؟';

  @override
  String get q_mu_025_opt1 => 'السامري';

  @override
  String get q_mu_025_opt2 => 'العرضة';

  @override
  String get q_mu_025_opt3 => 'الليوة';

  @override
  String get q_mu_025_opt4 => 'البوب الخليجي';

  @override
  String get q_mu_026_text => 'أي مطرب خليجي تعاون مع الفنان العالمي RedOne؟';

  @override
  String get q_mu_026_opt1 => 'أحلام الشامسي';

  @override
  String get q_mu_026_opt2 => 'بلقيس فتحي';

  @override
  String get q_mu_026_opt3 => 'راشد الماجد';

  @override
  String get q_mu_026_opt4 => 'عبدالمجيد عبدالله';

  @override
  String get q_mu_027_text => 'أي مطرب بحريني اشتهر بأغنية \"معك روح\"؟';

  @override
  String get q_mu_027_opt1 => 'حلا الترك';

  @override
  String get q_mu_027_opt2 => 'أحمد الجميري';

  @override
  String get q_mu_027_opt3 => 'عيسى قطن';

  @override
  String get q_mu_027_opt4 => 'خالد فؤاد';

  @override
  String get q_mu_028_text => 'من هي المطربة المصرية الأسطورية المعروفة بـ\"كوكب الشرق\"؟';

  @override
  String get q_mu_028_opt1 => 'أم كلثوم';

  @override
  String get q_mu_028_opt2 => 'فيروز';

  @override
  String get q_mu_028_opt3 => 'عبدالحليم حافظ';

  @override
  String get q_mu_028_opt4 => 'وردة الجزائرية';

  @override
  String get q_mu_029_text => 'أي موسيقي خليجي كان رائدًا في تطوير موسيقى البوب الخليجي الحديثة؟';

  @override
  String get q_mu_029_opt1 => 'راشد الماجد';

  @override
  String get q_mu_029_opt2 => 'طلال مداح';

  @override
  String get q_mu_029_opt3 => 'عبدالله الرويشد';

  @override
  String get q_mu_029_opt4 => 'محمد عبده';

  @override
  String get q_mu_030_text => 'من غنى الأغنية الشهيرة \"إنت عمري\"؟';

  @override
  String get q_mu_030_opt1 => 'أم كلثوم';

  @override
  String get q_mu_030_opt2 => 'فيروز';

  @override
  String get q_mu_030_opt3 => 'وردة';

  @override
  String get q_mu_030_opt4 => 'سميرة سعيد';

  @override
  String get q_fc_001_text => 'اجعل زملاءك يضحكون في أقل من 15 ثانية!';

  @override
  String get q_fc_002_text => 'تحدث مثل روبوت لمدة 20 ثانية.';

  @override
  String get q_fc_003_text => 'تصرّف مثل قطة تحاول الإمساك بضوء الليزر.';

  @override
  String get q_fc_004_text => 'قل اسمك الكامل بالعكس بأسرع ما يمكن.';

  @override
  String get q_fc_005_text => 'تظاهر بأنك مغنٍ مشهور تؤدي على المسرح.';

  @override
  String get q_fc_006_text => 'ارقص بدون موسيقى لمدة 10 ثوانٍ.';

  @override
  String get q_fc_007_text => 'قلد صوت طفل يبكي حتى يضحك الجميع.';

  @override
  String get q_fc_008_text => 'قل كلمة \"دوراك\" خمس مرات بسرعة بدون أخطاء.';

  @override
  String get q_fc_009_text => 'تظاهر أن يدك هي هاتف وتحدث مع “صديقك المفضل”.';

  @override
  String get q_fc_010_text => 'قف على قدم واحدة لمدة 10 ثوانٍ وقل الحروف الأبجدية بالعكس.';

  @override
  String get q_fc_011_text => 'قم بعشر قفزات واصدر صوتًا مضحكًا بعد كل واحدة.';

  @override
  String get q_fc_012_text => 'تصرّف مثل حيوان تختاره فريقك لمدة 15 ثانية.';

  @override
  String get q_fc_013_text => 'احتفظ بوجه مضحك لمدة 10 ثوانٍ دون أن تضحك.';

  @override
  String get q_fc_014_text => 'تظاهر بأنك عالق داخل صندوق وحاول الخروج منه.';

  @override
  String get q_fc_015_text => 'استدر ثلاث مرات ثم حاول المشي بخط مستقيم.';

  @override
  String get q_fc_016_text => 'قل كل ما تتحدث به خلال 30 ثانية على شكل أغنية.';

  @override
  String get q_fc_017_text => 'تصرّف كأنك تغسل أسنانك بالحركة البطيئة.';

  @override
  String get q_fc_018_text => 'تظاهر أنك تجري مقابلة مع زميلك كأنه نجم مشهور.';

  @override
  String get q_fc_019_text => 'اخترع حركة رقص وسمّها باسمك.';

  @override
  String get q_fc_020_text => 'احكِ قصة مدتها دقيقة واحدة باستخدام أصوات الحيوانات فقط.';

  @override
  String get q_fc_021_text => 'وازن شيئًا على رأسك لمدة 20 ثانية دون أن يسقط.';

  @override
  String get q_fc_022_text => 'قم بعشر تمرينات ضغط بينما يشجعك فريقك.';

  @override
  String get q_fc_023_text => 'تصرّف كأنك مذيع يقدم خبرًا عاجلاً عن فريقك.';

  @override
  String get q_fc_024_text => 'قلد ضحكة زميلك حتى يضحك الجميع.';

  @override
  String get q_fc_025_text => 'قل لسانك خمس مرات بشكل صحيح: “هي تبيع أصداف البحر على الشاطئ.”';

  @override
  String get q_fc_026_text => 'اخترع إعلانًا لمنتج خيالي (مثل “الأحذية غير المرئية”).';

  @override
  String get q_fc_027_text => 'تظاهر بأنك طاهٍ يعلّم طريقة طبخ “حساء الهواء”.';

  @override
  String get q_fc_028_text => 'استدر في دائرة وأنت تغني أغنيتك المفضلة.';

  @override
  String get q_fc_029_text => 'مرر الهاتف إلى لاعب آخر أثناء التصفيق بإيقاع.';

  @override
  String get q_fc_030_text => 'قم بأفضل تقليد لشرير فيلم مشهور لمدة 20 ثانية.';

  @override
  String get q_kc_001_text => 'ما لون السماء في يوم صافٍ مشمس؟';

  @override
  String get q_kc_001_opt1 => 'أزرق';

  @override
  String get q_kc_001_opt2 => 'أخضر';

  @override
  String get q_kc_001_opt3 => 'أحمر';

  @override
  String get q_kc_001_opt4 => 'أرجواني';

  @override
  String get q_kc_002_text => 'كم عدد أرجل القطة؟';

  @override
  String get q_kc_002_opt1 => 'أربع';

  @override
  String get q_kc_002_opt2 => 'اثنتان';

  @override
  String get q_kc_002_opt3 => 'ست';

  @override
  String get q_kc_002_opt4 => 'ثمانٍ';

  @override
  String get q_kc_003_text => 'أي حيوان يقول \'موو\'؟';

  @override
  String get q_kc_003_opt1 => 'بقرة';

  @override
  String get q_kc_003_opt2 => 'كلب';

  @override
  String get q_kc_003_opt3 => 'خروف';

  @override
  String get q_kc_003_opt4 => 'قطة';

  @override
  String get q_kc_004_text => 'ماذا تصنع النحلة؟';

  @override
  String get q_kc_004_opt1 => 'عسل';

  @override
  String get q_kc_004_opt2 => 'حليب';

  @override
  String get q_kc_004_opt3 => 'زبدة';

  @override
  String get q_kc_004_opt4 => 'عصير';

  @override
  String get q_kc_005_text => 'كم يساوي ٢ + ٣؟';

  @override
  String get q_kc_005_opt1 => '٤';

  @override
  String get q_kc_005_opt2 => '٥';

  @override
  String get q_kc_005_opt3 => '٦';

  @override
  String get q_kc_005_opt4 => '٣';

  @override
  String get q_kc_006_text => 'أي فاكهة تبعد الطبيب إذا أكلتها يوميًا؟';

  @override
  String get q_kc_006_opt1 => 'تفاح';

  @override
  String get q_kc_006_opt2 => 'موز';

  @override
  String get q_kc_006_opt3 => 'برتقال';

  @override
  String get q_kc_006_opt4 => 'مانجو';

  @override
  String get q_kc_007_text => 'ما لون الموز عندما ينضج؟';

  @override
  String get q_kc_007_opt1 => 'أصفر';

  @override
  String get q_kc_007_opt2 => 'أخضر';

  @override
  String get q_kc_007_opt3 => 'أحمر';

  @override
  String get q_kc_007_opt4 => 'بني';

  @override
  String get q_kc_008_text => 'في أي كوكب نعيش؟';

  @override
  String get q_kc_008_opt1 => 'الأرض';

  @override
  String get q_kc_008_opt2 => 'المريخ';

  @override
  String get q_kc_008_opt3 => 'الزهرة';

  @override
  String get q_kc_008_opt4 => 'المشتري';

  @override
  String get q_kc_009_text => 'ماذا نسمي صغير الكلب؟';

  @override
  String get q_kc_009_opt1 => 'جرو';

  @override
  String get q_kc_009_opt2 => 'هريرة';

  @override
  String get q_kc_009_opt3 => 'شبل';

  @override
  String get q_kc_009_opt4 => 'كتكوت';

  @override
  String get q_kc_010_text => 'أي شكل له ثلاث زوايا؟';

  @override
  String get q_kc_010_opt1 => 'مثلث';

  @override
  String get q_kc_010_opt2 => 'مربع';

  @override
  String get q_kc_010_opt3 => 'دائرة';

  @override
  String get q_kc_010_opt4 => 'نجمة';

  @override
  String get q_kc_011_text => 'بماذا تحتاج النباتات لتصنع غذاءها؟';

  @override
  String get q_kc_011_opt1 => 'ضوء الشمس';

  @override
  String get q_kc_011_opt2 => 'ضوء القمر';

  @override
  String get q_kc_011_opt3 => 'الريح';

  @override
  String get q_kc_011_opt4 => 'الثلج';

  @override
  String get q_kc_012_text => 'أي حيوان يُعرف بـ\'ملك الغابة\'؟';

  @override
  String get q_kc_012_opt1 => 'الأسد';

  @override
  String get q_kc_012_opt2 => 'الفيل';

  @override
  String get q_kc_012_opt3 => 'النمر';

  @override
  String get q_kc_012_opt4 => 'الدب';

  @override
  String get q_kc_013_text => 'ماذا نسمي الشخص الذي يقود الطائرة؟';

  @override
  String get q_kc_013_opt1 => 'طيار';

  @override
  String get q_kc_013_opt2 => 'سائق';

  @override
  String get q_kc_013_opt3 => 'قبطان';

  @override
  String get q_kc_013_opt4 => 'ميكانيكي';

  @override
  String get q_kc_014_text => 'كم عدد الأيام في الأسبوع؟';

  @override
  String get q_kc_014_opt1 => '٧';

  @override
  String get q_kc_014_opt2 => '٥';

  @override
  String get q_kc_014_opt3 => '١٠';

  @override
  String get q_kc_014_opt4 => '١٢';

  @override
  String get q_kc_015_text => 'أي حيوان يمكنه العيش في الماء وعلى اليابسة؟';

  @override
  String get q_kc_015_opt1 => 'ضفدع';

  @override
  String get q_kc_015_opt2 => 'سمكة';

  @override
  String get q_kc_015_opt3 => 'كلب';

  @override
  String get q_kc_015_opt4 => 'طائر';

  @override
  String get q_kc_016_text => 'بماذا تنظف أسنانك؟';

  @override
  String get q_kc_016_opt1 => 'فرشاة أسنان';

  @override
  String get q_kc_016_opt2 => 'ملعقة';

  @override
  String get q_kc_016_opt3 => 'مشط';

  @override
  String get q_kc_016_opt4 => 'منشفة';

  @override
  String get q_kc_017_text => 'أي دولة خليجية يوجد بها برج خليفة؟';

  @override
  String get q_kc_017_opt1 => 'الإمارات';

  @override
  String get q_kc_017_opt2 => 'قطر';

  @override
  String get q_kc_017_opt3 => 'السعودية';

  @override
  String get q_kc_017_opt4 => 'البحرين';

  @override
  String get q_kc_018_text => 'ما اللون الناتج عن خلط الأزرق والأصفر؟';

  @override
  String get q_kc_018_opt1 => 'أخضر';

  @override
  String get q_kc_018_opt2 => 'أحمر';

  @override
  String get q_kc_018_opt3 => 'أرجواني';

  @override
  String get q_kc_018_opt4 => 'برتقالي';

  @override
  String get q_kc_019_text => 'ما عكس كلمة \'حار\'؟';

  @override
  String get q_kc_019_opt1 => 'بارد';

  @override
  String get q_kc_019_opt2 => 'دافئ';

  @override
  String get q_kc_019_opt3 => 'رطب';

  @override
  String get q_kc_019_opt4 => 'منعش';

  @override
  String get q_kc_020_text => 'أي فصل يأتي بعد الربيع؟';

  @override
  String get q_kc_020_opt1 => 'الصيف';

  @override
  String get q_kc_020_opt2 => 'الشتاء';

  @override
  String get q_kc_020_opt3 => 'الخريف';

  @override
  String get q_kc_020_opt4 => 'الممطر';

  @override
  String get q_kc_021_text => 'ما الغاز الذي يتنفسه الإنسان للبقاء على قيد الحياة؟';

  @override
  String get q_kc_021_opt1 => 'الأكسجين';

  @override
  String get q_kc_021_opt2 => 'ثاني أكسيد الكربون';

  @override
  String get q_kc_021_opt3 => 'النيتروجين';

  @override
  String get q_kc_021_opt4 => 'الهيدروجين';

  @override
  String get q_kc_022_text => 'أي كوكب يُعرف بالكوكب الأحمر؟';

  @override
  String get q_kc_022_opt1 => 'المريخ';

  @override
  String get q_kc_022_opt2 => 'الزهرة';

  @override
  String get q_kc_022_opt3 => 'عطارد';

  @override
  String get q_kc_022_opt4 => 'المشتري';

  @override
  String get q_kc_023_text => 'ماذا نسمي صغير البقرة؟';

  @override
  String get q_kc_023_opt1 => 'عجل';

  @override
  String get q_kc_023_opt2 => 'مهر';

  @override
  String get q_kc_023_opt3 => 'شبل';

  @override
  String get q_kc_023_opt4 => 'جرو';

  @override
  String get q_kc_024_text => 'ما هو أكبر حيوان ثديي في العالم؟';

  @override
  String get q_kc_024_opt1 => 'الحوت الأزرق';

  @override
  String get q_kc_024_opt2 => 'الفيل';

  @override
  String get q_kc_024_opt3 => 'القرش';

  @override
  String get q_kc_024_opt4 => 'الزرافة';

  @override
  String get q_kc_025_text => 'أي دولة تشتهر بصنع البيتزا؟';

  @override
  String get q_kc_025_opt1 => 'إيطاليا';

  @override
  String get q_kc_025_opt2 => 'فرنسا';

  @override
  String get q_kc_025_opt3 => 'مصر';

  @override
  String get q_kc_025_opt4 => 'اليونان';

  @override
  String get q_kc_026_text => 'أي آلة موسيقية تحتوي على مفاتيح بيضاء وسوداء؟';

  @override
  String get q_kc_026_opt1 => 'بيانو';

  @override
  String get q_kc_026_opt2 => 'طبل';

  @override
  String get q_kc_026_opt3 => 'غيتار';

  @override
  String get q_kc_026_opt4 => 'كمان';

  @override
  String get q_kc_027_text => 'ما العملية التي يتحول فيها الماء إلى بخار؟';

  @override
  String get q_kc_027_opt1 => 'تبخر';

  @override
  String get q_kc_027_opt2 => 'تكاثف';

  @override
  String get q_kc_027_opt3 => 'تجمد';

  @override
  String get q_kc_027_opt4 => 'غليان';

  @override
  String get q_kc_028_text => 'أي مدينة خليجية معروفة بجزيرة النخلة الصناعية؟';

  @override
  String get q_kc_028_opt1 => 'دبي';

  @override
  String get q_kc_028_opt2 => 'الدوحة';

  @override
  String get q_kc_028_opt3 => 'مسقط';

  @override
  String get q_kc_028_opt4 => 'المنامة';

  @override
  String get q_kc_029_text => 'ما هو أسرع حيوان على اليابسة؟';

  @override
  String get q_kc_029_opt1 => 'الفهد';

  @override
  String get q_kc_029_opt2 => 'الأسد';

  @override
  String get q_kc_029_opt3 => 'الحصان';

  @override
  String get q_kc_029_opt4 => 'الغزال';

  @override
  String get q_kc_030_text => 'ما اسم الفتحات الصغيرة في الجلد التي يخرج منها العرق؟';

  @override
  String get q_kc_030_opt1 => 'مسام';

  @override
  String get q_kc_030_opt2 => 'بقع';

  @override
  String get q_kc_030_opt3 => 'خلايا';

  @override
  String get q_kc_030_opt4 => 'غدد';

  @override
  String get q_qt_001_text => 'اذكر فاكهة لونها أصفر.';

  @override
  String get q_qt_001_opt1 => 'موز';

  @override
  String get q_qt_001_opt2 => 'ليمون';

  @override
  String get q_qt_001_opt3 => 'مانجو';

  @override
  String get q_qt_001_opt4 => 'أناناس';

  @override
  String get q_qt_002_text => 'ما اللون الناتج عند خلط الأحمر مع الأبيض؟';

  @override
  String get q_qt_002_opt1 => 'وردي';

  @override
  String get q_qt_002_opt2 => 'برتقالي';

  @override
  String get q_qt_002_opt3 => 'بني';

  @override
  String get q_qt_002_opt4 => 'بنفسجي';

  @override
  String get q_qt_003_text => 'قل كلمة “سريع” خمس مرات دون توقف!';

  @override
  String get q_qt_004_text => 'اذكر شيئًا يمكنك ارتداؤه على رأسك.';

  @override
  String get q_qt_004_opt1 => 'قبعة';

  @override
  String get q_qt_004_opt2 => 'كاب';

  @override
  String get q_qt_004_opt3 => 'وشاح';

  @override
  String get q_qt_004_opt4 => 'خوذة';

  @override
  String get q_qt_005_text => 'صفق بيديك 10 مرات بأسرع ما يمكنك!';

  @override
  String get q_qt_006_text => 'ما حاصل 10 - 3؟';

  @override
  String get q_qt_006_opt1 => '7';

  @override
  String get q_qt_006_opt2 => '6';

  @override
  String get q_qt_006_opt3 => '8';

  @override
  String get q_qt_006_opt4 => '5';

  @override
  String get q_qt_007_text => 'اكتب كلمة “GAME” بالعكس.';

  @override
  String get q_qt_008_text => 'اذكر أي حيوان يمكنه الطيران.';

  @override
  String get q_qt_008_opt1 => 'طائر';

  @override
  String get q_qt_008_opt2 => 'خفاش';

  @override
  String get q_qt_008_opt3 => 'نسر';

  @override
  String get q_qt_008_opt4 => 'فراشة';

  @override
  String get q_qt_009_text => 'اذكر أسماء 3 دول خليجية في 10 ثوانٍ!';

  @override
  String get q_qt_010_text => 'اذكر شيئًا تستخدمه كل صباح.';

  @override
  String get q_qt_010_opt1 => 'فرشاة أسنان';

  @override
  String get q_qt_010_opt2 => 'هاتف';

  @override
  String get q_qt_010_opt3 => 'منشفة';

  @override
  String get q_qt_010_opt4 => 'كل ما سبق';

  @override
  String get q_qt_011_text => 'اذكر 3 حيوانات تعيش في الماء.';

  @override
  String get q_qt_012_text => 'اذكر شيئًا دائريًا غير الكرة.';

  @override
  String get q_qt_012_opt1 => 'صحن';

  @override
  String get q_qt_012_opt2 => 'عملة';

  @override
  String get q_qt_012_opt3 => 'ساعة';

  @override
  String get q_qt_012_opt4 => 'كل ما سبق';

  @override
  String get q_qt_013_text => 'قل 5 كلمات تبدأ بحرف السين.';

  @override
  String get q_qt_014_text => 'اذكر 3 دول خليجية تبدأ بحرف متحرك.';

  @override
  String get q_qt_015_text => 'عدّ من 1 إلى 10 في أقل من 3 ثوانٍ!';

  @override
  String get q_qt_016_text => 'إذا كان لديك 5 تفاحات وأعطيت 2، كم يتبقى لديك؟';

  @override
  String get q_qt_016_opt1 => '3';

  @override
  String get q_qt_016_opt2 => '2';

  @override
  String get q_qt_016_opt3 => '5';

  @override
  String get q_qt_016_opt4 => '1';

  @override
  String get q_qt_017_text => 'اذكر 3 أشياء تعمل بالكهرباء.';

  @override
  String get q_qt_017_opt1 => 'هاتف';

  @override
  String get q_qt_017_opt2 => 'تلفاز';

  @override
  String get q_qt_017_opt3 => 'مروحة';

  @override
  String get q_qt_017_opt4 => 'كل ما سبق';

  @override
  String get q_qt_018_text => 'قل الحروف الأبجدية بدون حرف “أ”.';

  @override
  String get q_qt_019_text => 'اذكر دولة خليجية واحدة وعاصمتها.';

  @override
  String get q_qt_019_opt1 => 'الكويت – مدينة الكويت';

  @override
  String get q_qt_019_opt2 => 'الإمارات – أبوظبي';

  @override
  String get q_qt_019_opt3 => 'قطر – الدوحة';

  @override
  String get q_qt_019_opt4 => 'كل ما سبق';

  @override
  String get q_qt_020_text => 'اذكر 3 أشياء باردة.';

  @override
  String get q_qt_020_opt1 => 'ثلج';

  @override
  String get q_qt_020_opt2 => 'جليد';

  @override
  String get q_qt_020_opt3 => 'عصير';

  @override
  String get q_qt_020_opt4 => 'كل ما سبق';

  @override
  String get q_qt_021_text => 'اذكر 5 فواكه في 10 ثوانٍ!';

  @override
  String get q_qt_022_text => 'قل كلمة “موز” بالعكس دون توقف.';

  @override
  String get q_qt_023_text => 'اذكر شيئًا يُعتبر طعامًا ولونًا في الوقت نفسه.';

  @override
  String get q_qt_023_opt1 => 'برتقالي';

  @override
  String get q_qt_023_opt2 => 'خوخي';

  @override
  String get q_qt_023_opt3 => 'ليموني';

  @override
  String get q_qt_023_opt4 => 'كل ما سبق';

  @override
  String get q_qt_024_text => 'قل 5 مدن خليجية بأسرع ما يمكنك.';

  @override
  String get q_qt_025_text => 'اذكر 3 أشياء يمكن أن تذوب.';

  @override
  String get q_qt_025_opt1 => 'ثلج';

  @override
  String get q_qt_025_opt2 => 'شوكولاتة';

  @override
  String get q_qt_025_opt3 => 'زبدة';

  @override
  String get q_qt_025_opt4 => 'كل ما سبق';

  @override
  String get q_qt_026_text => 'إذا أعدت ترتيب حروف “DORAK”، ما الكلمة الجديدة التي يمكنك تكوينها؟';

  @override
  String get q_qt_026_opt1 => 'طريق (Road)';

  @override
  String get q_qt_026_opt2 => 'ظلام (Dark)';

  @override
  String get q_qt_026_opt3 => 'رادكو (Radko)';

  @override
  String get q_qt_026_opt4 => 'لا شيء';

  @override
  String get q_qt_027_text => 'قل كلمة تُقافي كلمة “Game”.';

  @override
  String get q_qt_027_opt1 => 'Name';

  @override
  String get q_qt_027_opt2 => 'Same';

  @override
  String get q_qt_027_opt3 => 'Flame';

  @override
  String get q_qt_027_opt4 => 'كل ما سبق';

  @override
  String get q_qt_028_text => 'اذكر 3 أشياء تأخذها إلى الشاطئ.';

  @override
  String get q_qt_028_opt1 => 'منشفة';

  @override
  String get q_qt_028_opt2 => 'كريم واقٍ من الشمس';

  @override
  String get q_qt_028_opt3 => 'ماء';

  @override
  String get q_qt_028_opt4 => 'كل ما سبق';

  @override
  String get q_qt_029_text => 'اذكر شهر ميلادك واسم حيوان يبدأ بنفس الحرف.';

  @override
  String get q_qt_030_text => 'اكتب كلمة “challenge” بشكل صحيح — ولكن بسرعة!';
}
