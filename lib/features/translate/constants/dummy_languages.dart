import '../models/translate_language.dart';

abstract final class DummyLanguages {
  static const List<TranslateLanguage> all = [
    TranslateLanguage(code: 'en', name: 'English'),
    TranslateLanguage(code: 'es', name: 'Spanish'),
    TranslateLanguage(code: 'fr', name: 'French'),
    TranslateLanguage(code: 'de', name: 'German'),
    TranslateLanguage(code: 'zh', name: 'Chinese'),
    TranslateLanguage(code: 'hi', name: 'Hindi'),
    TranslateLanguage(code: 'ar', name: 'Arabic'),
    TranslateLanguage(code: 'pt', name: 'Portuguese'),
    TranslateLanguage(code: 'ru', name: 'Russian'),
    TranslateLanguage(code: 'ja', name: 'Japanese'),
  ];
}
