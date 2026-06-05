import 'dart:io';

import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';


class DocumentScannerService {
  /// Returns true only on Android where Google Play Services is available.
  static bool get isSupported => Platform.isAndroid;

  /// Launches the native Google document scanner UI and returns the paths of
  /// the corrected page images.
  ///
  /// [pageLimit] — maximum pages the user can scan (default 1 for OCR).
  /// Returns null if the user cancels, the platform is unsupported, or an
  /// error occurs.
  Future<List<String>?> scanDocument({
    int pageLimit = 1,
    bool isGalleryImport = true,
  }) async {
    if (!isSupported) return null;

    final scanner = DocumentScanner(
      options: DocumentScannerOptions(
        // JPEG output — lighter and faster than PDF for OCR use-case.
        documentFormats: const {DocumentFormat.jpeg},
        // filter mode applies perspective correction, shadow removal, etc.
        mode: ScannerMode.filter,
        isGalleryImport: isGalleryImport,
        pageLimit: pageLimit,
      ),
    );

    try {
      final result = await scanner.scanDocument();
      // result.images may be null on some GMS versions — guard defensively.
      final images = result.images;
      if (images == null || images.isEmpty) return null;
      return images;
    } catch (_) {
      // User cancelled or GMS not available — return null gracefully.
      return null;
    } finally {
      scanner.close();
    }
  }
}
