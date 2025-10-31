import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Add loading and error state for firebase
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
        _error = 'Firebase failed to initialize: $e';
      });
    }
  }

  // Email login fields
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
      // Map to your user model/route
      if (user != null) {
        NavigationService.navigateTo(
          AppRoutes.lobby,
          arguments: {
            'firebaseUser': user,
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loginError = e.message ?? "Login failed";
      });
    } catch (e) {
      setState(() {
        _loginError = "An error occurred. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildEmailLoginForm() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: "Email",
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(Icons.lock_outline),
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
                : const Text(
                    "Sign In with Email",
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SignUpScreen()),
            );
          },
          child: const Text("Don't have an account? Sign Up"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_initializing) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        body: Center(child: Text(_error!)),
      );
    }
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
              const SizedBox(height: 20), // Add some spacing

              Container(
                width: 330,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/login.png', // Your logo image
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              const Spacer(),

              // Login Options
              Column(
                children: [
                  _buildEmailLoginForm(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final authService = AuthService();
                        final user = await authService.signInWithGoogle();
                        if (user != null) {
                          NavigationService.navigateTo(
                            AppRoutes.lobby,
                            arguments: user, // Pass the user to lobby
                          );
                        }
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
                      onPressed: () async {
                        final authService = AuthService();
                        final user = await authService.signInWithApple();
                        if (user != null) {
                          NavigationService.navigateTo(
                            AppRoutes.lobby,
                            arguments: user, // Pass the user to lobby
                          );
                        }
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
                      onPressed: () async {
                        final authService = AuthService();
                        final user =
                            await authService.guestLogin('Guest Player');
                        NavigationService.navigateTo(
                          AppRoutes.lobby,
                          arguments: user, // Pass the user to lobby
                        );
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
