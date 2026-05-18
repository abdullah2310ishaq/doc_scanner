import '../models/translate_language.dart';
import 'translate_service.dart';

class DummyTranslateService implements TranslateService {
  @override
  Future<String> translate({
    required String text,
    required TranslateLanguage targetLanguage,
    String? sourceLanguageCode,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (text.trim().isEmpty) return '';
    return '[${targetLanguage.name}] $text';
  }
}
