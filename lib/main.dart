import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'services/guest_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize guest service
  GuestService.initialize().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DORAK Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}