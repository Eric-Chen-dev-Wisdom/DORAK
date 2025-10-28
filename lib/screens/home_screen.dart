import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../services/auth_service.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              const SizedBox(height: 40),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppConstants.primaryRed,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.casino, color: Colors.white, size: 50),
              ),
              const SizedBox(height: 20),
              
              // Updated Logo Section
              Stack(
                alignment: Alignment.center,
                children: [
                  // Arabic text with exclamation mark on the left
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '!',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.primaryBlack,
                        ),
                      ),
                      Text(
                        'دورك',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.primaryBlack,
                        ),
                      ),
                    ],
                  ),
                  
                  // English text positioned as shadow below
                  Positioned(
                    bottom: -30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Dorak',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 50), // Increased spacing for the shadow text
              
              // Tagline
              const Text(
                'لِصةِ للطائفةِ والأكصدِفَاءِ\nA game that brings together family and friends',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppConstants.textColor,
                ),
              ),
              
              // Spacer
              const Spacer(),
              
              // Action Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        NavigationService.navigateTo(AppRoutes.login);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Start Playing',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
  final authService = AuthService();
  final user = await authService.guestLogin('Guest Player');
  NavigationService.navigateTo(
    AppRoutes.lobby,
    arguments: user,
  );
},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppConstants.primaryRed,
                        side: const BorderSide(color: Color(0xFFCE1126)),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text(
                        'Play as Guest',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}