import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/chatbot_session_model.dart';

/// Saves chat sessions and PDF copies on device.
class ChatbotStorageService {
  static const _sessionsFileName = 'chatbot_sessions.json';
  static const _pdfFolderName = 'chatbot_pdfs';

  Future<List<ChatbotSessionModel>> loadSessions() async {
    final file = await _sessionsFile();
    if (!await file.exists()) {
      return [];
    }

    final raw = await file.readAsString();
    if (raw.trim().isEmpty) {
      return [];
    }

    final list = jsonDecode(raw) as List<dynamic>;
    final sessions = list
        .map((item) => ChatbotSessionModel.fromJson(item as Map<String, dynamic>))
        .toList();
    sessions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return sessions;
  }

  Future<ChatbotSessionModel?> getSession(String sessionId) async {
    final sessions = await loadSessions();
    for (final session in sessions) {
      if (session.id == sessionId) {
        return session;
      }
    }
    return null;
  }

  Future<ChatbotSessionModel> saveSession(ChatbotSessionModel session) async {
    final sessions = await loadSessions();
    final index = sessions.indexWhere((s) => s.id == session.id);
    if (index >= 0) {
      sessions[index] = session;
    } else {
      sessions.add(session);
    }
    await _writeSessions(sessions);
    return session;
  }

  Future<void> deleteSession(String sessionId) async {
    final sessions = await loadSessions();
    ChatbotSessionModel? removed;
    sessions.removeWhere((session) {
      if (session.id == sessionId) {
        removed = session;
        return true;
      }
      return false;
    });
    await _writeSessions(sessions);

    final pdfPath = removed?.pdfPath;
    if (pdfPath != null) {
      final file = File(pdfPath);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  Future<String> copyPdfToAppStorage({
    required String sourcePath,
    required String sessionId,
  }) async {
    final dir = await _pdfDirectory();
    final fileName = '$sessionId.pdf';
    final destPath = p.join(dir.path, fileName);
    await File(sourcePath).copy(destPath);
    return destPath;
  }

  String displayNameFromPath(String path) {
    final baseName = p.basename(path);
    if (baseName.toLowerCase().endsWith('.pdf')) {
      return baseName.substring(0, baseName.length - 4);
    }
    return baseName;
  }

  Future<File> _sessionsFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, _sessionsFileName));
  }

  Future<Directory> _pdfDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final pdfDir = Directory(p.join(dir.path, _pdfFolderName));
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }
    return pdfDir;
  }

  Future<void> _writeSessions(List<ChatbotSessionModel> sessions) async {
    final file = await _sessionsFile();
    final encoded = jsonEncode(sessions.map((s) => s.toJson()).toList());
    await file.writeAsString(encoded);
  }
}
