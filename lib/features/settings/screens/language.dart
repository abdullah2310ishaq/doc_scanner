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
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Languages Grid Layout
            Positioned.fill(
              child: GridView.builder(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 16.h,
                  bottom: 100
                      .h, // Padding at bottom to ensure items don't hide behind floating button
                ),
                itemCount: appLanguageOptions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.3,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemBuilder: (_, index) {
                  final language = appLanguageOptions[index];
                  final isSelected = _selectedLanguage == language.code;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: _accent.withOpacity(0.12),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ]
                          : [],
                    ),
                    child: LanguageOptionCard(
                      language: language,
                      isSelected: isSelected,
                      accentColor: _accent,
                      onTap: () {
                        setState(() => _selectedLanguage = language.code);
                      },
                    ),
                  );
                },
              ),
            ),

            // Sticky Bottom Premium Action Button
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 16.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: (_selectedLanguage == null
                          ? Colors.transparent
                          : _accent.withOpacity(0.25)),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _selectedLanguage == null ? null : _applyAndReturn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[200],
                    disabledForegroundColor: Colors.grey[400],
                    elevation: 0,
                    minimumSize: Size(double.infinity, 56.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    l10n.settingsLanguageApply,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
