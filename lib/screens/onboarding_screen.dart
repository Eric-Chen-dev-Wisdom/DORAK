import 'package:flutter/material.dart';
import 'lobby_screen.dart';
import '../services/guest_service.dart';
import '../services/auth_service.dart';
import '../services/auth_state.dart';
import 'signup_screen.dart';
import 'login_screen.dart'; 

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER SECTION
            const SizedBox(height: 60),
            const Icon(Icons.celebration, size: 80, color: Color(0xFF4F46E5)),
            const SizedBox(height: 20),
            const Text(
              'DORAK',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Family Fun Game',
              style: TextStyle(fontSize: 18, color: Color(0xFF718096)),
            ),
            const SizedBox(height: 40),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAFC),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
              ),
              child: const Icon(
                Icons.family_restroom,
                size: 80,
                color: Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 30),

            // TAGLINE SECTION
            const Text(
              '"Laughter, Connection, Challenge"',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A5568),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            // CENTERED BUTTON SECTION
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // PLAY AS GUEST BUTTON
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Show loading
                        _showLoadingDialog(
                          context,
                          "Creating guest session...",
                        );

                        try {
                          // Use AuthService for guest login
                          final success = await AuthService.guestLogin();

                          Navigator.pop(context); // Hide loading

                          if (success) {
                            // Update auth state
                            AuthState.guestLogin();

                            // Go to lobby
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LobbyScreen(),
                              ),
                            );
                          }
                        } catch (e) {
                          Navigator.pop(context); // Hide loading
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Guest login failed: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'PLAY AS GUEST',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // CREATE ACCOUNT BUTTON
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Color(0xFF4F46E5)),
                      ),
                      child: const Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4F46E5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // SIGN IN BUTTON - FIXED!
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ), // ← CHANGED TO LoginScreen
                        );
                      },
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4A5568),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
