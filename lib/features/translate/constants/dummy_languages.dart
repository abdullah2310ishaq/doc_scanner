import '../../../core/utils/translate_lang_names.dart';
import '../../../language_model.dart';
import '../../../l10n/app_localizations.dart';
import '../models/translate_language.dart';

abstract final class DummyLanguages {
  static List<TranslateLanguage> all(AppLocalizations l10n) {
    return languages
        .map(
          (language) => TranslateLanguage(
            code: language.code,
            name: translateLangDisplayName(l10n, language.code),
          ),
        )
        .toList();
  }
}
