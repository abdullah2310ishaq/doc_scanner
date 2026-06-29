import 'dart:io';

import '../constants/pdf_limits.dart';

class PdfTooLargeException implements Exception {
  const PdfTooLargeException();
}

Future<void> validatePdfSize(File file) async {
  final fileSize = await file.length();
  if (fileSize > PdfLimits.maxUploadSizeBytes) {
    throw const PdfTooLargeException();
  }
}
