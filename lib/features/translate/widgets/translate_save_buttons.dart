import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class TranslateSaveButtons extends StatelessWidget {
  const TranslateSaveButtons({
    super.key,
    required this.savePdfLabel,
    required this.savePngLabel,
    required this.onSavePdf,
    required this.onSavePng,
  });

  final String savePdfLabel;
  final String savePngLabel;
  final VoidCallback onSavePdf;
  final VoidCallback onSavePng;

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
              onPressed: onSavePdf,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
                ),
              ),
              child: Text(
                savePdfLabel,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: onSavePng,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.translateSavePngBg,
              foregroundColor: AppColors.textLink,
              side: const BorderSide(color: AppColors.translateSavePngBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
              ),
            ),
            child: Text(
              savePngLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
