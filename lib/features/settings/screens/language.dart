import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../ads/native_ad_language.dart';
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

  // Modern, high-contrast premium palette
  static const Color _accent = Color(0xFF4F7CFF);
  static const Color _textPrimary = Color(0xFF1A1A1A);

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
      backgroundColor: Colors.white, // Pure premium white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 56.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: _textPrimary,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          l10n.settingsChooseLanguage,
          style: TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 22.sp,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Material(
              color: _selectedLanguage == null ? Colors.grey.shade200 : _accent,
              shape: const StadiumBorder(),
              elevation: _selectedLanguage == null ? 0 : 2,
              shadowColor: _accent.withValues(alpha: 0.35),
              child: InkWell(
                customBorder: const StadiumBorder(),
                onTap: _selectedLanguage == null ? null : _applyAndReturn,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: Text(
                    l10n.settingsLanguageApply,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: _selectedLanguage == null
                          ? Colors.grey.shade400
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: GridView.builder(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 8.h,
                  bottom: 130.h,
                ),
                itemCount: appLanguageOptions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.65,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                ),
                itemBuilder: (_, index) {
                  final language = appLanguageOptions[index];
                  final isSelected = _selectedLanguage == language.code;

                  return LanguageOptionCard(
                    language: language,
                    isSelected: isSelected,
                    accentColor: _accent,
                    large: true,
                    onTap: () {
                      setState(() => _selectedLanguage = language.code);
                    },
                  );
                },
              ),
            ),

            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
              child: const NativeAdLanguage(),
            ),
          ],
        ),
      ),
    );
  }
}
