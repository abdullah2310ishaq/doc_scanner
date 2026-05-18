import '../../../language_model.dart';
import '../models/translate_language.dart';

abstract final class DummyLanguages {
  static final List<TranslateLanguage> all = languages
      .map(
        (language) => TranslateLanguage(code: language.code, name: language.name),
      )
      .toList();
}
