import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Sign In'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.goBack();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              
              // Welcome Text
              const Text(
                'Welcome to DORAK!',
                style: TextStyle(
                  fontSize: AppConstants.headingSize,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign in to save your progress and compete with friends',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppConstants.bodySize,
                  color: AppConstants.textColor,
                ),
              ),
              
              const Spacer(),
              
              // Login Options
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Google Sign In - we'll implement later
                        NavigationService.navigateTo(AppRoutes.lobby);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.g_mobiledata, size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Continue with Google',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Apple Sign In - we'll implement later
                        NavigationService.navigateTo(AppRoutes.lobby);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.apple, size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Continue with Apple',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Guest login
                        NavigationService.navigateTo(AppRoutes.lobby);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppConstants.primaryRed,
                        side: const BorderSide(color: Color(0xFFCE1126)),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text(
                        'Continue as Guest',
                        style: TextStyle(fontSize: 16),
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