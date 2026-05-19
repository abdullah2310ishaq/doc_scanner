import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.homeHeroGradient,
        borderRadius: BorderRadius.circular(AppColors.homeHeroRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppColors.homeHeroRadius),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 2, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          HomeAssets.sparkles,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          badge,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: 0.92),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _OcrButton(label: buttonLabel, onPressed: onPressed),
                  ],
                ),
              ),
              Image.asset(
                HomeAssets.homeHeader,
                height: 110,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OcrButton extends StatelessWidget {
  const _OcrButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppColors.homeHeroButtonRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppColors.homeHeroButtonRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(HomeAssets.camera, width: 14, height: 14),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.homeHeroGradientStart,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
