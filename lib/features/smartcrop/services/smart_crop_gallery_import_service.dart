import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/smart_crop_gallery_import_result.dart';

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

const _maxImportEdge = 3000;

String? _importGalleryImageInIsolate(_GalleryImportJob job) {
  final source = File(job.sourcePath);
  if (!source.existsSync()) return null;

  final bytes = source.readAsBytesSync();
  if (bytes.isEmpty) return null;

  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;

  var oriented = img.bakeOrientation(decoded);
  final longestEdge = oriented.width > oriented.height
      ? oriented.width
      : oriented.height;
  if (longestEdge > _maxImportEdge) {
    oriented = img.copyResize(
      oriented,
      width: oriented.width >= oriented.height ? _maxImportEdge : null,
      height: oriented.height > oriented.width ? _maxImportEdge : null,
    );
  }

  final jpgBytes = img.encodeJpg(oriented, quality: 92);

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

  Future<SmartCropGalleryImportResult> importImages(
    List<String> sourcePaths, {
    void Function(int done, int total)? onProgress,
  }) async {
    if (sourcePaths.isEmpty) {
      return const SmartCropGalleryImportResult(paths: []);
    }

    final supported = <String>[];
    var unsupportedCount = 0;
    for (final path in sourcePaths) {
      if (hasSupportedExtension(path)) {
        supported.add(path);
      } else {
        unsupportedCount++;
      }
    }

    if (supported.isEmpty) {
      return SmartCropGalleryImportResult(
        paths: const [],
        unsupportedCount: unsupportedCount,
        failedCount: 0,
      );
    }

    final dir = await _importDirectory();
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final total = supported.length;
    var done = 0;

    final futures = supported.asMap().entries.map((entry) {
      final i = entry.key;
      final path = entry.value;
      return compute(
        _importGalleryImageInIsolate,
        _GalleryImportJob(
          sourcePath: path,
          dirPath: dir.path,
          index: i,
          stamp: stamp,
        ),
      ).then((importedPath) {
        done++;
        onProgress?.call(done, total);
        return importedPath;
      });
    });

    final results = await Future.wait(futures);
    final imported = results.whereType<String>().toList();

    return SmartCropGalleryImportResult(
      paths: imported,
      failedCount: total - imported.length,
      unsupportedCount: unsupportedCount,
    );
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
