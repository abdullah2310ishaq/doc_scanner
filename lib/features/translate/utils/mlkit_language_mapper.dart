import 'package:google_mlkit_translation/google_mlkit_translation.dart' as mlkit;

/// Maps app language codes to ML Kit on-device translation languages.
abstract final class MlKitLanguageMapper {
  static mlkit.TranslateLanguage? toMlKit(String code) {
    final normalized = _normalizeCode(code);

    for (final language in mlkit.TranslateLanguage.values) {
      if (language.bcpCode == normalized) return language;
    }
    return null;
  }

  static bool isSupported(String code) => toMlKit(code) != null;

  static String _normalizeCode(String code) {
    switch (code) {
      case 'zh-TW':
      case 'zh-CN':
        return 'zh';
      case 'fa-AF':
        return 'fa';
      default:
        return code.split('-').first;
    }
  }
}
