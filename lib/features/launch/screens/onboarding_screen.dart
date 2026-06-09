import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../home/screens/main_shell_screen.dart';
import '../services/app_launch_prefs_service.dart';

/// Four-page intro shown on first launch ([PageView]).
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final AppLaunchPrefsService _launchPrefs = AppLaunchPrefsService();
  int _pageIndex = 0;
  Timer? _autoScrollTimer;

  static const int _pageCount = 4;
  static const Duration _autoScrollInterval = Duration(seconds: 4);
  static const Duration _pageAnimationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(_autoScrollInterval, (_) {
      _autoAdvancePage();
    });
  }

  void _autoAdvancePage() {
    if (!mounted || !_pageController.hasClients) {
      return;
    }

    final nextIndex = _pageIndex >= _pageCount - 1 ? 0 : _pageIndex + 1;
    _pageController.animateToPage(
      nextIndex,
      duration: _pageAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finishOnboarding() async {
    await _launchPrefs.setOnboardingCompleted();
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShellScreen()),
    );
  }

  void _goToNextPage() {
    if (_pageIndex >= _pageCount - 1) {
      return;
    }
    _pageController.nextPage(
      duration: _pageAnimationDuration,
      curve: Curves.easeInOut,
    );
    _startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLastPage = _pageIndex == _pageCount - 1;
    final showSkip = !isLastPage;

    final pages = [
      _OnboardingPageData(
        lottieAsset: 'assets/first.json',
        pngOverlayAsset: 'assets/firstob.png',
        title: l10n.onboardingPage1Title,
        description: l10n.onboardingPage1Description,
      ),
      _OnboardingPageData(
        lottieAsset: 'assets/second.json',
        pngOverlayAsset: 'assets/secondob.png',
        title: l10n.onboardingPage2Title,
        description: l10n.onboardingPage2Description,
      ),
      _OnboardingPageData(
        lottieAsset: 'assets/third.json',
        title: l10n.onboardingPage3Title,
        description: l10n.onboardingPage3Description,
      ),
      _OnboardingPageData(
        lottieAsset: 'assets/fourth.json',
        title: l10n.onboardingPage4Title,
        description: l10n.onboardingPage4Description,
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.smartCropSoftBackground,
        body: SafeArea(
          child: Column(
            children: [
              if (showSkip)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _finishOnboarding,
                    child: Text(l10n.commonSkip),
                  ),
                )
              else
                const SizedBox(height: 48),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pageCount,
                  onPageChanged: (index) {
                    setState(() => _pageIndex = index);
                    _startAutoScroll();
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];

                    // Determine if the current JSON background needs scaling (Page 2 & 3)
                    final bool scaleJson = (index == 1 || index == 2);

                    final Widget finalGraphic = page.pngOverlayAsset != null
                        ? _buildStackedGraphic(
                            lottiePath: page.lottieAsset,
                            pngPath: page.pngOverlayAsset!,
                            showCorners: index == 0,
                            scaleBackgroundOnly:
                                scaleJson, // Conditional scale control
                          )
                        : Transform.scale(
                            scale: scaleJson ? 1.15 : 1.0,
                            child: Lottie.asset(
                              page.lottieAsset,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          );

                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: finalGraphic,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              OnboardingTitleText(title: page.title),
                              const SizedBox(height: 8),
                              Text(
                                page.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.45,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pageCount, (index) {
                  final isActive = index == _pageIndex;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 7 : 6,
                    height: isActive ? 7 : 6,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.textPrimary
                          : AppColors.textPrimary.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppColors.onboardingCtaGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: isLastPage ? _finishOnboarding : _goToNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isLastPage ? l10n.onboardingStart : l10n.commonContinue,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable setup to stack JSON animations with overlay PNG cards at the bottom
  Widget _buildStackedGraphic({
    required String lottiePath,
    required String pngPath,
    required bool showCorners,
    required bool scaleBackgroundOnly,
  }) {
    // Isolate the Lottie image inside a scaled container ONLY if the flag is true
    final Widget lottieWidget = Lottie.asset(
      lottiePath,
      fit: BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. The Lottie animation running in the background (Scales if required)
        scaleBackgroundOnly
            ? Transform.scale(scale: 1.15, child: lottieWidget)
            : lottieWidget,

        // 2. Scanner Corners - Kept outside of scale parameters to protect positions
        if (showCorners)
          Positioned(
            top: 65,
            left: 45,
            right: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildScannerCorner(topLeft: true),
                _buildScannerCorner(topLeft: false),
              ],
            ),
          ),

        // 3. PNG card remains untouched at height 140, aligned identically across page 1 and 2
        Positioned(
          bottom: 0,
          left: 16,
          right: 16,
          child: Image.asset(pngPath, fit: BoxFit.contain, height: 140),
        ),
      ],
    );
  }

  /// Reusable widget to generate a custom scanner corner line
  Widget _buildScannerCorner({required bool topLeft}) {
    const double size = 32.0;
    const double thickness = 5.0;
    const Radius radius = Radius.circular(12);
    final Color cornerColor = AppColors.onboardingCtaGradientStart;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: cornerColor, width: thickness),
          left: topLeft
              ? BorderSide(color: cornerColor, width: thickness)
              : BorderSide.none,
          right: !topLeft
              ? BorderSide(color: cornerColor, width: thickness)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: topLeft ? radius : Radius.zero,
          topRight: !topLeft ? radius : Radius.zero,
        ),
      ),
    );
  }
}

/// Title: first line (first two words) blue, remaining lines black.
class OnboardingTitleText extends StatelessWidget {
  const OnboardingTitleText({super.key, required this.title});

  final String title;

  static const TextStyle _baseStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  @override
  Widget build(BuildContext context) {
    final lines = title
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    if (lines.isEmpty) {
      return const SizedBox.shrink();
    }

    final blueLine = lines.first;
    final blackLines = lines.length > 1 ? lines.sublist(1).join('\n') : '';

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: blueLine,
            style: _baseStyle.copyWith(
              color: AppColors.onboardingCtaGradientStart,
            ),
          ),
          if (blackLines.isNotEmpty) ...[
            const TextSpan(text: '\n'),
            TextSpan(
              text: blackLines,
              style: _baseStyle.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.lottieAsset,
    this.pngOverlayAsset,
    required this.title,
    required this.description,
  });

  final String lottieAsset;
  final String? pngOverlayAsset;
  final String title;
  final String description;
}
