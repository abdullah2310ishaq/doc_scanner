import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Result of converting a live camera frame for ML Kit OCR.
class LiveInputImageResult {
  const LiveInputImageResult({
    required this.inputImage,
    required this.bboxScale,
  });

  final InputImage inputImage;

  /// Multiply OCR bounding boxes by this to map back to preview coordinates.
  final double bboxScale;
}

/// Builds ML Kit [InputImage] frames from a live [CameraImage].
///
/// Android ML Kit only accepts NV21/YV12 byte arrays — not raw YUV_420_888
/// plane concatenation. See google_mlkit_commons InputImageConverter.java.
class CameraInputImageConverter {
  CameraInputImageConverter(this._camera);

  final CameraDescription _camera;

  static const _liveTargetWidth = 480;

  Uint8List? _reusablePlaneBuffer;
  Uint8List? _reusableNv21Buffer;
  int _lastNv21Size = 0;
  Uint8List? _reusableDownscaledNv21;
  int _lastDownscaledNv21Size = 0;

  static const _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  /// Live stream conversion — downscales wide frames before OCR to cut memory.
  LiveInputImageResult? fromCameraImageForLive(
    CameraImage image,
    CameraController controller,
  ) {
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
    var width = image.width;
    var height = image.height;
    Uint8List bytes;

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

    var bboxScale = 1.0;
    if (Platform.isAndroid &&
        resolvedFormat == InputImageFormat.nv21 &&
        width > _liveTargetWidth) {
      final downscaled = _downscaleNv21(bytes, width, height, _liveTargetWidth);
      bytes = downscaled.bytes;
      bboxScale = width / downscaled.width;
      width = downscaled.width;
      height = downscaled.height;
    }

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(width.toDouble(), height.toDouble()),
        rotation: rotation,
        format: resolvedFormat,
        bytesPerRow: width,
      ),
    );

    return LiveInputImageResult(inputImage: inputImage, bboxScale: bboxScale);
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

  ({Uint8List bytes, int width, int height}) _downscaleNv21(
    Uint8List nv21,
    int width,
    int height,
    int targetWidth,
  ) {
    final outW = math.min(targetWidth, width);
    if (outW == width) {
      return (bytes: nv21, width: width, height: height);
    }

    final scale = outW / width;
    final outH = math.max(1, (height * scale).round());
    final outYSize = outW * outH;
    final requiredSize = outYSize + outYSize ~/ 2;

    if (_reusableDownscaledNv21 == null ||
        _lastDownscaledNv21Size != requiredSize) {
      _reusableDownscaledNv21 = Uint8List(requiredSize);
      _lastDownscaledNv21Size = requiredSize;
    }

    final output = _reusableDownscaledNv21!;
    final srcUvOffset = width * height;
    final outUvOffset = outYSize;

    for (var y = 0; y < outH; y++) {
      final srcY = ((y / scale).round()).clamp(0, height - 1);
      final srcRow = srcY * width;
      final outRow = y * outW;
      for (var x = 0; x < outW; x++) {
        final srcX = ((x / scale).round()).clamp(0, width - 1);
        output[outRow + x] = nv21[srcRow + srcX];
      }
    }

    for (var y = 0; y < outH ~/ 2; y++) {
      final srcY = ((y / scale).round()).clamp(0, height ~/ 2 - 1);
      final srcRow = srcUvOffset + srcY * width;
      final outRow = outUvOffset + y * outW;
      for (var x = 0; x < outW; x += 2) {
        final srcX = ((x / scale).round()).clamp(0, width - 2);
        output[outRow + x] = nv21[srcRow + srcX];
        if (x + 1 < outW) {
          output[outRow + x + 1] = nv21[srcRow + srcX + 1];
        }
      }
    }

    return (bytes: output, width: outW, height: outH);
  }
}
