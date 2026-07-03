import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../ads/app_open.dart';
import '../../../ads/inter.dart';
import '../../../core/config/openai_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../features/subscription/providers/subscription_provider.dart';
import '../../../in_app/paywall.dart';
import '../../home/screens/main_shell_screen.dart';
import '../../settings/screens/first_language.dart';
import '../services/app_launch_prefs_service.dart';
import 'onboarding_screen.dart';

/// Shows branding, loads splash ads from remote config, then routes onward.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppLaunchPrefsService _launchPrefs = AppLaunchPrefsService();
  final InterstitialAdService _splashInterService = InterstitialAdService();

  static const Duration _minSplashDuration = Duration(seconds: 4);
  static const Duration _maxAdLoadDuration = Duration(seconds: 10);

  bool _showAdDisclaimer = false;

  @override
  void initState() {
    super.initState();
    _startLaunchFlow();
  }

  bool _shouldShowSplashInter({required bool isPro, required bool isFirstLaunch}) {
    if (isPro || isFirstLaunch) return false;

    final showInter = OpenAiConfig.splashInterAd;
    final showAppOpen = OpenAiConfig.splashAppOpenAd;
    if (!showInter && !showAppOpen) return false;
    if (showInter && showAppOpen) return true;
    return showInter;
  }

  bool _shouldShowSplashAppOpen({required bool isPro, required bool isFirstLaunch}) {
    if (isPro || isFirstLaunch) return false;

    final showInter = OpenAiConfig.splashInterAd;
    final showAppOpen = OpenAiConfig.splashAppOpenAd;
    if (showInter && showAppOpen) return false;
    return showAppOpen;
  }

  Future<void> _waitForSplashAndAds({
    required bool isPro,
    required bool isFirstLaunch,
  }) async {
    final showInter = _shouldShowSplashInter(
      isPro: isPro,
      isFirstLaunch: isFirstLaunch,
    );
    final showAppOpen = _shouldShowSplashAppOpen(
      isPro: isPro,
      isFirstLaunch: isFirstLaunch,
    );
    final shouldShowAds = showInter || showAppOpen;

    final splashStartedAt = DateTime.now();

    if (shouldShowAds) {
      if (showInter) {
        _splashInterService.loadAd();
      } else {
        AppOpenAdService.instance.loadAd();
      }
    }

    await Future<void>.delayed(_minSplashDuration);
    if (!mounted) return;

    if (shouldShowAds) {
      final elapsed = DateTime.now().difference(splashStartedAt);
      final remainingLoadTime = _maxAdLoadDuration - elapsed;
      if (remainingLoadTime > Duration.zero) {
        if (showInter) {
          await _splashInterService.waitUntilReady(timeout: remainingLoadTime);
        } else {
          await AppOpenAdService.instance.waitUntilReady(
            timeout: remainingLoadTime,
          );
        }
      }

      if (!mounted) return;

      if (showInter && _splashInterService.isAdAvailable) {
        await _splashInterService.showAdIfAvailable();
        AppOpenAdService.instance.blockNextForegroundShow();
      } else if (showAppOpen && AppOpenAdService.instance.isAdAvailable) {
        await AppOpenAdService.instance.showSplashAdIfAvailable();
      }
    }
  }

  Future<void> _startLaunchFlow() async {
    final subscription = context.read<SubscriptionProvider>();
    final isPro = subscription.isPro;
    final isFirstLaunch = await _launchPrefs.isFirstLaunch();

    final showInter = _shouldShowSplashInter(
      isPro: isPro,
      isFirstLaunch: isFirstLaunch,
    );
    final showAppOpen = _shouldShowSplashAppOpen(
      isPro: isPro,
      isFirstLaunch: isFirstLaunch,
    );
    if (mounted && (showInter || showAppOpen)) {
      setState(() => _showAdDisclaimer = true);
    }

    await _waitForSplashAndAds(isPro: isPro, isFirstLaunch: isFirstLaunch);

    if (!mounted) return;

    if (isPro) {
      _goHome();
      return;
    }

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

    _goPaywall(showAdOnClose: false);
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

  void _goPaywall({required bool showAdOnClose}) {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ProAccessScreen(
          nextScreen: const MainShellScreen(),
          initialTrialEnabled: false,
          showAdOnClose: showAdOnClose,
        ),
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
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        l10n.splashAdDisclaimer,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
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
