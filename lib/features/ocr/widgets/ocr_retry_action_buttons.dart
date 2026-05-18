import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OcrRetryActionButtons extends StatelessWidget {
  const OcrRetryActionButtons({
    super.key,
    required this.retakeLabel,
    required this.galleryLabel,
    required this.onRetake,
    required this.onChooseGallery,
  });

  final String retakeLabel;
  final String galleryLabel;
  final VoidCallback onRetake;
  final VoidCallback onChooseGallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppColors.translatePrimaryGradient,
              borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
            ),
            child: ElevatedButton(
              onPressed: onRetake,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt_rounded, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    retakeLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: onChooseGallery,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.translateSavePngBg,
              foregroundColor: AppColors.textLink,
              side: const BorderSide(color: AppColors.translateSavePngBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image_rounded, size: 22),
                const SizedBox(width: 8),
                Text(
                  galleryLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
