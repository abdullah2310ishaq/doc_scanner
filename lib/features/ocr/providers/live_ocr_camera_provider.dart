import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../core/services/device_performance_profile.dart';
import '../../../core/services/permission_service.dart';
import '../models/ocr_text_block.dart';
import '../services/camera_input_image_converter.dart';
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
  TextRecognizer? _recognizer;
  CameraInputImageConverter? _inputImageConverter;

  static const _streamStartDelayMs = 500;
  static const _debounceMs = 200;

  int _detectIntervalMs = 350;
  int _lastProcessedTimestamp = 0;

  Timer? _debounceTimer;
  List<OcrTextBlock> _pendingBlocks = const [];

  LiveOcrCameraStatus _status = LiveOcrCameraStatus.initializing;
  String? _errorMessage;
  bool _isProcessingFrame = false;
  bool _disposed = false;
  bool _streamStarted = false;
  bool _pausedByLifecycle = false;
  List<OcrTextBlock> _detectedBlocks = const [];

  LiveOcrCameraStatus get status => _status;
  String? get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraService.controller;
  bool get isFlashOn => _cameraService.isFlashOn;
  bool get isCapturing => _status == LiveOcrCameraStatus.capturing;
  List<OcrTextBlock> get detectedBlocks => _detectedBlocks;

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
      final profile = await DevicePerformanceProfile.load();
      _detectIntervalMs = profile.ocrDetectIntervalMs;

      await _cameraService.initialize();
      final camera = _cameraService.controller?.description;
      if (camera != null) {
        _inputImageConverter = CameraInputImageConverter(camera);
      }
      _errorMessage = null;
      _setStatus(LiveOcrCameraStatus.ready);
      _scheduleLiveOcrStart();
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
      final controller = _cameraService.controller;
      if (controller != null && controller.value.isStreamingImages) {
        await controller.stopImageStream();
        _streamStarted = false;
      }

      final imagePath = await _cameraService.takePicture();
      _setStatus(LiveOcrCameraStatus.ready);
      if (!_pausedByLifecycle) {
        _scheduleLiveOcrStart();
      }
      return imagePath;
    } catch (error) {
      _errorMessage = error.toString();
      _setStatus(LiveOcrCameraStatus.error);
      return null;
    }
  }

  Future<void> pauseLiveOcr() async {
    if (_disposed) return;

    _pausedByLifecycle = true;
    _debounceTimer?.cancel();

    final controller = _cameraService.controller;
    if (controller != null && controller.value.isStreamingImages) {
      try {
        await controller.stopImageStream();
      } catch (_) {}
      _streamStarted = false;
    }
  }

  Future<void> resumeLiveOcr() async {
    if (_disposed || !_pausedByLifecycle) return;

    _pausedByLifecycle = false;
    if (_status == LiveOcrCameraStatus.ready) {
      _scheduleLiveOcrStart();
    }
  }

  void _scheduleLiveOcrStart() {
    if (_disposed || _pausedByLifecycle || _status != LiveOcrCameraStatus.ready) {
      return;
    }

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (_disposed || _pausedByLifecycle || _status != LiveOcrCameraStatus.ready) {
        return;
      }

      await Future<void>.delayed(
        const Duration(milliseconds: _streamStartDelayMs),
      );

      if (_disposed || _pausedByLifecycle || _status != LiveOcrCameraStatus.ready) {
        return;
      }
      await _startLiveOcr();
    });
  }

  Future<void> _startLiveOcr() async {
    final controller = _cameraService.controller;
    if (controller == null ||
        !controller.value.isInitialized ||
        _streamStarted ||
        _disposed ||
        _pausedByLifecycle) {
      return;
    }

    try {
      await controller.startImageStream((CameraImage image) async {
        if (_disposed || _pausedByLifecycle || _status != LiveOcrCameraStatus.ready) {
          return;
        }

        final now = DateTime.now().millisecondsSinceEpoch;
        if (_isProcessingFrame ||
            (now - _lastProcessedTimestamp < _detectIntervalMs)) {
          return;
        }

        _isProcessingFrame = true;
        _lastProcessedTimestamp = now;

        try {
          final converter = _inputImageConverter;
          if (converter == null) return;

          final liveInput = converter.fromCameraImageForLive(image, controller);
          if (liveInput == null) return;

          _recognizer ??= TextRecognizer();
          final result = await _recognizer!.processImage(liveInput.inputImage);

          final scale = liveInput.bboxScale;
          final blocks = <OcrTextBlock>[];
          for (final block in result.blocks) {
            for (final line in block.lines) {
              for (final element in line.elements) {
                final box = element.boundingBox;
                blocks.add(
                  OcrTextBlock(
                    text: element.text,
                    boundingBox: Rect.fromLTRB(
                      box.left * scale,
                      box.top * scale,
                      box.right * scale,
                      box.bottom * scale,
                    ),
                  ),
                );
              }
            }
          }

          _pendingBlocks = blocks;
          _debounceTimer?.cancel();
          _debounceTimer = Timer(
            const Duration(milliseconds: _debounceMs),
            _flushPendingBlocks,
          );
        } catch (e) {
          debugPrint('LiveOcr: frame processing error: $e');
        } finally {
          _isProcessingFrame = false;
        }
      });
      _streamStarted = true;
    } catch (e) {
      debugPrint('LiveOcr: failed to start image stream: $e');
    }
  }

  void _flushPendingBlocks() {
    if (_disposed) return;
    _detectedBlocks = _pendingBlocks;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _debounceTimer?.cancel();
    _recognizer?.close();
    _cameraService.dispose();
    super.dispose();
  }

  void _setStatus(LiveOcrCameraStatus status) {
    _status = status;
    notifyListeners();
  }
}
