import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/app_exit_guard.dart';
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

  // Updated page count to 4
  static const int _pageCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLastPage = _pageIndex == _pageCount - 1;
    final showSkip = !isLastPage;

    // Updated with your 4 new pages and onboarding assets path
    final pages = [
      _OnboardingPageData(
        imageAsset: 'assets/onboarding/one.png',
        title: "Scan Text \nin Seconds",
        description:
            "Capture text from images with fast AI-powered OCR scanning.",
      ),
      _OnboardingPageData(
        imageAsset: 'assets/onboarding/two.png',
        title: "Smart PDF \nAssistant",
        description:
            "Translate, extract and understand\nyour PDF documents with AI.",
      ),
      _OnboardingPageData(
        imageAsset: 'assets/onboarding/three.png',
        title: "Chat with \nYour PDFs",
        description:
            "Ask questions, summarize documents\nand get instant AI answers.",
      ),
      _OnboardingPageData(
        imageAsset: 'assets/onboarding/four.png',
        title: "Smart Crop \nin Seconds",
        description:
            "Auto-crop multiple images and\ncreate clean PDFs instantly.",
      ),
    ];

    return AppExitGuard(
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
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image.asset(
                              page.imageAsset,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                            ),
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
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  final String imageAsset;
  final String title;
  final String description;
}
