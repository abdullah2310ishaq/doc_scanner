import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/translate_language.dart';

class TranslateSelectLanguageButton extends StatelessWidget {
  const TranslateSelectLanguageButton({
    super.key,
    required this.label,
    required this.hint,
    required this.selectedLanguage,
    required this.onTap,
  });

  final String label;
  final String hint;
  final TranslateLanguage? selectedLanguage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final displayName = selectedLanguage?.name ?? hint;
    final hasSelection = selectedLanguage != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
                border: Border.all(color: AppColors.translateCardBorder),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        displayName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: hasSelection ? FontWeight.w600 : FontWeight.w400,
                          color: hasSelection
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
