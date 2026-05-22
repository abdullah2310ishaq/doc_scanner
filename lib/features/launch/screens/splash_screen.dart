import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Make sure to add lottie package to pubspec.yaml
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../home/screens/main_shell_screen.dart';
import '../services/app_launch_prefs_service.dart';
import 'onboarding_screen.dart';

/// Shows branding, initializes prefs, then routes to onboarding or home.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final AppLaunchPrefsService _launchPrefs = AppLaunchPrefsService();
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    
    // Controller for the 3-second bottom progress line animation
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _startLaunchFlow();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _startLaunchFlow() async {
    // Fixed: Changed from 1200 seconds to your requested 3 seconds (3000 milliseconds)
    await Future<void>.delayed(const Duration(milliseconds: 3000));
    
    // Pre-fetching initialization preferences while splash is running
    await _launchPrefs.markFirstLaunchSeen();
    final hasCompletedOnboarding = await _launchPrefs.hasCompletedOnboarding();

    if (!mounted) return;

    final Widget nextScreen = hasCompletedOnboarding
        ? const MainShellScreen()
        : const OnboardingScreen();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground, // White/Off-white base
      body: SafeArea(
        child: Stack(
          children: [
            // Center Content: Lottie Animation & App Title text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lottie JSON asset animation replacing the static Image.asset
                  Lottie.asset(
                    'assets/splash.json',
                    width: 140, 
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  
                  // RichText used to apply distinct colors ("AI" blue, rest black)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      children: [
                        const TextSpan(
                          text: 'AI ',
                          style: TextStyle(color: Colors.blueAccent), // Blue accent for "AI"
                        ),
                        TextSpan(
                          text: l10n.appTitle.replaceAll('AI', '').trim(),
                          style: const TextStyle(color: Colors.black87), // Dark text for "Document Scanner"
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Bottom Linear Progress Bar matching your layout
            Positioned(
              bottom: 48,
              left: 32,
              right: 32,
              child: AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progressController.value,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}