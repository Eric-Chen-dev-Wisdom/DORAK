import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'services/navigation_service.dart';
import 'utils/routes.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/lobby_screen.dart';
import 'models/user_model.dart';

void main() {
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
        // Handle routes with arguments
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
          default:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      },
    );
  }
}