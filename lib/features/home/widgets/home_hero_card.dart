import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';

class HomeHeroCard extends StatelessWidget {
  const HomeHeroCard({
    super.key,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.onPressed,
  });

  final String badge;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback? onPressed;

  static bool _isCompactLocale(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    return languageCode == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    final isCompactLocale = _isCompactLocale(context);

    // Halka sa size badha diya hai yahan par animations ke liye
    final heroImageWidth = isCompactLocale ? 90.w : 110.w; // 92.w se 110.w kiya
    final heroImageHeight = isCompactLocale
        ? 100.h
        : 120.h; // 100.h se 120.h kiya

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppColors.homeHeroRadius.r),
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.homeHeroGradient,
            borderRadius: BorderRadius.circular(AppColors.homeHeroRadius.r),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 8.w, 16.h),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final textColumnWidth =
                    constraints.maxWidth - heroImageWidth - 4.w;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: textColumnWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                HomeAssets.sparkles,
                                width: 16.w,
                                height: 16.w,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  badge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: isCompactLocale ? 11.sp : 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            title,
                            maxLines: isCompactLocale ? 4 : 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: isCompactLocale ? 14.sp : 18.sp,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            subtitle,
                            maxLines: isCompactLocale ? 4 : 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.white.withValues(alpha: 0.92),
                              fontSize: isCompactLocale ? 9.sp : 11.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.35,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _OcrButton(
                            label: buttonLabel,
                            maxWidth: textColumnWidth,
                            isCompactLocale: isCompactLocale,
                          ),
                        ],
                      ),
                    ),
                    Lottie.asset(
                      'assets/pen.json',
                      width: heroImageWidth,
                      height: heroImageHeight,
                      fit: BoxFit.contain,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _OcrButton extends StatelessWidget {
  const _OcrButton({
    required this.label,
    required this.maxWidth,
    required this.isCompactLocale,
  });

  final String label;
  final double maxWidth;
  final bool isCompactLocale;

  @override
  Widget build(BuildContext context) {
    final iconSize = isCompactLocale ? 12.w : 14.w;
    final horizontalPadding = isCompactLocale ? 6.w : 8.w;
    final spacing = 6.w;
    final labelMaxWidth =
        (maxWidth - (horizontalPadding * 2) - iconSize - spacing).clamp(
          0.0,
          maxWidth,
        );

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: isCompactLocale ? 6.h : 8.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppColors.homeHeroButtonRadius.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(HomeAssets.camera, width: iconSize, height: iconSize),
            SizedBox(width: spacing),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: labelMaxWidth),
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  color: AppColors.homeHeroGradientStart,
                  fontSize: isCompactLocale ? 10.sp : 12.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
