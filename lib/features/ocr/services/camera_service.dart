import 'package:camera/camera.dart';

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

    final controller = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await controller.initialize();
    await controller.setFlashMode(FlashMode.off);
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

    final file = await controller.takePicture();
    return file.path;
  }

  Future<void> dispose() async {
    final controller = _controller;
    _controller = null;
    if (controller != null) {
      await controller.dispose();
    }
  }
}
