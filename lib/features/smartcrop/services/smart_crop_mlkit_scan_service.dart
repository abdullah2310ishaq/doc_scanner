import '../../../core/constants/smart_crop_limits.dart';
import '../../ocr/services/document_scanner_service.dart';

/// Android ML Kit document scanner — edge detect, perspective fix, filters (GMS).
class SmartCropMlKitScanService {
  final _scanner = DocumentScannerService();

  /// Opens Google's scanner UI (gallery import enabled). Returns dewarped JPEG paths.
  Future<List<String>?> scanPages({
    int limit = SmartCropLimits.maxPages,
  }) {
    return _scanner.scanDocument(pageLimit: limit);
  }
}
