import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../models/ocr_analyze_result.dart';
import '../models/ocr_text_block.dart';
import 'ocr_service.dart';

/// Parameters passed to the background processing isolate.
class ImagePreprocessParams {
  final String originalImagePath;
  final String tempDirectoryPath;

  const ImagePreprocessParams({
    required this.originalImagePath,
    required this.tempDirectoryPath,
  });
}

/// Result returned from the background processing isolate.
class ImagePreprocessResult {
  final String displayImagePath;
  final String ocrImagePath;
  final double scaleFactor;
  final double displayWidth;
  final double displayHeight;
  // Paths of temp files that should be deleted after OCR is done.
  final List<String> tempFilesToDelete;

  const ImagePreprocessResult({
    required this.displayImagePath,
    required this.ocrImagePath,
    required this.scaleFactor,
    required this.displayWidth,
    required this.displayHeight,
    required this.tempFilesToDelete,
  });
}

/// Offloaded synchronous CPU-intensive image manipulations.
/// Runs in a separate Dart Isolate via [Isolate.run].
ImagePreprocessResult _preprocessImageSync(ImagePreprocessParams params) {
  final originalFile = File(params.originalImagePath);
  final bytes = originalFile.readAsBytesSync();
  final image = img.decodeImage(bytes);

  if (image == null) {
    // Decoding failed — fall back to the original file with no preprocessing.
    return ImagePreprocessResult(
      displayImagePath: params.originalImagePath,
      ocrImagePath: params.originalImagePath,
      scaleFactor: 1.0,
      displayWidth: 0.0,
      displayHeight: 0.0,
      tempFilesToDelete: const [],
    );
  }

  // 1. Bake EXIF orientation into pixel data so the image is upright.
  var processed = img.bakeOrientation(image);
  final displayWidth = processed.width.toDouble();
  final displayHeight = processed.height.toDouble();

  final timestamp = DateTime.now().millisecondsSinceEpoch;
  // Only the OCR-engine temp file will be deleted after OCR — the display
  // image must survive until Image.file() renders it on screen.
  final tempFilesToDelete = <String>[];

  // 2. Save the color-correct baked version for visual display on screen.
  //    Do NOT add this path to tempFilesToDelete — it is read by Image.file
  //    in the analyze screen and must remain in cache until the screen closes.
  final tempColorPath =
      '${params.tempDirectoryPath}/ocr_display_$timestamp.jpg';
  File(tempColorPath)
      .writeAsBytesSync(img.encodeJpg(processed, quality: 95));

  // 3. Prepare a separate copy for the OCR engine.
  //    Keep it in color — ML Kit Latin recognizer performs well on color
  //    images and grayscale can hurt performance on color-contrasted text.
  //    Only apply grayscale + contrast boost for very low-resolution images
  //    where sharpness is the primary bottleneck.
  var ocrImage = processed;
  double scaleFactor = 1.0;

  if (processed.width < 1200 || processed.height < 1200) {
    // Small image: upscale 2× and apply contrast boost to help ML Kit.
    scaleFactor = 2.0;
    ocrImage = img.copyResize(
      ocrImage,
      width: (ocrImage.width * scaleFactor).toInt(),
      height: (ocrImage.height * scaleFactor).toInt(),
      interpolation: img.Interpolation.cubic,
    );
    ocrImage = img.adjustColor(ocrImage, contrast: 1.25);
  }

  // 4. Save the OCR-ready image.
  final tempOcrPath = '${params.tempDirectoryPath}/ocr_engine_$timestamp.jpg';
  File(tempOcrPath).writeAsBytesSync(img.encodeJpg(ocrImage, quality: 95));
  tempFilesToDelete.add(tempOcrPath);

  return ImagePreprocessResult(
    displayImagePath: tempColorPath,
    ocrImagePath: tempOcrPath,
    scaleFactor: scaleFactor,
    displayWidth: displayWidth,
    displayHeight: displayHeight,
    tempFilesToDelete: tempFilesToDelete,
  );
}

/// Deletes a list of temp files. Safe to call — swallows errors silently.
void _deleteTempFiles(List<String> paths) {
  for (final path in paths) {
    try {
      final file = File(path);
      if (file.existsSync()) file.deleteSync();
    } catch (_) {}
  }
}

class MlKitOcrService implements OcrService {
  final TextRecognizer _recognizer = TextRecognizer();

  @override
  Future<OcrAnalyzeResult> analyzeImage(String originalImagePath) async {
    final tempDir = await getTemporaryDirectory();
    final params = ImagePreprocessParams(
      originalImagePath: originalImagePath,
      tempDirectoryPath: tempDir.path,
    );

    // Run heavy CPU image processing inside a background Dart Isolate so the
    // main thread stays free and the loading spinner stays smooth.
    final preprocessResult =
        await Isolate.run(() => _preprocessImageSync(params));

    InputImage inputImage;
    try {
      inputImage = InputImage.fromFilePath(preprocessResult.ocrImagePath);
    } catch (_) {
      // Fallback: use the original file if the temp path is invalid.
      inputImage = InputImage.fromFilePath(originalImagePath);
    }

    final RecognizedText result;
    try {
      result = await _recognizer.processImage(inputImage);
    } finally {
      // Always clean up temp files even if OCR throws.
      _deleteTempFiles(preprocessResult.tempFilesToDelete);
    }

    // Traverse blocks → lines → elements for maximum text coverage.
    final blocks = <OcrTextBlock>[];
    for (final block in result.blocks) {
      for (final line in block.lines) {
        for (final element in line.elements) {
          final rawBox = element.boundingBox;
          // Map bounding boxes back from the (possibly upscaled) OCR image
          // to the original display image coordinate space.
          final mappedBox = Rect.fromLTRB(
            rawBox.left / preprocessResult.scaleFactor,
            rawBox.top / preprocessResult.scaleFactor,
            rawBox.right / preprocessResult.scaleFactor,
            rawBox.bottom / preprocessResult.scaleFactor,
          );
          blocks.add(
            OcrTextBlock(text: element.text, boundingBox: mappedBox),
          );
        }
      }
    }

    return OcrAnalyzeResult(
      imagePath: preprocessResult.displayImagePath,
      fullText: result.text.trim(),
      blocks: blocks,
      imageSize: Size(preprocessResult.displayWidth, preprocessResult.displayHeight),
    );
  }

  @override
  void dispose() {
    _recognizer.close();
  }
}
