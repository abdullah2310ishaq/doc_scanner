import '../models/ocr_analyze_result.dart';

abstract class OcrService {
  Future<OcrAnalyzeResult> analyzeImage(String imagePath);

  void dispose();
}
