import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/config/openai_config.dart';

class PdfAssistantTranslateService {
  PdfAssistantTranslateService({http.Client? httpClient})
      : _client = httpClient ?? http.Client();

  final http.Client _client;
  static const _chatUrl = 'https://api.openai.com/v1/chat/completions';
  static const _chunkSize = 3500;

  Future<String> translateText({
    required String text,
    required String targetLanguageName,
    required String targetLanguageCode,
  }) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return '';

    if (trimmed.length <= _chunkSize) {
      return _translateChunk(trimmed, targetLanguageName, targetLanguageCode);
    }

    final chunks = _splitChunks(trimmed);
    final translatedChunks = <String>[];
    for (final chunk in chunks) {
      translatedChunks.add(
        await _translateChunk(chunk, targetLanguageName, targetLanguageCode),
      );
    }
    return translatedChunks.join('\n\n');
  }

  Future<List<String>> translatePages({
    required List<String> pageTexts,
    required String targetLanguageName,
    required String targetLanguageCode,
  }) async {
    final translated = <String>[];
    for (final page in pageTexts) {
      if (page.trim().isEmpty) {
        translated.add('');
        continue;
      }
      translated.add(
        await translateText(
          text: page,
          targetLanguageName: targetLanguageName,
          targetLanguageCode: targetLanguageCode,
        ),
      );
    }
    return translated;
  }

  List<String> _splitChunks(String text) {
    final chunks = <String>[];
    var start = 0;
    while (start < text.length) {
      final end = (start + _chunkSize < text.length)
          ? start + _chunkSize
          : text.length;
      chunks.add(text.substring(start, end));
      start = end;
    }
    return chunks;
  }

  Future<String> _translateChunk(
    String text,
    String targetLanguageName,
    String targetLanguageCode,
  ) async {
    final apiKey = OpenAiConfig.apiKey;
    if (apiKey.isEmpty) {
      throw StateError('missing_api_key');
    }

    final response = await _client
        .post(
          Uri.parse(_chatUrl),
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
                    'You translate document text accurately. Reply with only '
                    'the translated text, preserving paragraphs.',
              },
              {
                'role': 'user',
                'content':
                    'Detect the source language and translate to '
                    '$targetLanguageName ($targetLanguageCode):\n\n$text',
              },
            ],
          }),
        )
        .timeout(const Duration(seconds: 90));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      if (kDebugMode) {
        debugPrint('[PdfAssistantTranslate] ${response.statusCode}');
      }
      throw StateError('translate_failed');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = body['choices'] as List<dynamic>?;
    final message = choices?.first['message'] as Map<String, dynamic>?;
    final content = (message?['content'] as String?)?.trim();
    if (content == null || content.isEmpty) {
      throw StateError('translate_failed');
    }
    return content;
  }
}
