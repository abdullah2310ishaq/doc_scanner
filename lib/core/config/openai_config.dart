import '../services/remote_config_service.dart';
import 'secrets_local.dart';

abstract final class OpenAiConfig {
  static String get pdfTranslationKey {
    const fromEnv = String.fromEnvironment('PDF_TRANSLATION_KEY');
    if (fromEnv.isNotEmpty) return fromEnv;
    final remote = RemoteConfigService.pdfTranslationKey;
    if (remote.isNotEmpty) return remote;
    return pdfTranslationKeyFallback;
  }

  static String get askPdfKey {
    const fromEnv = String.fromEnvironment('ASK_PDF_KEY');
    if (fromEnv.isNotEmpty) return fromEnv;
    final remote = RemoteConfigService.askPdfKey;
    if (remote.isNotEmpty) return remote;
    return askPdfKeyFallback;
  }

  static String get ocrTranslationKey {
    const fromEnv = String.fromEnvironment('OCR_TRANSLATION_KEY');
    if (fromEnv.isNotEmpty) return fromEnv;
    final remote = RemoteConfigService.ocrTranslationKey;
    if (remote.isNotEmpty) return remote;
    return ocrTranslationKeyFallback;
  }

  static const String model = String.fromEnvironment(
    'OPENAI_MODEL',
    defaultValue: 'gpt-5.4-mini',
  );
}
