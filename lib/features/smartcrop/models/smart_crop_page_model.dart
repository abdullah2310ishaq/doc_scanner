import 'package:flutter/material.dart';

/// One page in a smart-crop session.
class SmartCropPageModel {
  const SmartCropPageModel({
    required this.imagePath,
    this.topLeft = const Offset(0.1, 0.1),
    this.topRight = const Offset(0.9, 0.1),
    this.bottomRight = const Offset(0.9, 0.9),
    this.bottomLeft = const Offset(0.1, 0.9),
    this.isMlKitProcessed = false,
    this.isCameraScanned = false,
    this.cornersLocked = false,
    this.detectionConfidence,
    this.detectionIsFallback = false,
  });

  /// Auto-lock only when confidence is at or above this value.
  static const double autoLockConfidenceThreshold = 0.88;

  final String imagePath;
  final Offset topLeft;
  final Offset topRight;
  final Offset bottomRight;
  final Offset bottomLeft;

  /// Google ML Kit scanner (Android) — already dewarped.
  final bool isMlKitProcessed;

  /// Auto-cropped on our live camera shutter.
  final bool isCameraScanned;

  /// User confirmed corners on adjust screen — use these for perspective warp.
  final bool cornersLocked;

  /// Pre-detect quality from [SmartCropEdgeDetectService]; null if not run yet.
  final double? detectionConfidence;

  /// True when edge detect fell back to a preset quad (not real document edges).
  final bool detectionIsFallback;

  /// Page is already edge-cropped; go straight to filters.
  bool get isAlreadyScanned => isMlKitProcessed || isCameraScanned;

  /// Pre-detect ran and produced a non-fallback result — skip re-detect in crop.
  bool get hasPreDetectedCorners =>
      detectionConfidence != null && !detectionIsFallback;

  SmartCropPageModel copyWith({
    String? imagePath,
    Offset? topLeft,
    Offset? topRight,
    Offset? bottomRight,
    Offset? bottomLeft,
    bool? isMlKitProcessed,
    bool? isCameraScanned,
    bool? cornersLocked,
    double? detectionConfidence,
    bool? detectionIsFallback,
  }) {
    return SmartCropPageModel(
      imagePath: imagePath ?? this.imagePath,
      topLeft: topLeft ?? this.topLeft,
      topRight: topRight ?? this.topRight,
      bottomRight: bottomRight ?? this.bottomRight,
      bottomLeft: bottomLeft ?? this.bottomLeft,
      isMlKitProcessed: isMlKitProcessed ?? this.isMlKitProcessed,
      isCameraScanned: isCameraScanned ?? this.isCameraScanned,
      cornersLocked: cornersLocked ?? this.cornersLocked,
      detectionConfidence: detectionConfidence ?? this.detectionConfidence,
      detectionIsFallback: detectionIsFallback ?? this.detectionIsFallback,
    );
  }
}
