import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OcrAnalyzeActionBar extends StatelessWidget {
  const OcrAnalyzeActionBar({
    super.key,
    required this.copyLabel,
    required this.translateLabel,
    required this.onCopy,
    required this.onTranslate,
  });

  final String copyLabel;
  final String translateLabel;
  final VoidCallback onCopy;
  final VoidCallback onTranslate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionPill(label: copyLabel, onTap: onCopy),
        const SizedBox(width: 12),
        _ActionPill(label: translateLabel, onTap: onTranslate),
      ],
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppColors.ocrAnalyzeActionRadius);

    return Material(
      color: AppColors.ocrAnalyzeActionBg,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: AppColors.ocrAnalyzeActionBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.ocrAnalyzeActionText,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
