import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../translate/services/translate_pdf_fonts.dart';

/// Coordinates PDF output generation:
///  • Translated PDF → produced as a text document using package:pdf.
///  • Extracted-text PDF → clean text document using package:pdf.
class PdfAssistantPdfBuilderService {
  const PdfAssistantPdfBuilderService();

  /// Builds the extracted-text PDF (a fresh text layout — no original images).
  Future<void> buildExtractedTextPdf({
    required String outputPath,
    required String title,
    required String translatedText,
  }) async {
    await TranslatePdfFonts.ensureLoaded();

    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(48),
        build: (context) => [
          pw.Text(
            title,
            style: TranslatePdfFonts.headerStyle(title).copyWith(
              color: const PdfColor.fromInt(0xFF1E3A8A),
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            translatedText,
            style: TranslatePdfFonts.bodyStyle(translatedText),
          ),
        ],
      ),
    );

    final bytes = await doc.save();
    await File(outputPath).writeAsBytes(bytes);
  }

  /// Builds the translated PDF by creating a new document from pre-translated pages.
  Future<void> buildTranslatedPagesPdf({
    required String outputPath,
    required List<String> translatedPageTexts,
    void Function(double progress)? onProgress,
  }) async {
    await TranslatePdfFonts.ensureLoaded();

    final doc = pw.Document();
    final totalPages = translatedPageTexts.length;

    for (var i = 0; i < totalPages; i++) {
      // Capture loop variable before entering the builder closure.
      final pageIndex = i;
      final pageText = translatedPageTexts[pageIndex].trim();
      final pageLabel = 'Page ${pageIndex + 1}';

      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(48),
          build: (context) => [
            pw.Text(
              pageLabel,
              style: TranslatePdfFonts.headerStyle(pageLabel).copyWith(
                color: const PdfColor.fromInt(0xFF6366F1),
                fontSize: 9,
              ),
            ),
            pw.SizedBox(height: 6),
            pw.Divider(color: const PdfColor.fromInt(0xFFE5E7EB)),
            pw.SizedBox(height: 10),
            if (pageText.isEmpty)
              pw.Text(
                '[No translatable text on this page]',
                style: pw.TextStyle(
                  fontSize: 11,
                  color: const PdfColor.fromInt(0xFF9CA3AF),
                  fontStyle: pw.FontStyle.italic,
                ),
              )
            else
              pw.Text(
                pageText,
                style: TranslatePdfFonts.bodyStyle(pageText),
              ),
          ],
        ),
      );

      onProgress?.call((pageIndex + 1) / totalPages);
    }

    final bytes = await doc.save();
    await File(outputPath).writeAsBytes(bytes);
  }
}
