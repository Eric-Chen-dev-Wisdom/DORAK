import 'package:flutter/material.dart';
import 'services/firebase_init.dart';
import 'utils/app_theme.dart';
import 'services/navigation_service.dart';
import 'utils/routes.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/lobby_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/category_selection_screen.dart';
import 'screens/game_screen.dart';
import 'screens/lobby_guest_screen.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/BoardSlideShow.dart';
import 'models/user_model.dart';
import 'models/room_model.dart';
import 'l10n/app_localizations.dart';
import 'services/locale_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🎯 FIX: Initialize Firebase BEFORE running the app
  print('● Starting Firebase initialization...');
  try {
    await FirebaseInit.initialize();
    print('✅ Firebase initialized successfully');
  } catch (e) {
    print('❌ Firebase initialization failed: $e');
    // You might want to handle this differently, but for now we'll continue
  }

  // 🎯 FIX: Load locale settings AFTER Firebase init
  await LocaleService.loadSaved();
  
  // 🎯 FIX: Run app AFTER Firebase is initialized
  runApp(const DorakApp());
}

class DorakApp extends StatelessWidget {
  const DorakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: LocaleService.locale,
      builder: (context, currentLocale, _) {
        return MaterialApp(
          title: 'DORAK - Family Game',
          theme: AppTheme.lightTheme,
          navigatorKey: NavigationService.navigatorKey,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,

          // Show onboarding slideshow first
          initialRoute: '/',

          // Define routes
          routes: {
            '/': (context) => const BoardSlideShowWidget(),
            AppRoutes.home: (context) => const HomeScreen(),
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.signup: (context) => const SignUpScreen(),
            AppRoutes.admin: (context) => const AdminDashboard(),
          },

          onGenerateRoute: (settings) {
            // ignore: avoid_print
            print('Navigating to: ${settings.name}');

            switch (settings.name) {
              case AppRoutes.home:
                return MaterialPageRoute(builder: (_) => const HomeScreen());

              case AppRoutes.login:
                return MaterialPageRoute(builder: (_) => const LoginScreen());

              case AppRoutes.lobbyGuest:
                if (settings.arguments is UserModel) {
                  final user = settings.arguments as UserModel;
                  return MaterialPageRoute(
                    builder: (_) => LobbyGuestScreen(user: user),
                  );
                }
                return MaterialPageRoute(builder: (_) => const HomeScreen());

              case AppRoutes.lobby:
                if (settings.arguments is UserModel) {
                  final user = settings.arguments as UserModel;
                  return MaterialPageRoute(
                    builder: (_) => LobbyScreen(user: user),
                  );
                }
                return MaterialPageRoute(builder: (_) => const HomeScreen());

              case AppRoutes.game:
                if (settings.arguments is Map<String, dynamic>) {
                  final args = settings.arguments as Map<String, dynamic>;
                  if (args['room'] is GameRoom &&
                      args['user'] is UserModel &&
                      args['isHost'] is bool) {
                    return MaterialPageRoute(
                      builder: (_) => GameScreen(
                        room: args['room'] as GameRoom,
                        user: args['user'] as UserModel,
                        isHost: args['isHost'] as bool,
                      ),
                    );
                  }
                }
                return MaterialPageRoute(builder: (_) => const HomeScreen());

              case AppRoutes.categorySelection:
                if (settings.arguments is Map<String, dynamic>) {
                  final args = settings.arguments as Map<String, dynamic>;
                  if (args['room'] is GameRoom && args['user'] is UserModel) {
                    return MaterialPageRoute(
                      builder: (_) => CategorySelectionScreen(
                        room: args['room'] as GameRoom,
                        user: args['user'] as UserModel,
                      ),
                    );
                  }
                }
                return MaterialPageRoute(builder: (_) => const HomeScreen());

              default:
                return MaterialPageRoute(builder: (_) => const HomeScreen());
            }
          },

          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          },

          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}