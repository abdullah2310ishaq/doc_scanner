import 'package:flutter/foundation.dart';

import '../models/chatbot_message_model.dart';
import '../models/chatbot_session_model.dart';
import '../services/chatbot_openai_service.dart';
import '../services/chatbot_storage_service.dart';

class ChatbotChatProvider extends ChangeNotifier {
  ChatbotChatProvider({
    required this.sessionId,
    ChatbotStorageService? storageService,
    ChatbotOpenAiService? openAiService,
  })  : _storageService = storageService ?? ChatbotStorageService(),
        _openAiService = openAiService ?? ChatbotOpenAiService();

  final String sessionId;
  final ChatbotStorageService _storageService;
  final ChatbotOpenAiService _openAiService;

  ChatbotSessionModel? session;
  bool isLoadingSession = true;
  bool isSending = false;
  String? errorMessage;

  List<ChatbotMessageModel> get messages => session?.messages ?? [];

  Future<void> loadSession() async {
    isLoadingSession = true;
    notifyListeners();

    session = await _storageService.getSession(sessionId);
    isLoadingSession = false;
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    final current = session;
    if (trimmed.isEmpty || current == null || isSending) return;

    isSending = true;
    errorMessage = null;
    notifyListeners();

    final userMessage = ChatbotMessageModel(
      id: '${DateTime.now().millisecondsSinceEpoch}_user',
      role: ChatbotMessageRole.user,
      content: trimmed,
      createdAt: DateTime.now(),
    );

    final history = [...current.messages, userMessage];
    session = current.copyWith(messages: history, updatedAt: DateTime.now());
    notifyListeners();

    try {
      final reply = await _openAiService.chatReply(
        documentText: current.extractedText,
        summary: current.summary,
        history: current.messages,
        userMessage: trimmed,
      );

      final assistantMessage = ChatbotMessageModel(
        id: '${DateTime.now().millisecondsSinceEpoch}_assistant',
        role: ChatbotMessageRole.assistant,
        content: reply,
        createdAt: DateTime.now(),
      );

      final updated = session!.copyWith(
        messages: [...history, assistantMessage],
        updatedAt: DateTime.now(),
      );
      session = await _storageService.saveSession(updated);
    } catch (error, stack) {
      if (kDebugMode) {
        debugPrint('[ChatbotChat] $error\n$stack');
      }
      errorMessage = error.toString();
      session = current;
    }

    isSending = false;
    notifyListeners();
  }

  String buildShareText() {
    final current = session;
    if (current == null) return '';

    final buffer = StringBuffer()
      ..writeln(current.displayName)
      ..writeln()
      ..writeln('Summary:')
      ..writeln(current.summary)
      ..writeln();

    for (final message in current.messages) {
      final label = message.role == ChatbotMessageRole.user ? 'You' : 'AI';
      buffer.writeln('$label: ${message.content}');
      buffer.writeln();
    }

    return buffer.toString().trim();
  }
}
