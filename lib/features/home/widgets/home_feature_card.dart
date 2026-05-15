import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';

class HomeFeatureCard extends StatelessWidget {
  const HomeFeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.iconAsset,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String iconAsset;
  final VoidCallback? onTap;

  static const double _radius = 6;
  static const double _iconSize = 44;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(_radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_radius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              SvgPicture.asset(
                iconAsset,
                width: _iconSize,
                height: _iconSize,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
