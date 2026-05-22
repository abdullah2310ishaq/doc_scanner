import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/recent_file_model.dart';

/// All recent PDFs and images live under [recentDocumentsRoot] only.
class RecentDocumentsService {
  static const recentDocumentsRoot = 'recent_documents';
  static const _prefsKey = 'recent_documents_v2';
  static const _pdfFolder = '$recentDocumentsRoot/pdfs';
  static const _imageFolder = '$recentDocumentsRoot/images';

  static final _pdfExtensions = {'.pdf'};
  static final _imageExtensions = {'.jpg', '.jpeg', '.png', '.webp'};

  Future<String> get recentRootPath async {
    final docs = await getApplicationDocumentsDirectory();
    return p.join(docs.path, recentDocumentsRoot);
  }

  Future<List<RecentFileModel>> loadPdfs() async {
    final all = await _loadMerged();
    return all.where((f) => f.type == RecentFileType.pdf).toList()
      ..sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
  }

  Future<List<RecentFileModel>> loadImages() async {
    final all = await _loadMerged();
    return all.where((f) => f.type == RecentFileType.image).toList()
      ..sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
  }

  /// Copies [sourcePath] into `recent_documents/pdfs/` (unless already there).
  Future<void> registerPdf(String sourcePath, {String? displayName}) async {
    final file = File(sourcePath);
    if (!await file.exists()) return;

    if (_isInPdfFolder(sourcePath)) {
      await _upsert(_fromFile(sourcePath, RecentFileType.pdf));
      return;
    }

    final destDir = await _pdfDirectory();
    final base = displayName ?? p.basenameWithoutExtension(sourcePath);
    final safe = _safeName(base);
    var destPath = p.join(destDir.path, '$safe.pdf');
    destPath = await _uniquePath(destPath);

    await file.copy(destPath);
    await _upsert(_fromFile(destPath, RecentFileType.pdf, displayName: safe));
  }

  /// Copies [sourcePath] into `recent_documents/images/` (unless already there).
  Future<void> registerImage(String sourcePath, {String? displayName}) async {
    final file = File(sourcePath);
    if (!await file.exists()) return;

    final ext = p.extension(sourcePath).toLowerCase();
    if (!_imageExtensions.contains(ext)) return;

    if (_isInImageFolder(sourcePath)) {
      await _upsert(_fromFile(sourcePath, RecentFileType.image));
      return;
    }

    final destDir = await _imageDirectory();
    final base = displayName ?? p.basenameWithoutExtension(sourcePath);
    final safe = _safeName(base);
    var destPath = p.join(destDir.path, '$safe$ext');
    destPath = await _uniquePath(destPath);

    await file.copy(destPath);
    await _upsert(_fromFile(destPath, RecentFileType.image, displayName: safe));
  }

  Future<String?> renameFile(RecentFileModel file, String newBaseName) async {
    if (!_isUnderRecentFolder(file.path)) return null;

    final trimmed = newBaseName.trim();
    if (trimmed.isEmpty) return null;

    final safe = _safeName(trimmed);
    final ext = p.extension(file.path);
    final newPath = p.join(p.dirname(file.path), '$safe$ext');
    if (newPath == file.path) return file.path;

    final uniquePath = await _uniquePath(newPath, skipPath: file.path);
    final renamed = await File(file.path).rename(uniquePath);
    final updated = file.copyWith(
      path: renamed.path,
      displayName: safe,
      modifiedAt: await renamed.lastModified(),
    );
    await _upsert(updated);
    return renamed.path;
  }

  Future<void> deleteFile(RecentFileModel file) async {
    if (_isUnderRecentFolder(file.path)) {
      final f = File(file.path);
      if (await f.exists()) {
        await f.delete();
      }
    }
    final prefs = await SharedPreferences.getInstance();
    final list = await _readIndex(prefs);
    list.removeWhere((e) => e.id == file.id || e.path == file.path);
    await _writeIndex(prefs, list);
  }

  Future<void> setFavorite(RecentFileModel file, bool value) async {
    await _upsert(file.copyWith(isFavorite: value));
  }

  static String formatMeta(
    DateTime date,
    int sizeBytes,
    AppLocalizations l10n,
  ) {
    final datePart = DateFormat.yMMMd(l10n.localeName).format(date);
    return '$datePart • ${formatSize(sizeBytes, l10n)}';
  }

  static String formatSize(int bytes, AppLocalizations l10n) {
    if (bytes < 1024) {
      return l10n.fileSizeBytes('$bytes');
    }
    if (bytes < 1024 * 1024) {
      return l10n.fileSizeKb(
        (bytes / 1024).toStringAsFixed(1),
      );
    }
    return l10n.fileSizeMb(
      (bytes / (1024 * 1024)).toStringAsFixed(1),
    );
  }

  Future<List<RecentFileModel>> _loadMerged() async {
    await _ensureFoldersExist();

    final prefs = await SharedPreferences.getInstance();
    final indexed = await _readIndex(prefs);
    final discovered = await _discoverRecentFolderOnly();

    final byPath = <String, RecentFileModel>{};

    for (final file in discovered) {
      byPath[file.path] = file;
    }

    for (final file in indexed) {
      if (!await File(file.path).exists()) continue;
      if (_isUnderRecentFolder(file.path)) {
        byPath[file.path] = file;
      }
    }

    final merged = byPath.values.toList()
      ..sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));

    await _writeIndex(prefs, merged);
    return merged;
  }

  /// Reads only `recent_documents/pdfs` and `recent_documents/images`.
  Future<List<RecentFileModel>> _discoverRecentFolderOnly() async {
    final results = <RecentFileModel>[];
    final pdfDir = await _pdfDirectory();
    final imageDir = await _imageDirectory();

    await _collectFiles(pdfDir, RecentFileType.pdf, results);
    await _collectFiles(imageDir, RecentFileType.image, results);

    return results;
  }

  Future<void> _collectFiles(
    Directory dir,
    RecentFileType type,
    List<RecentFileModel> out,
  ) async {
    if (!await dir.exists()) return;
    await for (final entity in dir.list(followLinks: false)) {
      if (entity is! File) continue;
      final ext = p.extension(entity.path).toLowerCase();
      final ok = type == RecentFileType.pdf
          ? _pdfExtensions.contains(ext)
          : _imageExtensions.contains(ext);
      if (ok) {
        out.add(_fromFile(entity.path, type));
      }
    }
  }

  Future<void> _ensureFoldersExist() async {
    await _pdfDirectory();
    await _imageDirectory();
  }

  String _normalizePath(String path) {
    return p.normalize(path).replaceAll(r'\', '/');
  }

  bool _isUnderRecentFolder(String path) {
    final n = _normalizePath(path);
    return n.contains('/$_pdfFolder/') ||
        n.contains('/$_imageFolder/') ||
        n.endsWith('/$_pdfFolder') ||
        n.endsWith('/$_imageFolder');
  }

  bool _isInPdfFolder(String path) {
    final n = _normalizePath(path);
    return n.contains('/$_pdfFolder/') || n.endsWith('/$_pdfFolder');
  }

  bool _isInImageFolder(String path) {
    final n = _normalizePath(path);
    return n.contains('/$_imageFolder/') || n.endsWith('/$_imageFolder');
  }

  RecentFileModel _fromFile(
    String path,
    RecentFileType type, {
    String? displayName,
  }) {
    final file = File(path);
    final stat = file.statSync();
    final base = displayName ?? p.basenameWithoutExtension(path);
    return RecentFileModel(
      id: path,
      path: path,
      displayName: base,
      type: type,
      sizeBytes: stat.size,
      modifiedAt: stat.modified,
    );
  }

  Future<void> _upsert(RecentFileModel file) async {
    if (!_isUnderRecentFolder(file.path)) return;

    final prefs = await SharedPreferences.getInstance();
    final list = await _readIndex(prefs);
    list.removeWhere((e) => e.path == file.path);
    list.insert(0, file);
    await _writeIndex(prefs, list);
  }

  Future<List<RecentFileModel>> _readIndex(SharedPreferences prefs) async {
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => RecentFileModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('[RecentDocuments] index parse failed: $e');
      return [];
    }
  }

  Future<void> _writeIndex(
    SharedPreferences prefs,
    List<RecentFileModel> files,
  ) async {
    final inFolder =
        files.where((f) => _isUnderRecentFolder(f.path)).toList();
    final encoded = jsonEncode(inFolder.map((f) => f.toJson()).toList());
    await prefs.setString(_prefsKey, encoded);
  }

  Future<Directory> _pdfDirectory() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, _pdfFolder));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<Directory> _imageDirectory() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, _imageFolder));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  String _safeName(String name) {
    return name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_').trim();
  }

  Future<String> _uniquePath(String path, {String? skipPath}) async {
    if (path == skipPath) return path;
    if (!await File(path).exists()) return path;
    final dir = p.dirname(path);
    final ext = p.extension(path);
    final base = p.basenameWithoutExtension(path);
    var i = 1;
    while (true) {
      final candidate = p.join(dir, '${base}_$i$ext');
      if (candidate == skipPath || !await File(candidate).exists()) {
        return candidate;
      }
      i++;
    }
  }
}
