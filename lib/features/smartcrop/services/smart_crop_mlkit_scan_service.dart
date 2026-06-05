import '../../../core/constants/smart_crop_limits.dart';
import '../../ocr/services/document_scanner_service.dart';

/// Android ML Kit document scanner — edge detect, perspective fix, filters (GMS).
class SmartCropMlKitScanService {
  final _scanner = DocumentScannerService();

  /// Opens Google's ML Kit scanner UI. Returns dewarped JPEG paths.
  Future<List<String>?> scanPages({
    int limit = SmartCropLimits.maxPages,
    bool isGalleryImport = false,
  }) {
    return _scanner.scanDocument(
      pageLimit: limit,
      isGalleryImport: isGalleryImport,
    );
  }
}
