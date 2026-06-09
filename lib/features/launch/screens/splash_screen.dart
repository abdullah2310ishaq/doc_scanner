import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

class _SplashScreenState extends State<SplashScreen> {
  final AppLaunchPrefsService _launchPrefs = AppLaunchPrefsService();

  @override
  void initState() {
    super.initState();
    _startLaunchFlow();
  }

  Future<void> _startLaunchFlow() async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    // Pre-fetching initialization preferences
    await _launchPrefs.markFirstLaunchSeen();
    final hasCompletedOnboarding = await _launchPrefs.hasCompletedOnboarding();

    if (!mounted) return;

    final Widget nextScreen = hasCompletedOnboarding
        ? const MainShellScreen()
        : const OnboardingScreen();

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => nextScreen));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Center Content: Lottie aur App Title Text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/splash.json',
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
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
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        TextSpan(
                          text: l10n.appTitle.replaceAll('AI', '').trim(),
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Content: Circular progress indicator placed exactly where the old loader was
            const Positioned(
              bottom:
                  48, // Purane linear bar ki jagah bottom se perfect spacing
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
