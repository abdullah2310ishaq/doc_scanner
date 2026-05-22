import 'dart:io';

import 'package:path/path.dart' as p;

/// Rename or delete smart-crop PDF files on device.
class SmartCropPdfFileService {
  Future<String> renamePdf({
    required String pdfPath,
    required String newBaseName,
  }) async {
    final trimmed = newBaseName.trim();
    if (trimmed.isEmpty) {
      throw StateError('empty_name');
    }

    final file = File(pdfPath);
    if (!await file.exists()) {
      throw StateError('file_missing');
    }

    final safeName = trimmed.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
    final newPath = p.join(
      p.dirname(pdfPath),
      '$safeName${p.extension(pdfPath)}',
    );

    if (newPath == pdfPath) return pdfPath;

    final renamed = await file.rename(newPath);
    return renamed.path;
  }

  Future<void> deletePdf(String pdfPath) async {
    final file = File(pdfPath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
