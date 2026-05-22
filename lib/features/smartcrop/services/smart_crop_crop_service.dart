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

SmartCropPageModel _pageWithDetectedCorners(SmartCropPageModel page) {
  final detected = detectDocumentCorners(page.imagePath);
  return page.copyWith(
    topLeft: detected.topLeft,
    topRight: detected.topRight,
    bottomRight: detected.bottomRight,
    bottomLeft: detected.bottomLeft,
  );
}

String _cropPageInIsolate(_CropJob job) {
  final page = job.page;
  final file = File(page.imagePath);
  if (!file.existsSync()) {
    throw Exception('Source file does not exist');
  }

  final bytes = file.readAsBytesSync();
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw Exception('Failed to decode image file');
  }

  final oriented = img.bakeOrientation(decoded);

  if (page.isAlreadyScanned) {
    return _saveJpg(oriented, job.tempDir);
  }

  final corners = page.cornersLocked
      ? page
      : _pageWithDetectedCorners(page);

  final cropped = warpDocument(
    oriented,
    tlX: corners.topLeft.dx,
    tlY: corners.topLeft.dy,
    trX: corners.topRight.dx,
    trY: corners.topRight.dy,
    brX: corners.bottomRight.dx,
    brY: corners.bottomRight.dy,
    blX: corners.bottomLeft.dx,
    blY: corners.bottomLeft.dy,
  );

  return _saveJpg(cropped, job.tempDir);
}

/// Smart crop: detect paper edges → perspective warp → trim white margins.
class SmartCropCropService {
  Future<String> cropPage(SmartCropPageModel page) async {
    final tempDir = await getTemporaryDirectory();
    return Isolate.run(
      () => _cropPageInIsolate(_CropJob(page: page, tempDir: tempDir.path)),
    );
  }

  Future<List<String>> cropAllPages(List<SmartCropPageModel> pages) async {
    final results = <String>[];
    for (final page in pages) {
      results.add(await cropPage(page));
    }
    return results;
  }
}
