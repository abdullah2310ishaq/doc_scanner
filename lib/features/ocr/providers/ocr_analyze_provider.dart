import 'package:flutter/foundation.dart';

import '../models/ocr_analyze_result.dart';
import '../services/mlkit_ocr_service.dart';
import '../services/ocr_service.dart';

enum OcrAnalyzeStatus { loading, ready, empty, error }

class OcrAnalyzeProvider extends ChangeNotifier {
  OcrAnalyzeProvider({
    required this.imagePath,
    OcrService? ocrService,
  }) : _ocrService = ocrService ?? MlKitOcrService();

  final String imagePath;
  final OcrService _ocrService;

  OcrAnalyzeStatus _status = OcrAnalyzeStatus.loading;
  OcrAnalyzeResult? _result;
  String? _errorMessage;

  OcrAnalyzeStatus get status => _status;
  OcrAnalyzeResult? get result => _result;
  String? get errorMessage => _errorMessage;

  Future<void> analyze() async {
    _status = OcrAnalyzeStatus.loading;
    notifyListeners();

    try {
      _result = await _ocrService.analyzeImage(imagePath);
      _errorMessage = null;
      _status = _result!.fullText.trim().isEmpty
          ? OcrAnalyzeStatus.empty
          : OcrAnalyzeStatus.ready;
    } catch (error) {
      _errorMessage = error.toString();
      _status = OcrAnalyzeStatus.error;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }
}
