import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;

  static const Color scannerHighlightBg = Color(0xFFF0EFFF);
  static const Color scannerBracket = Color(0xFF4F7CFF);

  final List<Map<String, dynamic>> _languages = [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'imageAsset': 'assets/language/usa.svg',
      'isPng': false,
    },
    {
      'code': 'es',
      'name': 'Spanish',
      'nativeName': 'Español',
      'imageAsset': 'assets/language/espanol.svg',
      'isPng': false,
    },
    {
      'code': 'fr',
      'name': 'French',
      'nativeName': 'Français',
      'imageAsset': 'assets/language/french.svg',
      'isPng': false,
    },
    {
      'code': 'de',
      'name': 'German',
      'nativeName': 'Deutsch',
      'imageAsset': 'assets/language/german.svg',
      'isPng': false,
    },
    {
      'code': 'it',
      'name': 'Italian',
      'nativeName': 'Italiano',
      'imageAsset': 'assets/language/italian.svg',
      'isPng': false,
    },
    {
      'code': 'pt',
      'name': 'Portuguese',
      'nativeName': 'Português',
      'imageAsset': 'assets/portugal.png',
      'isPng': true,
    },
    {
      'code': 'ru',
      'name': 'Russian',
      'nativeName': 'Русский',
      'imageAsset': 'assets/language/russia.svg',
      'isPng': false,
    },
    {
      'code': 'zh',
      'name': 'Chinese',
      'nativeName': '中文',
      'imageAsset': 'assets/language/china.svg',
      'isPng': false,
    },
    {
      'code': 'ja',
      'name': 'Japanese',
      'nativeName': '日本語',
      'imageAsset': 'assets/language/japan.svg',
      'isPng': false,
    },
    {
      'code': 'ko',
      'name': 'Korean',
      'nativeName': '한국어',
      'imageAsset': 'assets/language/korea.svg',
      'isPng': false,
    },
    {
      'code': 'ar',
      'name': 'Arabic',
      'nativeName': 'العربية',
      'imageAsset': 'assets/language/sudan.svg',
      'isPng': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    final localeService =
        Provider.of<LocaleService>(context, listen: false);
    _selectedLanguage =
        localeService.getCurrentLocale().languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scannerHighlightBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.chooseALanguage,
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
              onPressed: _selectedLanguage == null
                  ? null
                  : () async {
                      final localeService =
                          Provider.of<LocaleService>(
                        context,
                        listen: false,
                      );

                      final oldCode = localeService
                          .getCurrentLocale()
                          .languageCode;

                      if (oldCode != _selectedLanguage) {
                        await localeService.setLocaleByCode(
                          _selectedLanguage!,
                        );
                      }

                      if (context.mounted) {
                        Navigator.pop(
                          context,
                          oldCode != _selectedLanguage,
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: scannerBracket,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 8.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.next,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          itemCount: _languages.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.4,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
          ),
          itemBuilder: (_, index) {
            final language = _languages[index];
            final isSelected =
                _selectedLanguage == language['code'];

            return _buildLanguageCard(
              language,
              isSelected,
            );
          },
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    Map<String, dynamic> language,
    bool isSelected,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: () {
        setState(() {
          _selectedLanguage =
              language['code'] as String;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? scannerBracket
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? scannerBracket.withOpacity(0.12)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30.w,
              height: 30.w,
              child: (language['isPng'] as bool)
                  ? Image.asset(
                      language['imageAsset'],
                      fit: BoxFit.contain,
                    )
                  : SvgPicture.asset(
                      language['imageAsset'],
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                language['nativeName'],
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: isSelected
                      ? scannerBracket
                      : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: scannerBracket,
                size: 18.sp,
              ),
          ],
        ),
      ),
    );
  }
}