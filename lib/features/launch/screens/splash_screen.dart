import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../ads/inter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../home/screens/main_shell_screen.dart';
import '../../settings/screens/first_language.dart';
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
  final InterstitialAdService _interstitialService = InterstitialAdService();

  bool _showAdDisclaimer = false;

  @override
  void initState() {
    super.initState();
    _interstitialService.loadAd();
    _startLaunchFlow();
  }

  Future<void> _startLaunchFlow() async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    final isFirstLaunch = await _launchPrefs.isFirstLaunch();
    final hasCompletedOnboarding = await _launchPrefs.hasCompletedOnboarding();
    final hasSelectedInitialLanguage = await _launchPrefs
        .hasSelectedInitialLanguage();

    if (!mounted) {
      return;
    }

    if (isFirstLaunch) {
      await _launchPrefs.markFirstLaunchSeen();
      _navigateAfterSplash(
        hasCompletedOnboarding: hasCompletedOnboarding,
        hasSelectedInitialLanguage: hasSelectedInitialLanguage,
      );
      return;
    }

    if (!hasCompletedOnboarding) {
      _navigateAfterSplash(
        hasCompletedOnboarding: false,
        hasSelectedInitialLanguage: hasSelectedInitialLanguage,
      );
      return;
    }

    if (!hasSelectedInitialLanguage) {
      _goFirstLanguage();
      return;
    }

    setState(() => _showAdDisclaimer = true);

    final adReady = await _interstitialService.waitUntilReady();
    if (!mounted) {
      return;
    }

    if (adReady) {
      _interstitialService.showAdWithLoading(
        context: context,
        loadingMessage: context.l10n.adLoading,
        onAdDismissed: _goHome,
      );
    } else {
      _goHome();
    }
  }

  void _navigateAfterSplash({
    required bool hasCompletedOnboarding,
    required bool hasSelectedInitialLanguage,
  }) {
    if (!mounted) {
      return;
    }

    final Widget nextScreen;
    if (!hasCompletedOnboarding) {
      nextScreen = const OnboardingScreen();
    } else if (!hasSelectedInitialLanguage) {
      nextScreen = const FirstTimeLanguageSelectionScreen();
    } else {
      nextScreen = const MainShellScreen();
    }

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute<void>(builder: (_) => nextScreen));
  }

  void _goFirstLanguage() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const FirstTimeLanguageSelectionScreen(),
      ),
    );
  }

  void _goHome() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MainShellScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Stack(
          children: [
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
                          style: TextStyle(color: AppColors.textLink),
                        ),
                        TextSpan(
                          text: l10n.appTitle.replaceAll('AI', '').trim(),
                          style: const TextStyle(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textLink,
                      ),
                    ),
                  ),
                  if (_showAdDisclaimer) ...[
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        l10n.splashAdDisclaimer,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
