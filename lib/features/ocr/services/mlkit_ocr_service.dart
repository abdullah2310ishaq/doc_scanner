import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../models/ocr_analyze_result.dart';
import '../models/ocr_text_block.dart';
import '../utils/image_size_reader.dart';
import 'ocr_service.dart';

class MlKitOcrService implements OcrService {
  final TextRecognizer _recognizer = TextRecognizer();

  @override
  Future<OcrAnalyzeResult> analyzeImage(String imagePath) async {
    final imageSize = await readImageSize(imagePath);
    final inputImage = InputImage.fromFilePath(imagePath);
    final result = await _recognizer.processImage(inputImage);

    final blocks = <OcrTextBlock>[];
    for (final block in result.blocks) {
      blocks.add(
        OcrTextBlock(
          text: block.text,
          boundingBox: block.boundingBox,
        ),
      );
    }

    return OcrAnalyzeResult(
      imagePath: imagePath,
      fullText: result.text.trim(),
      blocks: blocks,
      imageSize: imageSize,
    );
  }

  @override
  void dispose() {
    _recognizer.close();
  }
}
