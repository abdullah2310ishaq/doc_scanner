import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/translate_language.dart';

class TranslateLanguageDropdown extends StatelessWidget {
  const TranslateLanguageDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.languages,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String hint;
  final List<TranslateLanguage> languages;
  final TranslateLanguage? value;
  final ValueChanged<TranslateLanguage?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        DropdownButtonFormField<TranslateLanguage>(
          initialValue: value,
          hint: Text(
            hint,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
              borderSide: const BorderSide(color: AppColors.translateCardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
              borderSide: const BorderSide(color: AppColors.translateCardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
              borderSide: const BorderSide(color: AppColors.textLink, width: 1.5),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: languages
              .map(
                (language) => DropdownMenuItem<TranslateLanguage>(
                  value: language,
                  child: Text(language.name),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
