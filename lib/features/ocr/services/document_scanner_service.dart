import 'dart:io';

import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

/// Wraps Google ML Kit Document Scanner API.
///
/// Key capabilities provided by Google's native scanner UI:
/// - Automatic document edge detection
/// - Perspective correction (de-warping tilted pages)
/// - Auto-rotation so the page is always upright
/// - Shadow / stain removal filter
///
/// Android only — requires Google Play Services.
class DocumentScannerService {
  /// Returns true only on Android where Google Play Services is available.
  static bool get isSupported => Platform.isAndroid;

  /// Launches the native Google document scanner UI and returns the paths of
  /// the corrected page images.
  ///
  /// [pageLimit] — maximum pages the user can scan (default 1 for OCR).
  /// Returns null if the user cancels, the platform is unsupported, or an
  /// error occurs.
  Future<List<String>?> scanDocument({int pageLimit = 1}) async {
    if (!isSupported) return null;

    final scanner = DocumentScanner(
      options: DocumentScannerOptions(
        // JPEG output — lighter and faster than PDF for OCR use-case.
        documentFormats: const {DocumentFormat.jpeg},
        // filter mode applies perspective correction, shadow removal, etc.
        mode: ScannerMode.filter,
        // Allow the user to also import a photo from their gallery.
        isGalleryImport: true,
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
