import 'package:flutter/material.dart';

import 'smart_crop_edge_detect_service.dart';

/// Maps detection coords (camera buffer) to portrait preview (0–1).
DetectedDocumentCorners mapCornersForPreview(
  DetectedDocumentCorners corners,
  int sensorOrientation,
) {
  Offset mapPoint(Offset p) {
    final x = p.dx.clamp(0.0, 1.0);
    final y = p.dy.clamp(0.0, 1.0);
    switch (sensorOrientation) {
      case 90:
        return Offset(y, 1.0 - x);
      case 270:
        return Offset(1.0 - y, x);
      case 180:
        return Offset(1.0 - x, 1.0 - y);
      default:
        return Offset(x, y);
    }
  }

  return reorderDocumentCorners(
    DetectedDocumentCorners(
      topLeft: mapPoint(corners.topLeft),
      topRight: mapPoint(corners.topRight),
      bottomRight: mapPoint(corners.bottomRight),
      bottomLeft: mapPoint(corners.bottomLeft),
    ),
  );
}

/// Re-label corners as TL, TR, BR, BL after rotation.
DetectedDocumentCorners reorderDocumentCorners(DetectedDocumentCorners corners) {
  final points = [
    corners.topLeft,
    corners.topRight,
    corners.bottomRight,
    corners.bottomLeft,
  ];

  Offset tl = points[0];
  Offset tr = points[0];
  Offset br = points[0];
  Offset bl = points[0];
  var minSum = double.infinity;
  var maxSum = -double.infinity;
  var maxDiff = -double.infinity;
  var minDiff = double.infinity;

  for (final p in points) {
    final sum = p.dx + p.dy;
    final diff = p.dx - p.dy;
    if (sum < minSum) {
      minSum = sum;
      tl = p;
    }
    if (sum > maxSum) {
      maxSum = sum;
      br = p;
    }
    if (diff > maxDiff) {
      maxDiff = diff;
      tr = p;
    }
    if (diff < minDiff) {
      minDiff = diff;
      bl = p;
    }
  }

  return DetectedDocumentCorners(
    topLeft: tl,
    topRight: tr,
    bottomRight: br,
    bottomLeft: bl,
  );
}

Offset lerpOffset(Offset a, Offset b, double t) {
  return Offset(
    a.dx + (b.dx - a.dx) * t,
    a.dy + (b.dy - a.dy) * t,
  );
}

DetectedDocumentCorners lerpCorners(
  DetectedDocumentCorners from,
  DetectedDocumentCorners to,
  double t,
) {
  return DetectedDocumentCorners(
    topLeft: lerpOffset(from.topLeft, to.topLeft, t),
    topRight: lerpOffset(from.topRight, to.topRight, t),
    bottomRight: lerpOffset(from.bottomRight, to.bottomRight, t),
    bottomLeft: lerpOffset(from.bottomLeft, to.bottomLeft, t),
  );
}
