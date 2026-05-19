import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Reads plain text from a PDF file on device.
class ChatbotPdfExtractService {
  Future<String> extractText(String pdfPath) async {
    final file = File(pdfPath);
    if (!await file.exists()) {
      throw StateError('PDF file not found');
    }

    final bytes = await file.readAsBytes();
    final document = PdfDocument(inputBytes: bytes);
    try {
      final extractor = PdfTextExtractor(document);
      return extractor.extractText().trim();
    } finally {
      document.dispose();
    }
  }
}
