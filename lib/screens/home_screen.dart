import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggingIn = false; // To prevent multiple presses

  Future<void> _handleGuestLogin() async {
    if (_isLoggingIn) return;
    setState(() {
      _isLoggingIn = true;
    });
    try {
      final authService = AuthService();
      final user = await authService.guestLogin('Guest Player');
      // On success, redirect to lobby page with user
      NavigationService.navigateTo(
        AppRoutes.lobby,
        arguments: user,
      );
    } catch (e) {
      // Optionally, show an error here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log in as guest: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove backgroundColor and use a background image instead
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            fit: BoxFit.fitHeight, // Fit image for width
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  // Logo Section with image
                  // Stack(
                  //   alignment: Alignment.center,
                  //   children: [
                  //     // Main logo container with image
                  //     Container(
                  //       width: 220,
                  //       height: 120,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(20),
                  //         child: Image.asset(
                  //           'assets/images/logo.png', // Your logo image
                  //           fit: BoxFit.cover,
                  //           width: double.infinity,
                  //           height: double.infinity,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Tagline
                  // const Text(
                  //   'لِصةِ للطائفةِ والأكصدِفَاءِ\nA game that brings together family and friends',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: AppConstants.textColor,
                  //   ),
                  // ),
                  const Spacer(),
                  // Carousel removed as requested

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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.primaryRed,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Create Account',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isLoggingIn ? null : _handleGuestLogin,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppConstants.primaryRed,
                            side: const BorderSide(color: Color(0xFFCE1126)),
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoggingIn
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text(
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
        ],
      ),
    );
  }
}
