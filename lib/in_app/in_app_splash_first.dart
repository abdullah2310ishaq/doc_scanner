import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/l10n_extension.dart';
import '../features/subscription/providers/subscription_provider.dart';
import 'paywall.dart';

class SplashProScreen extends StatefulWidget {
  const SplashProScreen({super.key, required this.nextScreen});

  final Widget nextScreen;

  @override
  State<SplashProScreen> createState() => _SplashProScreenState();
}

class _SplashProScreenState extends State<SplashProScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _controller;

  void _goToNextScreen() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => widget.nextScreen),
    );
  }

  void _goToPaywall() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ProAccessScreen(
          nextScreen: widget.nextScreen,
          initialTrialEnabled: true,
          showAdOnClose: false,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      if (context.read<SubscriptionProvider>().isPro) {
        _goToNextScreen();
        return;
      }
      _timer = Timer(const Duration(seconds: 3), _goToPaywall);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = AppColors.textLink;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        _goToPaywall();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: isDark
              ? const Color(0xff121212)
              : AppColors.scaffoldBackground,
          body: Stack(
            children: [
              Positioned(
                top: 8.h,
                left: 8.w,
                child: IconButton(
                  onPressed: _goToPaywall,
                  icon: Icon(
                    Icons.close,
                    color: isDark ? AppColors.white : Colors.black,
                    size: 26.w,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final t = Curves.easeInOut.transform(
                        _controller.value.clamp(0.0, 1.0),
                      );

                      final offTrack = isDark
                          ? const Color(0xff2a2a2a)
                          : const Color(0xffe0e0e0);
                      final onTrack = primaryColor;
                      final trackColor = Color.lerp(offTrack, onTrack, t)!;

                      final textOffColor = isDark
                          ? Colors.white60
                          : const Color(0xffb5b5b5);
                      final textOnColor = primaryColor;

                      final trackWidth = 120.w;
                      final trackHeight = 60.w;
                      final paddingValue = 5.w;
                      final knobSize = trackHeight - (paddingValue * 2);
                      final maxTravel =
                          trackWidth - knobSize - (paddingValue * 2);
                      final knobLeft = paddingValue + (t * maxTravel);

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: trackWidth,
                            height: trackHeight,
                            padding: EdgeInsets.all(paddingValue),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: trackColor,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: knobLeft,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: knobSize,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40.h),
                          if (t < 0.5) ...[
                            Text(
                              l10n.proSplashEnable,
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.normal,
                                color: textOffColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              l10n.proSplashTrialDays,
                              style: TextStyle(
                                fontSize: 36.sp,
                                fontWeight: FontWeight.bold,
                                color: textOffColor,
                              ),
                            ),
                          ] else ...[
                            Text(
                              l10n.proSplashTrialDays,
                              style: TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                                color: textOnColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              l10n.proSplashTrialEnabled,
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                color: textOnColor,
                              ),
                            ),
                          ],
                        ],
                      );
                    },
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
