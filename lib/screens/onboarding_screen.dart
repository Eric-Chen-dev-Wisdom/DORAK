import 'package:flutter/material.dart';
import 'lobby_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
            // BUTTON SECTION
            const Spacer(), // This pushes buttons to the bottom
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LobbyScreen(),
                          ),
                        );
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
                  SizedBox(
                    width: 350,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        print('Create account pressed');
                      },
                      child: const Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4F46E5),
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
