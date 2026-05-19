import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/pdf_assistant_session_model.dart';

class PdfAssistantStorageService {
  static const _rootFolder = 'pdf_assistant';

  Future<Directory> sessionDirectory(String sessionId) async {
    final root = await _rootDirectory();
    final dir = Directory(p.join(root.path, sessionId));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<String> saveOriginal({
    required String sessionId,
    required String sourcePath,
  }) async {
    final dir = await sessionDirectory(sessionId);
    final dest = p.join(dir.path, 'original.pdf');
    await File(sourcePath).copy(dest);
    return dest;
  }

  Future<PdfAssistantSessionModel> saveMetadata(
    PdfAssistantSessionModel session,
  ) async {
    final dir = await sessionDirectory(session.id);
    final file = File(p.join(dir.path, 'metadata.json'));
    await file.writeAsString(jsonEncode(session.toJson()));
    return session;
  }

  Future<PdfAssistantSessionModel?> loadMetadata(String sessionId) async {
    final dir = await sessionDirectory(sessionId);
    final file = File(p.join(dir.path, 'metadata.json'));
    if (!await file.exists()) return null;
    final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    return PdfAssistantSessionModel.fromJson(json);
  }

  Future<void> deleteSession(String sessionId) async {
    final dir = Directory(
      p.join((await _rootDirectory()).path, sessionId),
    );
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  String displayNameFromPath(String path) {
    final base = p.basename(path);
    if (base.toLowerCase().endsWith('.pdf')) {
      return base.substring(0, base.length - 4);
    }
    return base;
  }

  Future<int?> fileSizeBytes(String path) async {
    final file = File(path);
    if (!await file.exists()) return null;
    return file.length();
  }

  String formatFileSize(int? bytes) {
    if (bytes == null) return '';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<Directory> _rootDirectory() async {
    final docs = await getApplicationDocumentsDirectory();
    final root = Directory(p.join(docs.path, _rootFolder));
    if (!await root.exists()) {
      await root.create(recursive: true);
    }
    return root;
  }
}
