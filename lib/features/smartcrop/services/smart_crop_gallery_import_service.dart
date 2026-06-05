import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class _GalleryImportJob {
  const _GalleryImportJob({
    required this.sourcePath,
    required this.dirPath,
    required this.index,
    required this.stamp,
  });

  final String sourcePath;
  final String dirPath;
  final int index;
  final int stamp;
}

String? _importGalleryImageInIsolate(_GalleryImportJob job) {
  final source = File(job.sourcePath);
  if (!source.existsSync()) return null;

  final bytes = source.readAsBytesSync();
  if (bytes.isEmpty) return null;

  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;

  final oriented = img.bakeOrientation(decoded);
  final jpgBytes = img.encodeJpg(oriented, quality: 95);

  final destPath =
      p.join(job.dirPath, 'gallery_${job.stamp}_${job.index}.jpg');
  File(destPath).writeAsBytesSync(jpgBytes, flush: true);
  return destPath;
}

/// Copies gallery picks into app storage as oriented JPEGs (stable paths).
class SmartCropGalleryImportService {
  static const _allowedExt = {
    '.jpg',
    '.jpeg',
    '.png',
    '.webp',
    '.heic',
    '.heif',
  };

  Future<List<String>> importImages(List<String> sourcePaths) async {
    if (sourcePaths.isEmpty) return [];

    final dir = await _importDirectory();
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final results = <String>[];

    for (var i = 0; i < sourcePaths.length; i++) {
      final imported = await compute(
        _importGalleryImageInIsolate,
        _GalleryImportJob(
          sourcePath: sourcePaths[i],
          dirPath: dir.path,
          index: i,
          stamp: stamp,
        ),
      );
      if (imported != null) results.add(imported);
    }

    return results;
  }

  Future<Directory> _importDirectory() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'smart_crop_import'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  static bool hasSupportedExtension(String path) {
    final ext = p.extension(path).toLowerCase();
    return _allowedExt.contains(ext);
  }
}
