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
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  bool _isLoggingIn = false; // To prevent multiple presses

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        if (_currentPage < 2) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

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
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              const SizedBox(height: 30),
              // Logo Section with image
              Stack(
                alignment: Alignment.center,
                children: [
                  // Main logo container with image
                  Container(
                    width: 220,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/logo.png', // Your logo image
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),

              // Tagline
              const Text(
                'لِصةِ للطائفةِ والأكصدِفَاءِ\nA game that brings together family and friends',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppConstants.textColor,
                ),
              ),

              const Spacer(),

              // Real Image Carousel with auto-slide
              _buildImageCarousel(),

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
                              child: CircularProgressIndicator(strokeWidth: 2),
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
    );
  }

  Widget _buildImageCarousel() {
    final List<String> carouselImages = [
      'assets/images/carousel1.png',
      'assets/images/carousel2.png',
      'assets/images/carousel3.png',
    ];

    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: _pageController,
        itemCount: carouselImages.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Real image from assets
                    Image.asset(
                      carouselImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),

                    // Image indicator
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(carouselImages.length, (dotIndex) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: dotIndex == _currentPage
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
