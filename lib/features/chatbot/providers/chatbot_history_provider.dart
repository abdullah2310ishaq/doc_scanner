import 'package:flutter/foundation.dart';

import '../models/chatbot_session_model.dart';
import '../services/chatbot_storage_service.dart';

class ChatbotHistoryProvider extends ChangeNotifier {
  ChatbotHistoryProvider({ChatbotStorageService? storageService})
      : _storageService = storageService ?? ChatbotStorageService();

  final ChatbotStorageService _storageService;

  List<ChatbotSessionModel> sessions = [];
  bool isLoading = false;

  Future<void> loadSessions() async {
    isLoading = true;
    notifyListeners();

    try {
      sessions = await _storageService.loadSessions();
    } catch (error, stack) {
      if (kDebugMode) {
        debugPrint('[ChatbotHistory] $error\n$stack');
      }
      sessions = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> renameSession({
    required String sessionId,
    required String newName,
  }) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;

    final index = sessions.indexWhere((s) => s.id == sessionId);
    if (index < 0) return;

    final updated = sessions[index].copyWith(
      displayName: trimmed,
      updatedAt: DateTime.now(),
    );
    await _storageService.saveSession(updated);
    sessions[index] = updated;
    notifyListeners();
  }

  Future<void> deleteSession(String sessionId) async {
    await _storageService.deleteSession(sessionId);
    sessions.removeWhere((s) => s.id == sessionId);
    notifyListeners();
  }
}
