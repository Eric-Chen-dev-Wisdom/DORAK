import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/routes.dart';
import '../services/locale_service.dart';

/// if user tap the continue button the center of page slides like carousel in
class BoardSlideShowWidget extends StatefulWidget {
  const BoardSlideShowWidget({super.key});

  static String routeName = 'BoardSlideShow';
  static String routePath = 'boardSlideShow';

  @override
  State<BoardSlideShowWidget> createState() => _BoardSlideShowWidgetState();
}

class _BoardSlideShowWidgetState extends State<BoardSlideShowWidget> {
  String get _localeCode => Localizations.localeOf(context).languageCode;
  bool get isArabic => _localeCode == 'ar';
  String t(String en, String ar) => isArabic ? ar : en;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedLanguage = 'en'; // Added _selectedLanguage declaration

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    // Page 1: Welcome
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/slideshow1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        _buildPage(
                          context,
                          // icon: Icons.home_outlined,
                          title: t('Welcome to DORAK!', 'مرحبًا بك في دوراك!'),
                          description: t(
                              'A family party game inspired by Seen Jeem. Challenge your friends and family, split into teams, and answer fun questions together.',
                              'لعبة عائلية مستوحاة من سين جيم. تحدَّ أصدقاءك وعائلتك، انقسموا إلى فرق وأجيبوا على الأسئلة الممتعة معًا.'),
                          color: Colors.blue,
                          // Remove the foreground image argument
                        ),
                      ],
                    ),
                    // Page 2: Connect & Collaborate
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/slideshow2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        _buildPage(
                          context,
                          // icon: Icons.people_outline,
                          title: t('Play as a Team', 'العب كفريق'),
                          description: t(
                              'Team up with your friends and family. Work together, compete, and answer questions as a team to score points!',
                              'كوّن فريقك مع أصدقائك وعائلتك. تعاونوا وتنافسوا وأجيبوا على الأسئلة لكسب النقاط!'),
                          color: const Color.fromARGB(255, 96, 58, 202),
                        ),
                      ],
                    ),
                    // Page 3: Quality Services
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/slideshow3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        _buildPage(
                          context,
                          // icon: Icons.language, // or any suitable icon
                          title:
                              t('Easily switch language', 'بدّل اللغة بسهولة'),
                          description: t(
                              'Seamlessly toggle between Arabic and English anytime during the game from the menu.',
                              'يمكنك التبديل بسهولة بين العربية والإنجليزية في أي وقت من القائمة أثناء اللعبة.'),
                          color: const Color.fromARGB(255, 158, 57, 216),
                        ),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, left: 20, right: 20),
                                child: Text(
                                  _selectedLanguage == 'ar'
                                      ? 'اختر اللغة'
                                      : 'Choose Language',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.35),
                                        blurRadius: 8,
                                        offset: Offset(1.5, 1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, bottom: 20.0),
                                child: ToggleButtons(
                                  isSelected: [
                                    _selectedLanguage == 'en',
                                    _selectedLanguage == 'ar'
                                  ],
                                  onPressed: (index) async {
                                    setState(() {
                                      _selectedLanguage =
                                          index == 0 ? 'en' : 'ar';
                                    });
                                    await LocaleService.setLocale(
                                        Locale(_selectedLanguage));
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  selectedColor: Colors.white,
                                  fillColor: Colors.orange,
                                  color: Colors.orange,
                                  constraints: BoxConstraints(
                                    minHeight: 32,
                                    minWidth: 48,
                                  ),
                                  children: [
                                    Text('EN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('عربى',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _buildPage(
                      context,
                      title: t('Get Started', 'ابدأ الآن'),
                      description: t(
                          'Ready to begin? Start your Dorak adventure now!',
                          'جاهز للانطلاق؟ ابدأ مغامرتك مع دوراك الآن!'),
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
              // Page Indicator
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
              // Navigation Buttons
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      TextButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          t('Previous', 'السابق'),
                          style: GoogleFonts.inter(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    else
                      SizedBox(width: 80),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Navigate to main app (Home)
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.home,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _currentPage < 3
                            ? t('Continue', 'متابعة')
                            : t('Get Started', 'ابدأ الآن'),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(
    BuildContext context, {
    // required IconData icon,
    required String title,
    required String description,
    required Color color,
    // Image? image,
  }) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(0.1), Colors.white],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   width: 120,
            //   height: 120,
            //   decoration: BoxDecoration(
            //     color: color.withOpacity(0.1),
            //     shape: BoxShape.circle,
            //   ),
            //   // child: Icon(icon, size: 60, color: color),
            // ),
            SizedBox(height: 40),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 80),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
