import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
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

/// Corner detection result + quality hint.
class DocumentCornerResult {
  const DocumentCornerResult({
    required this.corners,
    required this.confidence,
    required this.isFallback,
  });

  final DetectedDocumentCorners corners;

  /// 0.0 (very unsure) → 1.0 (very sure).
  final double confidence;

  /// True when we had to fall back to a full-image quad.
  final bool isFallback;
}

/// Isolate-safe corner payload for [compute].
List<double> detectDocumentCornersFlat(String imagePath) {
  final c = detectDocumentCorners(imagePath);
  return [
    c.topLeft.dx,
    c.topLeft.dy,
    c.topRight.dx,
    c.topRight.dy,
    c.bottomRight.dx,
    c.bottomRight.dy,
    c.bottomLeft.dx,
    c.bottomLeft.dy,
  ];
}

/// Isolate-safe corner + confidence payload for [compute].
List<double> detectDocumentCornersWithConfidenceFlat(String imagePath) {
  final r = detectDocumentCornersWithConfidence(imagePath);
  return [
    r.corners.topLeft.dx,
    r.corners.topLeft.dy,
    r.corners.topRight.dx,
    r.corners.topRight.dy,
    r.corners.bottomRight.dx,
    r.corners.bottomRight.dy,
    r.corners.bottomLeft.dx,
    r.corners.bottomLeft.dy,
    r.confidence,
    r.isFallback ? 1.0 : 0.0,
  ];
}

/// Finds document corners from a photo (paper only — tight bounds).
class SmartCropEdgeDetectService {
  Future<SmartCropPageModel> detectCorners(SmartCropPageModel page) async {
    final flat = await compute(detectDocumentCornersFlat, page.imagePath);
    return page.copyWith(
      topLeft: Offset(flat[0], flat[1]),
      topRight: Offset(flat[2], flat[3]),
      bottomRight: Offset(flat[4], flat[5]),
      bottomLeft: Offset(flat[6], flat[7]),
    );
  }

  Future<DocumentCornerResult> detectCornersWithConfidence(String imagePath) async {
    final flat =
        await compute(detectDocumentCornersWithConfidenceFlat, imagePath);
    return DocumentCornerResult(
      corners: DetectedDocumentCorners(
        topLeft: Offset(flat[0], flat[1]),
        topRight: Offset(flat[2], flat[3]),
        bottomRight: Offset(flat[4], flat[5]),
        bottomLeft: Offset(flat[6], flat[7]),
      ),
      confidence: flat[8].clamp(0.0, 1.0),
      isFallback: flat[9] >= 0.5,
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

/// Live camera frame result — [isDetected] drives black → green corners.
class LiveDocumentDetection {
  const LiveDocumentDetection({
    required this.corners,
    required this.isDetected,
  });

  final DetectedDocumentCorners corners;
  final bool isDetected;
}

/// Default guide quad when no document found yet (normalized).
DetectedDocumentCorners get defaultGuideCorners => const DetectedDocumentCorners(
      topLeft: Offset(0.08, 0.18),
      topRight: Offset(0.92, 0.18),
      bottomRight: Offset(0.92, 0.82),
      bottomLeft: Offset(0.08, 0.82),
    );

DetectedDocumentCorners detectDocumentCorners(String imagePath) {
  final result = _detectPaperQuad(imagePath, maxWidth: 1000);
  return DetectedDocumentCorners(
    topLeft: result.tl,
    topRight: result.tr,
    bottomRight: result.br,
    bottomLeft: result.bl,
  );
}

DocumentCornerResult detectDocumentCornersWithConfidence(String imagePath) {
  final r = _detectPaperQuadWithConfidence(imagePath, maxWidth: 1600);
  return DocumentCornerResult(
    corners: DetectedDocumentCorners(
      topLeft: r.result.tl,
      topRight: r.result.tr,
      bottomRight: r.result.br,
      bottomLeft: r.result.bl,
    ),
    confidence: r.confidence,
    isFallback: r.isFallback,
  );
}

/// Fast path for live camera preview frames (small grayscale image).
LiveDocumentDetection detectDocumentEdgesLive(img.Image grayImage) {
  final blurred = img.gaussianBlur(grayImage, radius: 2);
  final paperBounds = _findPaperBounds(blurred, forLivePreview: true);

  if (paperBounds != null) {
    final refined = _refineCornersInBounds(blurred, paperBounds);
    final normalized = _normalizeQuad(blurred.width, blurred.height, refined);
    return LiveDocumentDetection(
      corners: _cornersFromResult(normalized),
      isDetected: true,
    );
  }

  final edgeQuad = _quadFromEdgePoints(blurred, minEdges: 40);
  if (edgeQuad != null) {
    return LiveDocumentDetection(
      corners: _cornersFromResult(edgeQuad),
      isDetected: true,
    );
  }

  return LiveDocumentDetection(
    corners: defaultGuideCorners,
    isDetected: false,
  );
}

DetectedDocumentCorners _cornersFromResult(_DetectResult result) {
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

bool _isPlausibleQuad(_DetectResult quad) {
  final xs = [quad.tl.dx, quad.tr.dx, quad.br.dx, quad.bl.dx];
  final ys = [quad.tl.dy, quad.tr.dy, quad.br.dy, quad.bl.dy];
  final minX = xs.reduce(math.min);
  final maxX = xs.reduce(math.max);
  final minY = ys.reduce(math.min);
  final maxY = ys.reduce(math.max);

  final area = (maxX - minX) * (maxY - minY);
  if (area < 0.08) return false;
  if (minX < 0 || minY < 0 || maxX > 1 || maxY > 1) return false;
  return true;
}

class _QuadWithConfidence {
  const _QuadWithConfidence(this.result, this.confidence, this.isFallback);

  final _DetectResult result;
  final double confidence;
  final bool isFallback;
}

_QuadWithConfidence _detectPaperQuadWithConfidence(
  String imagePath, {
  required int maxWidth,
}) {
  final fallback = _fallbackQuad();

  final file = File(imagePath);
  if (!file.existsSync()) {
    return _QuadWithConfidence(fallback, 0.0, true);
  }

  final bytes = file.readAsBytesSync();
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    return _QuadWithConfidence(fallback, 0.0, true);
  }

  final oriented = img.bakeOrientation(decoded);
  final scale = oriented.width > maxWidth ? maxWidth / oriented.width : 1.0;
  final scaled =
      scale < 1 ? img.copyResize(oriented, width: maxWidth) : oriented;

  final gray = img.grayscale(scaled);
  final blurred = img.gaussianBlur(gray, radius: 3);

  final paperBounds = _findPaperBounds(blurred);
  if (paperBounds == null) {
    final edgeQuad = _quadFromEdgePoints(blurred);
    if (edgeQuad == null || !_isPlausibleQuad(edgeQuad)) {
      return _QuadWithConfidence(fallback, 0.15, true);
    }
    return _QuadWithConfidence(edgeQuad, 0.55, false);
  }

  final refined = _refineCornersInBounds(blurred, paperBounds);
  final normalized = _normalizeQuad(scaled.width, scaled.height, refined);
  if (!_isPlausibleQuad(normalized)) {
    return _QuadWithConfidence(fallback, 0.2, true);
  }
  return _QuadWithConfidence(normalized, 0.85, false);
}

_DetectResult _detectPaperQuad(
  String imagePath, {
  required int maxWidth,
}) {
  return _detectPaperQuadWithConfidence(imagePath, maxWidth: maxWidth).result;
}

/// Largest bright/dark paper region — primary detector for uploads.
_PaperBounds? _findPaperBounds(
  img.Image gray, {
  bool forLivePreview = false,
}) {
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

  final minPaperRatio = forLivePreview ? 0.04 : 0.08;
  final minArea = forLivePreview ? 0.06 : 0.12;
  final maxArea = forLivePreview ? 0.92 : 0.98;

  if (paperCount < total * minPaperRatio) return null;
  if (right <= left + 8 || bottom <= top + 8) return null;

  final areaRatio = (right - left + 1) * (bottom - top + 1) / total;
  if (areaRatio < minArea || areaRatio > maxArea) return null;

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

_DetectResult? _quadFromEdgePoints(
  img.Image gray, {
  int minEdges = 60,
}) {
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

  if (edgePoints.length < minEdges) return null;

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
