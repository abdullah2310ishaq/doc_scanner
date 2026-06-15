import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../ads/native_ad_language.dart';
import '../../../core/services/locale_service.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/app_exit_guard.dart';
import '../../home/screens/main_shell_screen.dart';
import '../../launch/services/app_launch_prefs_service.dart';
import '../models/app_language_option.dart';
import '../widgets/language_option_card.dart';

/// First-time language picker shown after onboarding.
class FirstTimeLanguageSelectionScreen extends StatefulWidget {
  const FirstTimeLanguageSelectionScreen({super.key});

  @override
  State<FirstTimeLanguageSelectionScreen> createState() =>
      _FirstTimeLanguageSelectionScreenState();
}

class _FirstTimeLanguageSelectionScreenState
    extends State<FirstTimeLanguageSelectionScreen> {
  String? _selectedLanguage;

  static const Color _highlightBg = Color(0xFFF0EFFF);
  static const Color _accent = Color(0xFF4F7CFF);

  final AppLaunchPrefsService _launchPrefs = AppLaunchPrefsService();

  @override
  void initState() {
    super.initState();
    final localeService = context.read<LocaleService>();
    _selectedLanguage = localeService.getCurrentLocale().languageCode;
  }

  Future<void> _onNext() async {
    if (_selectedLanguage == null) {
      return;
    }

    await context.read<LocaleService>().setLocaleByCode(_selectedLanguage!);
    await _launchPrefs.setInitialLanguageSelected();
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShellScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppExitGuard(
      child: Scaffold(
        backgroundColor: _highlightBg,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            l10n.settingsChooseLanguage,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: ElevatedButton(
                onPressed: _selectedLanguage == null ? null : _onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                child: Text(
                  l10n.commonNext,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
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
                    childAspectRatio: 2.4,
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
                      compact: true,
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
      ),
    );
  }
}
