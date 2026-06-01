import 'dart:io';
import 'dart:isolate';

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../models/smart_crop_page_model.dart';
import 'smart_crop_edge_detect_service.dart' show detectDocumentCorners;
import 'smart_crop_image_trim.dart';
import 'smart_crop_perspective_warp.dart';

class _CropJob {
  _CropJob({required this.page, required this.tempDir});

  final SmartCropPageModel page;
  final String tempDir;
}

String _saveJpg(img.Image image, String tempDir) {
  final trimmed = trimDocumentMargins(image);
  final outBytes = img.encodeJpg(trimmed, quality: 95);
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final outputPath = '$tempDir/cropped_$timestamp.jpg';
  File(outputPath).writeAsBytesSync(outBytes);
  return outputPath;
}

String _cropPageInIsolate(_CropJob job) {
  final page = job.page;
  final file = File(page.imagePath);
  if (!file.existsSync()) {
    throw Exception('Source file does not exist: ${page.imagePath}');
  }

  final bytes = file.readAsBytesSync();
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw Exception('Failed to decode image file');
  }

  final oriented = img.bakeOrientation(decoded);

  final cropped = warpDocument(
    oriented,
    tlX: page.topLeft.dx,
    tlY: page.topLeft.dy,
    trX: page.topRight.dx,
    trY: page.topRight.dy,
    brX: page.bottomRight.dx,
    brY: page.bottomRight.dy,
    blX: page.bottomLeft.dx,
    blY: page.bottomLeft.dy,
  );

  return _saveJpg(cropped, job.tempDir);
}

/// Smart crop: detect paper edges → perspective warp → trim white margins.
class SmartCropCropService {
  Future<String> cropPage(SmartCropPageModel page) async {
    if (page.isAlreadyScanned) {
      return page.imagePath;
    }

    // 1. Edge detection main thread par hi handle karein (Safe for Native ML Kit Plugins)
    SmartCropPageModel finalPageConfig = page;
    if (!page.cornersLocked) {
      final detected = detectDocumentCorners(page.imagePath);
      finalPageConfig = page.copyWith(
        topLeft: detected.topLeft,
        topRight: detected.topRight,
        bottomRight: detected.bottomRight,
        bottomLeft: detected.bottomLeft,
      );
    }

    final tempDir = await getTemporaryDirectory();
    return Isolate.run(
      () => _cropPageInIsolate(_CropJob(page: finalPageConfig, tempDir: tempDir.path)),
    );
  }

  Future<List<String>> cropAllPages(List<SmartCropPageModel> pages) async {
    final futures = pages.map((page) => cropPage(page)).toList();
    return await Future.wait(futures);
  }
}
