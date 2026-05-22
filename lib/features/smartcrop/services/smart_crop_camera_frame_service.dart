import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

/// Converts camera preview frames to grayscale for live edge detection.
class SmartCropCameraFrameService {
  img.Image? frameToGray(
    CameraImage image, {
    int targetWidth = 480,
    int sensorOrientation = 90,
  }) {
    if (image.planes.isEmpty) return null;

    final width = image.width;
    final height = image.height;
    if (width <= 0 || height <= 0) return null;

    final plane = image.planes.first;
    final bytes = plane.bytes;
    final rowStride = plane.bytesPerRow;
    final pixelStride = plane.bytesPerPixel ?? 1;

    final scale = width > targetWidth ? targetWidth / width : 1.0;
    final outW = (width * scale).round().clamp(1, width);
    final outH = (height * scale).round().clamp(1, height);

    final output = img.Image(width: outW, height: outH);
    for (var y = 0; y < outH; y++) {
      final srcY = (y / scale).round().clamp(0, height - 1);
      for (var x = 0; x < outW; x++) {
        final srcX = (x / scale).round().clamp(0, width - 1);
        final index = srcY * rowStride + srcX * pixelStride;
        if (index >= bytes.length) continue;
        final lum = bytes[index];
        output.setPixelRgb(x, y, lum, lum, lum);
      }
    }

    // Match portrait preview orientation.
    if (sensorOrientation == 90) {
      return img.copyRotate(output, angle: 90);
    }
    if (sensorOrientation == 270) {
      return img.copyRotate(output, angle: 270);
    }
    if (sensorOrientation == 180) {
      return img.copyRotate(output, angle: 180);
    }
    return output;
  }
}
