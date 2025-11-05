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
// firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🟡 Show app immediately
  runApp(const DorakApp());

  // 🟢 Initialize Firebase in background
  try {
    await FirebaseInit.initialize();
    print('✅ Firebase initialized successfully.');
  } catch (e) {
    print('❌ Firebase initialization failed: $e');
  }
}

class DorakApp extends StatelessWidget {
  const DorakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DORAK - Family Game',
      theme: AppTheme.lightTheme,
      navigatorKey: NavigationService.navigatorKey,
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
        print('🟡 Navigating to: ${settings.name}');

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
            print('❌ Invalid arguments for Lobby Guest route');
            return MaterialPageRoute(builder: (_) => const HomeScreen());

          case AppRoutes.lobby:
            if (settings.arguments is UserModel) {
              final user = settings.arguments as UserModel;
              return MaterialPageRoute(
                builder: (_) => LobbyScreen(user: user),
              );
            }
            print('❌ Invalid arguments for Lobby route');
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
            print('❌ Invalid arguments for Game route');
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
            print('❌ Invalid arguments for Category Selection route');
            return MaterialPageRoute(builder: (_) => const HomeScreen());

          default:
            print('❌ Unknown route: ${settings.name}');
            return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      },

      onUnknownRoute: (settings) {
        print('❌ Unknown route: ${settings.name}');
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      },

      debugShowCheckedModeBanner: false,
    );
  }
}
