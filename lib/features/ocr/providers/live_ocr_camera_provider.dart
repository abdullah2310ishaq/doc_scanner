import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

import '../../../core/services/permission_service.dart';
import '../services/camera_service.dart';

enum LiveOcrCameraStatus {
  initializing,
  ready,
  capturing,
  permissionDenied,
  error,
}

class LiveOcrCameraProvider extends ChangeNotifier {
  LiveOcrCameraProvider({
    PermissionService? permissionService,
    CameraService? cameraService,
  })  : _permissionService = permissionService ?? PermissionService(),
        _cameraService = cameraService ?? CameraService();

  final PermissionService _permissionService;
  final CameraService _cameraService;

  LiveOcrCameraStatus _status = LiveOcrCameraStatus.initializing;
  String? _errorMessage;

  LiveOcrCameraStatus get status => _status;
  String? get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraService.controller;
  bool get isFlashOn => _cameraService.isFlashOn;
  bool get isCapturing => _status == LiveOcrCameraStatus.capturing;

  Future<void> initialize() async {
    _setStatus(LiveOcrCameraStatus.initializing);

    final hasPermission = await _permissionService.hasCameraPermission() ||
        await _permissionService.requestCameraPermission();

    if (!hasPermission) {
      _errorMessage = null;
      _setStatus(LiveOcrCameraStatus.permissionDenied);
      return;
    }

    try {
      await _cameraService.initialize();
      _errorMessage = null;
      _setStatus(LiveOcrCameraStatus.ready);
    } on CameraException catch (error) {
      _errorMessage = error.description ?? error.code;
      _setStatus(LiveOcrCameraStatus.error);
    } catch (error) {
      _errorMessage = error.toString();
      _setStatus(LiveOcrCameraStatus.error);
    }
  }

  Future<void> toggleFlash() async {
    if (_status != LiveOcrCameraStatus.ready) return;
    await _cameraService.toggleFlash();
    notifyListeners();
  }

  Future<String?> captureImage() async {
    if (_status != LiveOcrCameraStatus.ready) return null;

    _setStatus(LiveOcrCameraStatus.capturing);

    try {
      final imagePath = await _cameraService.takePicture();
      _setStatus(LiveOcrCameraStatus.ready);
      return imagePath;
    } catch (error) {
      _errorMessage = error.toString();
      _setStatus(LiveOcrCameraStatus.error);
      return null;
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  void _setStatus(LiveOcrCameraStatus status) {
    _status = status;
    notifyListeners();
  }
}
