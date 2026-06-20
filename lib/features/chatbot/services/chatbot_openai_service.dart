import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/config/openai_config.dart';
import '../models/chatbot_message_model.dart';

class ChatbotOpenAiService {
  ChatbotOpenAiService({http.Client? httpClient})
      : _client = httpClient ?? http.Client();

  final http.Client _client;

  static const _chatUrl = 'https://api.openai.com/v1/chat/completions';
  static const _maxDocumentChars = 12000;

  Future<String> summarizeDocument(String documentText) async {
    final trimmed = _truncate(documentText.trim());
    if (trimmed.isEmpty) {
      throw StateError('Document is empty');
    }

    return _complete(
      systemPrompt:
          'You summarize PDF documents clearly. Reply with a concise summary '
          'in 4–8 bullet points. Use plain text only.',
      userPrompt: 'Summarize this document:\n\n$trimmed',
    );
  }

  Future<String> chatReply({
    required String documentText,
    required String summary,
    required List<ChatbotMessageModel> history,
    required String userMessage,
  }) async {
    final context = _truncate(documentText.trim());
    final messages = <Map<String, String>>[
      {
        'role': 'system',
        'content':
            'You are a helpful assistant that answers only using the PDF '
            'content below. If the answer is not in the document, say you '
            'cannot find it in this PDF.\n\n'
            'Instructions for formatting:\n'
            '1. Keep your answer as short and concise as possible.\n'
            '2. Start with a short, bold-like heading on the first line summarizing the response.\n'
            '3. List any supporting details or points as short bullet points (using •) on subsequent lines.\n'
            '4. Avoid long, wordy paragraphs.\n\n'
            'Summary:\n$summary\n\n'
            'Document excerpt:\n$context',
      },
      ...history.map(
        (message) => {
          'role': message.role == ChatbotMessageRole.user ? 'user' : 'assistant',
          'content': message.content,
        },
      ),
      {'role': 'user', 'content': userMessage},
    ];

    return _completeWithMessages(messages);
  }

  Future<String> _complete({
    required String systemPrompt,
    required String userPrompt,
  }) {
    return _completeWithMessages([
      {'role': 'system', 'content': systemPrompt},
      {'role': 'user', 'content': userPrompt},
    ]);
  }

  Future<String> _completeWithMessages(
    List<Map<String, String>> messages,
  ) async {
    final apiKey = OpenAiConfig.askPdfKey;
    if (apiKey.isEmpty) {
      throw StateError('OpenAI API key is missing');
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
            'temperature': 0.3,
            'messages': messages,
          }),
        )
        .timeout(const Duration(seconds: 90));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      if (kDebugMode) {
        debugPrint('[ChatbotOpenAI] HTTP ${response.statusCode}: ${response.body}');
      }
      throw StateError('OpenAI request failed');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = body['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) {
      throw StateError('Empty OpenAI response');
    }

    final message = choices.first['message'] as Map<String, dynamic>?;
    final content = (message?['content'] as String?)?.trim();
    if (content == null || content.isEmpty) {
      throw StateError('Empty OpenAI content');
    }

    return content;
  }

  String _truncate(String text) {
    if (text.length <= _maxDocumentChars) return text;
    return '${text.substring(0, _maxDocumentChars)}\n\n[Text truncated for length]';
  }
}
