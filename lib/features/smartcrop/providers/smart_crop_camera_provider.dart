import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

import '../../../core/services/permission_service.dart';
import '../../ocr/services/camera_service.dart';
import '../services/smart_crop_camera_frame_service.dart';
import '../services/smart_crop_camera_geometry.dart';
import '../services/smart_crop_edge_detect_service.dart';

enum SmartCropCameraStatus {
  initializing,
  ready,
  capturing,
  permissionDenied,
  error,
}

/// Live camera — black corners until document found, then green + quad on edges.
class SmartCropCameraProvider extends ChangeNotifier {
  SmartCropCameraProvider({
    PermissionService? permissionService,
    CameraService? cameraService,
    SmartCropCameraFrameService? frameService,
  })  : _permissionService = permissionService ?? PermissionService(),
        _cameraService = cameraService ?? CameraService(),
        _frameService = frameService ?? SmartCropCameraFrameService();

  final PermissionService _permissionService;
  final CameraService _cameraService;
  final SmartCropCameraFrameService _frameService;

  static const _detectIntervalMs = 280;
  static const _greenAfterFrames = 2;

  SmartCropCameraStatus _status = SmartCropCameraStatus.initializing;
  String? _errorMessage;
  bool _isProcessingFrame = false;
  bool _disposed = false;
  Timer? _detectThrottle;
  CameraImage? _pendingFrame;

  bool _documentDetected = false;
  int _detectStreak = 0;
  DetectedDocumentCorners _corners = defaultGuideCorners;
  int _sensorOrientation = 90;

  SmartCropCameraStatus get status => _status;
  String? get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraService.controller;
  bool get isFlashOn => _cameraService.isFlashOn;
  bool get isCapturing => _status == SmartCropCameraStatus.capturing;
  bool get documentDetected => _documentDetected;
  DetectedDocumentCorners get corners => _corners;

  Future<void> initialize() async {
    _setStatus(SmartCropCameraStatus.initializing);

    final hasPermission = await _permissionService.hasCameraPermission() ||
        await _permissionService.requestCameraPermission();

    if (!hasPermission) {
      _setStatus(SmartCropCameraStatus.permissionDenied);
      return;
    }

    try {
      await _cameraService.initialize();
      _sensorOrientation =
          _cameraService.controller?.description.sensorOrientation ?? 90;
      _setStatus(SmartCropCameraStatus.ready);
      await _startLiveEdgeDetection();
    } on CameraException catch (error) {
      _errorMessage = error.description ?? error.code;
      _setStatus(SmartCropCameraStatus.error);
    } catch (error) {
      _errorMessage = error.toString();
      _setStatus(SmartCropCameraStatus.error);
    }
  }

  Future<void> toggleFlash() async {
    if (_status != SmartCropCameraStatus.ready) return;
    await _cameraService.toggleFlash();
    notifyListeners();
  }

  Future<String?> captureImage() async {
    if (_status != SmartCropCameraStatus.ready) return null;

    _setStatus(SmartCropCameraStatus.capturing);

    try {
      final controller = _cameraService.controller;
      if (controller != null && controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
      final imagePath = await _cameraService.takePicture();
      _setStatus(SmartCropCameraStatus.ready);
      await _startLiveEdgeDetection();
      return imagePath;
    } catch (error) {
      _errorMessage = error.toString();
      _setStatus(SmartCropCameraStatus.error);
      return null;
    }
  }

  Future<void> _startLiveEdgeDetection() async {
    final controller = _cameraService.controller;
    if (controller == null || !controller.value.isInitialized) return;

    try {
      await controller.startImageStream((CameraImage image) {
        if (_disposed) return;
        _pendingFrame = image;

        if (_isProcessingFrame) return;
        _detectThrottle?.cancel();
        _detectThrottle = Timer(
          const Duration(milliseconds: _detectIntervalMs),
          _processLatestFrame,
        );
      });
    } catch (e) {
      debugPrint('SmartCropCamera: stream error: $e');
    }
  }

  Future<void> _processLatestFrame() async {
    final image = _pendingFrame;
    if (image == null || _isProcessingFrame || _disposed) return;
    _isProcessingFrame = true;

    try {
      final gray = _frameService.frameToGray(
        image,
        sensorOrientation: _sensorOrientation,
      );
      if (gray == null) return;

      final result = detectDocumentEdgesLive(gray);
      final mapped = reorderDocumentCorners(result.corners);

      if (result.isDetected) {
        _detectStreak++;
      } else {
        _detectStreak = 0;
      }

      final showGreen = _detectStreak >= _greenAfterFrames;
      final targetCorners =
          showGreen ? mapped : defaultGuideCorners;

      _corners = lerpCorners(_corners, targetCorners, showGreen ? 0.45 : 0.2);
      _documentDetected = showGreen;
      notifyListeners();
    } catch (e) {
      debugPrint('SmartCropCamera: detect error: $e');
    } finally {
      _isProcessingFrame = false;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _detectThrottle?.cancel();
    _cameraService.dispose();
    super.dispose();
  }

  void _setStatus(SmartCropCameraStatus status) {
    _status = status;
    notifyListeners();
  }
}
