import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class TranslateExportStorage {
  static final MediaStore _mediaStore = MediaStore();

  static Future<String> saveBytes({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = p.join(tempDir.path, fileName);
    await File(tempPath).writeAsBytes(bytes);

    if (Platform.isAndroid) {
      try {
        final saveInfo = await _mediaStore.saveFile(
          tempFilePath: tempPath,
          dirType: DirType.download,
          dirName: DirName.download,
        );

        if (saveInfo != null) {
          final savedPath = await _mediaStore.getFilePathFromUri(
            uriString: saveInfo.uri.toString(),
          );
          return savedPath ?? 'Download/${MediaStore.appFolder}/$fileName';
        }
      } catch (error, stack) {
        if (kDebugMode) {
          debugPrint('[TranslateExportStorage] MediaStore failed: $error\n$stack');
        }
      }

      return _saveToAppExternal(bytes, fileName, tempPath);
    }

    final downloadsDir = await getDownloadsDirectory();
    if (downloadsDir != null) {
      final exportsDir = Directory(
        p.join(downloadsDir.path, MediaStore.appFolder),
      );
      if (!await exportsDir.exists()) {
        await exportsDir.create(recursive: true);
      }

      final filePath = p.join(exportsDir.path, fileName);
      await File(filePath).writeAsBytes(bytes);
      await _deleteIfExists(tempPath);
      return filePath;
    }

    return _saveToAppExternal(bytes, fileName, tempPath);
  }

  static Future<String> _saveToAppExternal(
    Uint8List bytes,
    String fileName,
    String tempPath,
  ) async {
    final externalDir = await getExternalStorageDirectory();
    if (externalDir == null) {
      throw StateError('Could not access device storage');
    }

    final exportsDir = Directory(p.join(externalDir.path, 'exports'));
    if (!await exportsDir.exists()) {
      await exportsDir.create(recursive: true);
    }

    final filePath = p.join(exportsDir.path, fileName);
    await File(filePath).writeAsBytes(bytes);
    await _deleteIfExists(tempPath);
    return filePath;
  }

  static Future<void> _deleteIfExists(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
