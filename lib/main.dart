import 'package:flutter/material.dart';
import 'services/firebase_init.dart'; 
import 'utils/app_theme.dart';
import 'services/navigation_service.dart';
import 'utils/routes.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/lobby_screen.dart';
import 'screens/category_selection_screen.dart'; 
import 'screens/game_screen.dart'; 
import 'models/user_model.dart';
import 'models/room_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase using firebase_init
  await FirebaseInit.initialize();
  
  runApp(const DorakApp());
}

class DorakApp extends StatelessWidget {
  const DorakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DORAK - Family Game',
      theme: AppTheme.lightTheme,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case AppRoutes.lobby:
            final UserModel user = settings.arguments as UserModel;
            return MaterialPageRoute(
              builder: (_) => LobbyScreen(user: user),
            );
          case AppRoutes.game: // ADD THIS ROUTE
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => GameScreen(
                room: args['room'] as GameRoom,
                user: args['user'] as UserModel,
                isHost: args['isHost'] as bool,
              ),
            );
          case '/category_selection': // ADD THIS ROUTE
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => CategorySelectionScreen(
                room: args['room'] as GameRoom,
                user: args['user'] as UserModel,
              ),
            );
          default:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      },
    );
  }
}