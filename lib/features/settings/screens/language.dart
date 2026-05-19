import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/services/locale_service.dart';
import '../../../core/utils/l10n_extension.dart';
import '../models/app_language_option.dart';
import '../widgets/language_option_card.dart';

/// Settings flow: pick a language, apply locale, return to Settings.
class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;

  static const Color _highlightBg = Color(0xFFF0EFFF);
  static const Color _accent = Color(0xFF4F7CFF);

  @override
  void initState() {
    super.initState();
    final localeService = context.read<LocaleService>();
    _selectedLanguage = localeService.getCurrentLocale().languageCode;
  }

  Future<void> _applyAndReturn() async {
    if (_selectedLanguage == null) {
      return;
    }

    final localeService = context.read<LocaleService>();
    final oldCode = localeService.getCurrentLocale().languageCode;

    if (oldCode != _selectedLanguage) {
      await localeService.setLocaleByCode(_selectedLanguage!);
    }

    if (!mounted) {
      return;
    }
    Navigator.pop(context, oldCode != _selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: _highlightBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.settingsChooseLanguage,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ElevatedButton(
              onPressed: _selectedLanguage == null ? null : _applyAndReturn,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                l10n.settingsLanguageApply,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          itemCount: appLanguageOptions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.4,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
          ),
          itemBuilder: (_, index) {
            final language = appLanguageOptions[index];
            final isSelected = _selectedLanguage == language.code;

            return LanguageOptionCard(
              language: language,
              isSelected: isSelected,
              accentColor: _accent,
              onTap: () {
                setState(() => _selectedLanguage = language.code);
              },
            );
          },
        ),
      ),
    );
  }
}
