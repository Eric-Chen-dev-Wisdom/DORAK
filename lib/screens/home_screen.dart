import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';

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
              const Text(
                'دورك',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryBlack,
                ),
              ),
              const Text(
                'Dorak',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'A game that brings together family and friends',
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
                      onPressed: () {
                        // Guest login - we'll implement this next
                        NavigationService.navigateTo(AppRoutes.lobby);
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