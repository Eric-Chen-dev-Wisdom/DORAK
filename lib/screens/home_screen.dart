import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../services/auth_service.dart';
import 'package:DORAK/l10n/app_localizations.dart';

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
      final user = await authService.guestLogin(
        AppLocalizations.of(context)?.nicknameLabel ?? 'Guest Player',
      );
      // On success, redirect to lobby page with user
      NavigationService.navigateTo(
        AppRoutes.lobby,
        arguments: user,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.loginFailed ??
                'Failed to log in as guest: $e',
          ),
        ),
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Localized background image alternative? (this is just for illustration)
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Spacer(),
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
                            backgroundColor: Colors.transparent,
                            foregroundColor: AppConstants.primaryRed,
                            shadowColor: Colors.transparent,
                            side: const BorderSide(color: Color(0xFFCE1126)),
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
                            backgroundColor: Colors.transparent,
                            foregroundColor: AppConstants.primaryRed,
                            side: const BorderSide(color: Color(0xFFCE1126)),
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
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
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
