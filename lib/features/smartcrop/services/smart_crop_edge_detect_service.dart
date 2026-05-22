import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import '../models/smart_crop_page_model.dart';

class _DetectResult {
  _DetectResult(this.tl, this.tr, this.br, this.bl);

  final Offset tl;
  final Offset tr;
  final Offset br;
  final Offset bl;
}

/// Finds document corners from a photo (paper only — tight bounds).
class SmartCropEdgeDetectService {
  Future<SmartCropPageModel> detectCorners(SmartCropPageModel page) async {
    final corners = detectDocumentCorners(page.imagePath);
    return page.copyWith(
      topLeft: corners.topLeft,
      topRight: corners.topRight,
      bottomRight: corners.bottomRight,
      bottomLeft: corners.bottomLeft,
    );
  }
}

/// Corner detection result (normalized 0–1).
class DetectedDocumentCorners {
  const DetectedDocumentCorners({
    required this.topLeft,
    required this.topRight,
    required this.bottomRight,
    required this.bottomLeft,
  });

  final Offset topLeft;
  final Offset topRight;
  final Offset bottomRight;
  final Offset bottomLeft;
}

DetectedDocumentCorners detectDocumentCorners(String imagePath) {
  final result = _detectPaperQuad(imagePath);
  return DetectedDocumentCorners(
    topLeft: result.tl,
    topRight: result.tr,
    bottomRight: result.br,
    bottomLeft: result.bl,
  );
}

_DetectResult _fallbackQuad() {
  return _DetectResult(
    const Offset(0.04, 0.04),
    const Offset(0.96, 0.04),
    const Offset(0.96, 0.96),
    const Offset(0.04, 0.96),
  );
}

_DetectResult _detectPaperQuad(String imagePath) {
  final fallback = _fallbackQuad();

  final file = File(imagePath);
  if (!file.existsSync()) return fallback;

  final bytes = file.readAsBytesSync();
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return fallback;

  final oriented = img.bakeOrientation(decoded);
  const maxWidth = 1000;
  final scale = oriented.width > maxWidth ? maxWidth / oriented.width : 1.0;
  final scaled = scale < 1
      ? img.copyResize(oriented, width: maxWidth)
      : oriented;

  final gray = img.grayscale(scaled);
  final blurred = img.gaussianBlur(gray, radius: 3);

  final paperBounds = _findPaperBounds(blurred);
  if (paperBounds == null) {
    return _quadFromEdgePoints(blurred) ?? fallback;
  }

  final refined = _refineCornersInBounds(blurred, paperBounds);
  return _normalizeQuad(scaled.width, scaled.height, refined);
}

/// Largest bright/dark paper region — primary detector for uploads.
_PaperBounds? _findPaperBounds(img.Image gray) {
  final w = gray.width;
  final h = gray.height;
  final total = w * h;

  var sumLum = 0.0;
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      sumLum += gray.getPixel(x, y).luminance;
    }
  }
  final mean = sumLum / total;
  final paperIsBright = mean > 120;

  final threshold = paperIsBright ? mean - 25 : mean + 35;

  bool isPaper(int x, int y) {
    final lum = gray.getPixel(x, y).luminance;
    return paperIsBright ? lum > threshold : lum < threshold;
  }

  var left = w;
  var right = 0;
  var top = h;
  var bottom = 0;
  var paperCount = 0;

  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      if (isPaper(x, y)) {
        paperCount++;
        if (x < left) left = x;
        if (x > right) right = x;
        if (y < top) top = y;
        if (y > bottom) bottom = y;
      }
    }
  }

  if (paperCount < total * 0.08) return null;
  if (right <= left + 8 || bottom <= top + 8) return null;

  final areaRatio = (right - left + 1) * (bottom - top + 1) / total;
  if (areaRatio < 0.12 || areaRatio > 0.98) return null;

  const shrink = 2;
  left = (left + shrink).clamp(0, w - 1);
  right = (right - shrink).clamp(0, w - 1);
  top = (top + shrink).clamp(0, h - 1);
  bottom = (bottom - shrink).clamp(0, h - 1);

  return _PaperBounds(left, top, right, bottom);
}

class _PaperBounds {
  _PaperBounds(this.left, this.top, this.right, this.bottom);

  final int left;
  final int top;
  final int right;
  final int bottom;
}

/// Refine quad using edge points inside the paper bounding box.
_DetectQuad _refineCornersInBounds(img.Image gray, _PaperBounds bounds) {
  final edgePoints = <math.Point<int>>[];

  for (var y = bounds.top + 1; y < bounds.bottom - 1; y++) {
    for (var x = bounds.left + 1; x < bounds.right - 1; x++) {
      final gx = gray.getPixel(x + 1, y).luminance -
          gray.getPixel(x - 1, y).luminance;
      final gy = gray.getPixel(x, y + 1).luminance -
          gray.getPixel(x, y - 1).luminance;
      final mag = math.sqrt(gx * gx + gy * gy);
      if (mag > 22) {
        edgePoints.add(math.Point(x, y));
      }
    }
  }

  if (edgePoints.length >= 40) {
    var tl = edgePoints.first;
    var tr = edgePoints.first;
    var br = edgePoints.first;
    var bl = edgePoints.first;
    var minSum = double.infinity;
    var maxSum = -double.infinity;
    var maxDiff = -double.infinity;
    var minDiff = double.infinity;

    for (final p in edgePoints) {
      final sum = p.x + p.y;
      final diff = p.x - p.y;
      if (sum < minSum) {
        minSum = sum.toDouble();
        tl = p;
      }
      if (sum > maxSum) {
        maxSum = sum.toDouble();
        br = p;
      }
      if (diff > maxDiff) {
        maxDiff = diff.toDouble();
        tr = p;
      }
      if (diff < minDiff) {
        minDiff = diff.toDouble();
        bl = p;
      }
    }

    return _DetectQuad(tl, tr, br, bl);
  }

  return _DetectQuad(
    math.Point(bounds.left, bounds.top),
    math.Point(bounds.right, bounds.top),
    math.Point(bounds.right, bounds.bottom),
    math.Point(bounds.left, bounds.bottom),
  );
}

class _DetectQuad {
  _DetectQuad(this.tl, this.tr, this.br, this.bl);

  final math.Point<int> tl;
  final math.Point<int> tr;
  final math.Point<int> br;
  final math.Point<int> bl;
}

_DetectResult? _quadFromEdgePoints(img.Image gray) {
  final w = gray.width;
  final h = gray.height;
  final edgePoints = <math.Point<int>>[];

  for (var y = 1; y < h - 1; y++) {
    for (var x = 1; x < w - 1; x++) {
      final gx = gray.getPixel(x + 1, y).luminance -
          gray.getPixel(x - 1, y).luminance;
      final gy = gray.getPixel(x, y + 1).luminance -
          gray.getPixel(x, y - 1).luminance;
      final mag = math.sqrt(gx * gx + gy * gy);
      if (mag > 30) {
        edgePoints.add(math.Point(x, y));
      }
    }
  }

  if (edgePoints.length < 60) return null;

  var tl = edgePoints.first;
  var tr = edgePoints.first;
  var br = edgePoints.first;
  var bl = edgePoints.first;
  var minSum = double.infinity;
  var maxSum = -double.infinity;
  var maxDiff = -double.infinity;
  var minDiff = double.infinity;

  for (final p in edgePoints) {
    final sum = p.x + p.y;
    final diff = p.x - p.y;
    if (sum < minSum) {
      minSum = sum.toDouble();
      tl = p;
    }
    if (sum > maxSum) {
      maxSum = sum.toDouble();
      br = p;
    }
    if (diff > maxDiff) {
      maxDiff = diff.toDouble();
      tr = p;
    }
    if (diff < minDiff) {
      minDiff = diff.toDouble();
      bl = p;
    }
  }

  return _normalizeQuad(
    w,
    h,
    _DetectQuad(tl, tr, br, bl),
  );
}

_DetectResult _normalizeQuad(int w, int h, _DetectQuad quad) {
  const pad = 0.005;
  Offset norm(math.Point<int> p) {
    return Offset(
      (p.x / w).clamp(pad, 1 - pad),
      (p.y / h).clamp(pad, 1 - pad),
    );
  }

  return _DetectResult(
    norm(quad.tl),
    norm(quad.tr),
    norm(quad.br),
    norm(quad.bl),
  );
}
