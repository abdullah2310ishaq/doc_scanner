import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfAssistantExtractService {
  Future<PdfExtractResult> extract(String pdfPath) async {
    final file = File(pdfPath);
    if (!await file.exists()) {
      throw StateError('file_not_found');
    }

    final bytes = await file.readAsBytes();
    final document = PdfDocument(inputBytes: bytes);
    try {
      final pages = <String>[];
      for (var i = 0; i < document.pages.count; i++) {
        final extractor = PdfTextExtractor(document);
        final pageText = extractor.extractText(
          startPageIndex: i,
          endPageIndex: i,
        );
        pages.add(pageText.trim());
      }

      final fullText = pages.where((p) => p.isNotEmpty).join('\n\n');
      if (fullText.trim().isEmpty) {
        throw StateError('empty_pdf');
      }

      return PdfExtractResult(fullText: fullText, pageTexts: pages);
    } finally {
      document.dispose();
    }
  }
}

class PdfExtractResult {
  const PdfExtractResult({
    required this.fullText,
    required this.pageTexts,
  });

  final String fullText;
  final List<String> pageTexts;
}
