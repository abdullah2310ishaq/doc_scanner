import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Builds ML Kit [InputImage] frames from a live [CameraImage].
///
/// Android ML Kit only accepts NV21/YV12 byte arrays — not raw YUV_420_888
/// plane concatenation. See google_mlkit_commons InputImageConverter.java.
class CameraInputImageConverter {
  CameraInputImageConverter(this._camera);

  final CameraDescription _camera;

  Uint8List? _reusablePlaneBuffer;
  Uint8List? _reusableNv21Buffer;
  int _lastNv21Size = 0;

  static const _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? fromCameraImage(CameraImage image, CameraController controller) {
    final rotation = _rotation(controller);
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return null;

    const androidSupportedFormats = [
      InputImageFormat.nv21,
      InputImageFormat.yv12,
      InputImageFormat.yuv_420_888,
    ];

    if ((Platform.isAndroid && !androidSupportedFormats.contains(format)) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      return null;
    }

    var resolvedFormat = format;
    final Uint8List bytes;

    if (image.planes.length == 1) {
      bytes = image.planes.first.bytes;
    } else if (Platform.isAndroid &&
        (format == InputImageFormat.yuv_420_888 ||
            format == InputImageFormat.yv12) &&
        image.planes.length == 3) {
      bytes = _convertYuv420ToNv21(image);
      resolvedFormat = InputImageFormat.nv21;
    } else {
      bytes = _concatenatePlanes(image);
    }

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: resolvedFormat,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  InputImageRotation? _rotation(CameraController controller) {
    final sensorOrientation = _camera.sensorOrientation;

    if (Platform.isIOS) {
      return InputImageRotationValue.fromRawValue(sensorOrientation);
    }

    final rotationCompensation =
        _orientations[controller.value.deviceOrientation];
    if (rotationCompensation == null) return null;

    final int compensated;
    if (_camera.lensDirection == CameraLensDirection.front) {
      compensated = (sensorOrientation + rotationCompensation) % 360;
    } else {
      compensated = (sensorOrientation - rotationCompensation + 360) % 360;
    }

    return InputImageRotationValue.fromRawValue(compensated);
  }

  Uint8List _concatenatePlanes(CameraImage image) {
    final totalBytes = image.planes.fold<int>(
      0,
      (sum, plane) => sum + plane.bytes.length,
    );

    var buffer = _reusablePlaneBuffer;
    if (buffer == null || buffer.length < totalBytes) {
      buffer = Uint8List(totalBytes);
      _reusablePlaneBuffer = buffer;
    }

    var offset = 0;
    for (final plane in image.planes) {
      final planeBytes = plane.bytes;
      buffer.setRange(offset, offset + planeBytes.length, planeBytes);
      offset += planeBytes.length;
    }

    if (totalBytes == buffer.length) return buffer;
    return Uint8List.sublistView(buffer, 0, totalBytes);
  }

  Uint8List _convertYuv420ToNv21(CameraImage image) {
    final width = image.width;
    final height = image.height;
    final ySize = width * height;
    final uvSize = ySize ~/ 2;
    final requiredSize = ySize + uvSize;

    if (_reusableNv21Buffer == null || _lastNv21Size != requiredSize) {
      _reusableNv21Buffer = Uint8List(requiredSize);
      _lastNv21Size = requiredSize;
    }

    final nv21 = _reusableNv21Buffer!;

    final yPlane = image.planes[0];
    var destIndex = 0;
    for (var row = 0; row < height; row++) {
      final srcRowStart = row * yPlane.bytesPerRow;
      nv21.setRange(destIndex, destIndex + width, yPlane.bytes, srcRowStart);
      destIndex += width;
    }

    final uPlane = image.planes[1];
    final vPlane = image.planes[2];
    final uvPixelStride = uPlane.bytesPerPixel ?? 1;
    final vPixelStride = vPlane.bytesPerPixel ?? 1;

    var uvIndex = ySize;
    for (var row = 0; row < height ~/ 2; row++) {
      final uRowStart = row * uPlane.bytesPerRow;
      final vRowStart = row * vPlane.bytesPerRow;

      for (var col = 0; col < width ~/ 2; col++) {
        final uIndex = uRowStart + col * uvPixelStride;
        final vIndex = vRowStart + col * vPixelStride;
        nv21[uvIndex++] = vPlane.bytes[vIndex];
        nv21[uvIndex++] = uPlane.bytes[uIndex];
      }
    }

    return nv21;
  }
}
