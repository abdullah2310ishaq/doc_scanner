import '../../../language_model.dart';
import '../../translate/models/translate_language.dart';

/// Same languages as OCR / translate module (`language_model.dart`).
abstract final class PdfAssistantLanguages {
  static final List<TranslateLanguage> all = languages
      .map(
        (language) => TranslateLanguage(
          code: language.code,
          name: language.name,
        ),
      )
      .toList();
}
