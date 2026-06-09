import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

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

  // Debounce: only push new results to the UI every 200ms.
  static const _debounceMs = 200;
  Timer? _debounceTimer;
  List<OcrTextBlock> _pendingBlocks = const [];

  LiveOcrCameraStatus _status = LiveOcrCameraStatus.initializing;
  String? _errorMessage;
  bool _isProcessing = false;
  bool _disposed = false;
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
      await _cameraService.initialize();
      final camera = _cameraService.controller?.description;
      if (camera != null) {
        _inputImageConverter = CameraInputImageConverter(camera);
      }
      _errorMessage = null;
      _setStatus(LiveOcrCameraStatus.ready);
      _startLiveOcr();
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
      }
      final imagePath = await _cameraService.takePicture();
      _setStatus(LiveOcrCameraStatus.ready);
      return imagePath;
    } catch (error) {
      _errorMessage = error.toString();
      _setStatus(LiveOcrCameraStatus.error);
      return null;
    }
  }

  Future<void> _startLiveOcr() async {
    final controller = _cameraService.controller;
    if (controller == null || !controller.value.isInitialized) return;

    try {
      await controller.startImageStream((CameraImage image) async {
        if (_isProcessing || _disposed) return;
        _isProcessing = true;

        try {
          final converter = _inputImageConverter;
          if (converter == null) return;

          final inputImage = converter.fromCameraImage(image, controller);
          if (inputImage == null) return;

          _recognizer ??= TextRecognizer();
          final result = await _recognizer!.processImage(inputImage);

          final blocks = <OcrTextBlock>[];
          for (final block in result.blocks) {
            for (final line in block.lines) {
              for (final element in line.elements) {
                blocks.add(
                  OcrTextBlock(
                    text: element.text,
                    boundingBox: element.boundingBox,
                  ),
                );
              }
            }
          }

          // Buffer the result and debounce UI updates to 200ms.
          _pendingBlocks = blocks;
          _debounceTimer?.cancel();
          _debounceTimer = Timer(
            const Duration(milliseconds: _debounceMs),
            _flushPendingBlocks,
          );
        } catch (e) {
          debugPrint('LiveOcr: frame processing error: $e');
        } finally {
          _isProcessing = false;
        }
      });
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
