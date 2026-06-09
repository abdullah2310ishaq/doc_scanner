import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import '../../../core/services/device_performance_profile.dart';

class CameraService {
  CameraService();

  CameraController? _controller;
  List<CameraDescription> _cameras = const [];

  static const _maxCaptureWidth = 4000;
  static const _maxCaptureHeight = 3000;
  static const _focusSettleMs = 300;

  CameraController? get controller => _controller;

  bool get isInitialized =>
      _controller != null && _controller!.value.isInitialized;

  bool get isFlashOn => _controller?.value.flashMode == FlashMode.torch;

  Future<void> initialize() async {
    _cameras = await availableCameras();
    if (_cameras.isEmpty) {
      throw CameraException('no_camera', 'No cameras found on this device');
    }

    final backCamera = _cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => _cameras.first,
    );

    final profile = await DevicePerformanceProfile.load();

    final controller = CameraController(
      backCamera,
      profile.previewPreset,
      enableAudio: false,
      imageFormatGroup: Platform.isIOS
          ? ImageFormatGroup.bgra8888
          : ImageFormatGroup.nv21,
    );

    await controller.initialize();
    await controller.setFlashMode(FlashMode.off);
    try {
      await controller.setFocusMode(FocusMode.auto);
    } catch (_) {}
    try {
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
    } catch (_) {}
    _controller = controller;
  }

  Future<void> toggleFlash() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    final nextMode = isFlashOn ? FlashMode.off : FlashMode.torch;
    await controller.setFlashMode(nextMode);
  }

  Future<String> takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      throw CameraException('not_ready', 'Camera is not ready');
    }

    try {
      await controller.setFocusMode(FocusMode.auto);
      await Future.delayed(const Duration(milliseconds: _focusSettleMs));
    } catch (_) {}

    try {
      final file = await controller.takePicture();
      return _capCaptureResolution(file.path);
    } finally {
      try {
        await controller.setFocusMode(FocusMode.auto);
      } catch (_) {}
    }
  }

  /// Caps still captures at 12MP to avoid 48MP memory spikes on flagship sensors.
  Future<String> _capCaptureResolution(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return path;

    if (decoded.width <= _maxCaptureWidth &&
        decoded.height <= _maxCaptureHeight) {
      return path;
    }

    final scale = math.min(
      _maxCaptureWidth / decoded.width,
      _maxCaptureHeight / decoded.height,
    );
    final newWidth = (decoded.width * scale).round();
    final newHeight = (decoded.height * scale).round();

    final resized = img.copyResize(
      decoded,
      width: newWidth,
      height: newHeight,
    );
    await file.writeAsBytes(img.encodeJpg(resized, quality: 90));
    return path;
  }

  Future<void> dispose() async {
    final controller = _controller;
    _controller = null;
    if (controller != null) {
      if (controller.value.isStreamingImages) {
        try {
          await controller.stopImageStream();
        } catch (_) {}
      }
      await controller.dispose();
    }
  }
}
