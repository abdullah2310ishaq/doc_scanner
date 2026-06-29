import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/config/openai_config.dart';
import '../models/translate_language.dart';
import 'translate_errors.dart';
import 'translate_service.dart';

class OpenAiTranslateService implements TranslateService {
  OpenAiTranslateService({
    http.Client? httpClient,
    this.defaultSourceLanguageCode = 'en',
  }) : _client = httpClient ?? http.Client();

  final http.Client _client;
  final String defaultSourceLanguageCode;

  static const _chatCompletionsUrl = 'https://api.deepseek.com/chat/completions';

  @override
  Future<String> translate({
    required String text,
    required TranslateLanguage targetLanguage,
    String? sourceLanguageCode,
  }) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      _log('Skipped — empty text');
      return '';
    }

    final apiKey = OpenAiConfig.ocrTranslationKey;
    if (apiKey.isEmpty) {
      _log('Missing API key — set secrets_local.dart or OCR_TRANSLATION_KEY');
      throw const TranslateException(TranslateFailure.translationFailed);
    }

    final sourceCode = sourceLanguageCode ?? defaultSourceLanguageCode;
    if (sourceCode == targetLanguage.code) {
      _log('Source and target are the same — returning original text');
      return trimmed;
    }

    _log(
      'Request — $sourceCode → ${targetLanguage.code} (${targetLanguage.name}), '
      'model: ${OpenAiConfig.model}, chars: ${trimmed.length}',
    );

    try {
      final startedAt = DateTime.now();
      final response = await _client
          .post(
            Uri.parse(_chatCompletionsUrl),
            headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'model': OpenAiConfig.model,
              'temperature': 0.2,
              'messages': [
                {
                  'role': 'system',
                  'content':
                      'You translate text accurately. Reply with only the translated text, '
                      'no quotes or explanations.',
                },
                {
                  'role': 'user',
                  'content':
                      'Detect the source language of the text below, then translate it '
                      'into ${targetLanguage.name} (${targetLanguage.code}). '
                      'Preserve meaning, names, and line breaks.\n\n$trimmed',
                },
              ],
            }),
          )
          .timeout(const Duration(seconds: 60));

      final ms = DateTime.now().difference(startedAt).inMilliseconds;

      if (response.statusCode < 200 || response.statusCode >= 300) {
        _log('HTTP ${response.statusCode} — ${response.body}');
        throw const TranslateException(TranslateFailure.translationFailed);
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final choices = body['choices'] as List<dynamic>?;
      if (choices == null || choices.isEmpty) {
        _log('No choices in response');
        throw const TranslateException(TranslateFailure.translationFailed);
      }

      final message = choices.first['message'] as Map<String, dynamic>?;
      final content = (message?['content'] as String?)?.trim();
      if (content == null || content.isEmpty) {
        _log('Empty translation content');
        throw const TranslateException(TranslateFailure.translationFailed);
      }

      _log('OpenAI done in ${ms}ms — preview: ${_preview(content)}');
      return content;
    } on TranslateException {
      rethrow;
    } catch (error, stack) {
      _log('OpenAI error — $error\n$stack');
      throw const TranslateException(TranslateFailure.translationFailed);
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[OpenAiTranslate] $message');
    }
  }

  String _preview(String text, [int max = 80]) {
    if (text.length <= max) return text;
    return '${text.substring(0, max)}…';
  }
}
