import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';
import 'package:DORAK/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _initializing = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initFirebase();
  }

  Future<void> _initFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initializing = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _initializing = false;
        // Use localized firebase init error if available
        _error = AppLocalizations.of(context)?.firebaseInitError != null
            ? "${AppLocalizations.of(context)!.firebaseInitError}: $e"
            : 'Firebase failed to initialize: $e';
      });
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _loginError;

  Future<void> _loginWithEmail() async {
    setState(() {
      _isLoading = true;
      _loginError = null;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final user = credential.user;
      if (user != null) {
        // Route admin email directly to Admin Dashboard
        if ((user.email ?? '').toLowerCase() == 'demo@demo.com') {
          NavigationService.navigateTo(AppRoutes.admin);
        } else {
          NavigationService.navigateTo(
            AppRoutes.lobby,
            arguments: {'firebaseUser': user},
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loginError = e.message ??
            AppLocalizations.of(context)?.loginFailed ??
            "Login failed";
      });
    } catch (e) {
      setState(() {
        _loginError = AppLocalizations.of(context)?.loginFailed ??
            "An error occurred. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildEmailLoginForm() {
    final loc = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: loc.emailLabel,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: loc.passwordLabel,
            prefixIcon: const Icon(Icons.lock_outline),
          ),
        ),
        const SizedBox(height: 12),
        if (_loginError != null)
          Text(
            _loginError!,
            style: const TextStyle(color: Colors.red),
          ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _loginWithEmail,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    loc.signInButton,
                    style: const TextStyle(fontSize: 16),
                  ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SignUpScreen()),
            );
          },
          child: Text(loc.noAccount),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (_initializing) {
      return Scaffold(
        body: Center(child: Text(loc.loading)),
      );
    }
    if (_error != null) {
      return Scaffold(
        body: Center(child: Text(_error!)),
      );
    }

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(loc.signInTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.goBack();
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          loc.welcomeTitle,
                          style: const TextStyle(
                            fontSize: AppConstants.headingSize,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          loc.welcomeSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: AppConstants.bodySize,
                            color: AppConstants.textColor,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Responsive image
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxHeight: 230),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/login.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        _buildEmailLoginForm(),

                        const SizedBox(height: 16),

                        // Google login
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final authService = AuthService();
                              final user = await authService.signInWithGoogle();
                              if (user != null) {
                                // Redirect to LobbyScreen on successful Google login
                                NavigationService.navigateTo(
                                  AppRoutes.lobby,
                                  arguments: user,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.g_mobiledata, size: 24),
                                const SizedBox(width: 12),
                                Text(
                                  loc.googleButton,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Apple login
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final authService = AuthService();
                              final user = await authService.signInWithApple();
                              if (user != null) {
                                NavigationService.navigateTo(
                                  AppRoutes.lobby,
                                  arguments: user,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.apple, size: 24),
                                const SizedBox(width: 12),
                                Text(
                                  loc.appleButton,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Guest login
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              final authService = AuthService();
                              final user = await authService
                                  .guestLogin(loc.nicknameLabel);
                              NavigationService.navigateTo(
                                AppRoutes.lobbyGuest,
                                arguments: user,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.green),
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person_outline, size: 24),
                                const SizedBox(width: 12),
                                Text(
                                  loc.guestButton,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
