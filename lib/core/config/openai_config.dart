import 'secrets_local.dart';

abstract final class OpenAiConfig {
  static String get apiKey {
    const fromEnv = String.fromEnvironment('OPENAI_API_KEY');
    if (fromEnv.isNotEmpty) return fromEnv;
    return openAiApiKey;
  }

  static const String model = String.fromEnvironment(
    'OPENAI_MODEL',
    defaultValue: 'gpt-5.4-mini',
  );
}
