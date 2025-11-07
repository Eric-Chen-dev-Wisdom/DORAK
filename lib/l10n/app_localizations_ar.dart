// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get nicknameLabel => 'اللاعب الضيف';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get createNewRoom => 'إنشاء حساب';

  @override
  String get continueGuest => 'العب كضيف';

  @override
  String get welcome => 'مرحبًا بك في دوراك!';

  @override
  String get selectCategories => 'اختر الفئات';

  @override
  String get selectCategoriesHint => 'اختر من 5 إلى 8 فئات لبدء اللعبة';

  @override
  String get difficulty => 'مستوى الصعوبة';

  @override
  String get numberOfQuestions => 'عدد الأسئلة';

  @override
  String get startGame => 'ابدأ اللعبة';

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
}
