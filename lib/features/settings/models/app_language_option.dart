/// One selectable app UI language (flag + codes for [LocaleService]).
class AppLanguageOption {
  const AppLanguageOption({
    required this.code,
    required this.nativeName,
    required this.imageAsset,
    this.isPng = false,
  });

  final String code;
  final String nativeName;
  final String imageAsset;
  final bool isPng;
}

/// Languages shown on first-time and settings language screens.
const List<AppLanguageOption> appLanguageOptions = [
  AppLanguageOption(
    code: 'en',
    nativeName: 'English',
    imageAsset: 'assets/language/usa.svg',
  ),
  AppLanguageOption(
    code: 'es',
    nativeName: 'Español',
    imageAsset: 'assets/language/espanol.svg',
  ),
  AppLanguageOption(
    code: 'fr',
    nativeName: 'Français',
    imageAsset: 'assets/language/french.svg',
  ),
  AppLanguageOption(
    code: 'de',
    nativeName: 'Deutsch',
    imageAsset: 'assets/language/german.svg',
  ),
  AppLanguageOption(
    code: 'it',
    nativeName: 'Italiano',
    imageAsset: 'assets/language/italian.svg',
  ),
  AppLanguageOption(
    code: 'pt',
    nativeName: 'Português',
    imageAsset: 'assets/language/portugese.svg',
  ),
  AppLanguageOption(
    code: 'ru',
    nativeName: 'Русский',
    imageAsset: 'assets/language/russia.svg',
  ),
  AppLanguageOption(
    code: 'zh',
    nativeName: '中文',
    imageAsset: 'assets/language/china.svg',
  ),
  AppLanguageOption(
    code: 'ja',
    nativeName: '日本語',
    imageAsset: 'assets/language/japan.svg',
  ),
  AppLanguageOption(
    code: 'ko',
    nativeName: '한국어',
    imageAsset: 'assets/language/korea.svg',
  ),
  AppLanguageOption(
    code: 'ar',
    nativeName: 'العربية',
    imageAsset: 'assets/language/sudan.svg',
  ),
];

String? nativeNameForLanguageCode(String code) {
  for (final option in appLanguageOptions) {
    if (option.code == code) {
      return option.nativeName;
    }
  }
  return null;
}
