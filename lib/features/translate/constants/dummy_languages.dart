import '../../../language_model.dart';
import '../models/translate_language.dart';
import '../utils/mlkit_language_mapper.dart';

abstract final class DummyLanguages {
  static final List<TranslateLanguage> all = languages
      .map(
        (language) => TranslateLanguage(code: language.code, name: language.name),
      )
      .where((language) => MlKitLanguageMapper.isSupported(language.code))
      .toList();
}
