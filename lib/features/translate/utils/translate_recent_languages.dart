import '../models/translate_language.dart';

abstract final class TranslateRecentLanguages {
  static const int _maxCount = 5;
  static final List<String> _codes = [];

  static List<TranslateLanguage> resolve(List<TranslateLanguage> all) {
    final byCode = {for (final language in all) language.code: language};
    return _codes
        .map((code) => byCode[code])
        .whereType<TranslateLanguage>()
        .toList();
  }

  static void record(TranslateLanguage language) {
    _codes.remove(language.code);
    _codes.insert(0, language.code);
    if (_codes.length > _maxCount) {
      _codes.removeRange(_maxCount, _codes.length);
    }
  }
}
