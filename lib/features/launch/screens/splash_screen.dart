import 'package:flutter/material.dart';

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
    await Future<void>.delayed(const Duration(seconds: 1200));
    await _launchPrefs.markFirstLaunchSeen();
    final hasCompletedOnboarding = await _launchPrefs.hasCompletedOnboarding();

    if (!mounted) {
      return;
    }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/home/scanner.png', width: 96, height: 96),
            const SizedBox(height: 24),
            Text(
              l10n.appTitle,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.splashTagline,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              color: AppColors.navbarGradientStart,
            ),
          ],
        ),
      ),
    );
  }
}
