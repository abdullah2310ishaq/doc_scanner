import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:ui' show Offset;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../models/smart_crop_page_model.dart';
import 'smart_crop_edge_detect_service.dart' show detectDocumentCornersFlat;
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

bool _isNearRectangularAndLarge(SmartCropPageModel page) {
  final xs = [
    page.topLeft.dx,
    page.topRight.dx,
    page.bottomRight.dx,
    page.bottomLeft.dx,
  ];
  final ys = [
    page.topLeft.dy,
    page.topRight.dy,
    page.bottomRight.dy,
    page.bottomLeft.dy,
  ];
  final minX = xs.reduce(math.min);
  final maxX = xs.reduce(math.max);
  final minY = ys.reduce(math.min);
  final maxY = ys.reduce(math.max);

  final area = (maxX - minX) * (maxY - minY);
  if (area < 0.75) return false;

  const tol = 0.03;
  final topAligned = (page.topLeft.dy - page.topRight.dy).abs() < tol;
  final bottomAligned = (page.bottomLeft.dy - page.bottomRight.dy).abs() < tol;
  final leftAligned = (page.topLeft.dx - page.bottomLeft.dx).abs() < tol;
  final rightAligned = (page.topRight.dx - page.bottomRight.dx).abs() < tol;

  return topAligned && bottomAligned && leftAligned && rightAligned;
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

  // Flat scans / screenshots: avoid heavy homography warping; crop bbox + trim.
  if (_isNearRectangularAndLarge(page)) {
    final w = oriented.width;
    final h = oriented.height;
    final xs = [
      page.topLeft.dx,
      page.topRight.dx,
      page.bottomRight.dx,
      page.bottomLeft.dx,
    ];
    final ys = [
      page.topLeft.dy,
      page.topRight.dy,
      page.bottomRight.dy,
      page.bottomLeft.dy,
    ];
    final minX = xs.reduce(math.min);
    final maxX = xs.reduce(math.max);
    final minY = ys.reduce(math.min);
    final maxY = ys.reduce(math.max);

    final left = (minX * w).floor().clamp(0, w - 1);
    final right = (maxX * w).ceil().clamp(left + 1, w);
    final top = (minY * h).floor().clamp(0, h - 1);
    final bottom = (maxY * h).ceil().clamp(top + 1, h);

    final cropped = img.copyCrop(
      oriented,
      x: left,
      y: top,
      width: right - left,
      height: bottom - top,
    );
    return _saveJpg(cropped, job.tempDir);
  }

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

class SmartCropCropService {
  Future<String> cropPage(SmartCropPageModel page) async {
    if (page.isAlreadyScanned) {
      return page.imagePath;
    }

    SmartCropPageModel finalPageConfig = page;
    if (!page.cornersLocked) {
      final flat = await compute(detectDocumentCornersFlat, page.imagePath);
      finalPageConfig = page.copyWith(
        topLeft: Offset(flat[0], flat[1]),
        topRight: Offset(flat[2], flat[3]),
        bottomRight: Offset(flat[4], flat[5]),
        bottomLeft: Offset(flat[6], flat[7]),
      );
    }

    final tempDir = await getTemporaryDirectory();
    return Isolate.run(
      () => _cropPageInIsolate(
        _CropJob(page: finalPageConfig, tempDir: tempDir.path),
      ),
    );
  }

  Future<List<String>> cropAllPages(List<SmartCropPageModel> pages) async {
    final futures = pages.map((page) => cropPage(page)).toList();
    return await Future.wait(futures);
  }
}
