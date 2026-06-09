import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

class CameraService {
  CameraController? _controller;
  List<CameraDescription> _cameras = const [];

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

    // high (1080p) is enough for OCR; max binds a 48MP capture stream on many devices.
    final controller = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isIOS
          ? ImageFormatGroup.bgra8888
          : ImageFormatGroup.nv21,
    );

    await controller.initialize();
    await controller.setFlashMode(FlashMode.off);
    try {
      // In the Flutter camera package, FocusMode.auto enables continuous autofocus 
      // under the hood (FocusMode only contains 'auto' and 'locked').
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
      // Force auto focus and wait for it to settle for sharp text OCR
      await controller.setFocusMode(FocusMode.auto);
      await Future.delayed(const Duration(milliseconds: 800));
    } catch (_) {
      // Ignore if focus mode is unsupported
    }

    try {
      final file = await controller.takePicture();
      return file.path;
    } finally {
      // Restore continuous focus mode after capture
      try {
        await controller.setFocusMode(FocusMode.auto);
      } catch (_) {}
    }
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
