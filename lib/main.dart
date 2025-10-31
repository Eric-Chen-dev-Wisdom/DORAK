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
  
  try {
    // Initialize Firebase using firebase_init
    print('🟡 Initializing Firebase...');
    await FirebaseInit.initialize();
    print('✅ Firebase initialized successfully');
    
    runApp(const DorakApp());
  } catch (e) {
    print('❌ Firebase initialization failed: $e');
    
    // Fallback - run app anyway but show error screen
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 20),
              Text(
                'Firebase Initialization Failed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Error: $e',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Try to restart the app
                  runApp(const DorakApp());
                },
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    ));
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
      initialRoute: AppRoutes.home,
      
      // Define all routes explicitly
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
      },
      
      onGenerateRoute: (settings) {
        print('🟡 Navigating to: ${settings.name}');
        
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
            
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
            
          case AppRoutes.lobby:
            if (settings.arguments is UserModel) {
              final UserModel user = settings.arguments as UserModel;
              return MaterialPageRoute(
                builder: (_) => LobbyScreen(user: user),
              );
            } else {
              print('❌ Invalid arguments for Lobby route');
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            }
            
          case AppRoutes.game:
            if (settings.arguments is Map<String, dynamic>) {
              final args = settings.arguments as Map<String, dynamic>;
              if (args['room'] is GameRoom && args['user'] is UserModel && args['isHost'] is bool) {
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
      
      // Handle unknown routes
      onUnknownRoute: (settings) {
        print('❌ Unknown route: ${settings.name}');
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      },
      
      debugShowCheckedModeBanner: false,
    );
  }
}