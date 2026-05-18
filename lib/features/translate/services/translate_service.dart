import '../models/translate_language.dart';

abstract class TranslateService {
  Future<String> translate({
    required String text,
    required TranslateLanguage targetLanguage,
  });
}
