import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';

class HomeFeatureCard extends StatelessWidget {
  const HomeFeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.backgroundColor = Colors.white,
    required this.iconAsset,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String iconAsset;
  final VoidCallback? onTap;

  static const double _radius = 8;
  static const double _iconSize =
      36; // Made icon slightly bigger to match the taller card

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Reduced the gap between cards from 12 to 8
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        shadowColor: Colors.black.withOpacity(0.12), // Smoother, softer shadow
        elevation: 3,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_radius),
          child: Padding(
            // Increased vertical padding to 24 for extra length/height
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              children: [
                _FeatureIcon(assetPath: iconAsset, size: _iconSize),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16, // Increased slightly for better balance
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textSecondary,
                  size: 24, // Matches the new card size perfectly
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  const _FeatureIcon({required this.assetPath, required this.size});

  final String assetPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(assetPath, width: size, height: size);
    }
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
