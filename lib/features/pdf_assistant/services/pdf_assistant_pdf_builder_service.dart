import 'dart:io';
import 'dart:ui';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;

import '../../translate/services/translate_pdf_fonts.dart';

/// Builds translated PDF outputs (simple layout; not pixel-perfect overlay).
class PdfAssistantPdfBuilderService {
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

  /// Per-page translated text; keeps page count similar to source.
  Future<void> buildTranslatedPagesPdf({
    required String outputPath,
    required String sourcePdfPath,
    required List<String> translatedPageTexts,
    required String languageName,
  }) async {
    final sourceBytes = await File(sourcePdfPath).readAsBytes();
    final sourceDoc = sf.PdfDocument(inputBytes: sourceBytes);

    try {
      final outDoc = sf.PdfDocument();
      final pageCount = sourceDoc.pages.count;

      for (var i = 0; i < pageCount; i++) {
        final template = sourceDoc.pages[i].createTemplate();
        final pageText = i < translatedPageTexts.length
            ? translatedPageTexts[i].trim()
            : '';

        final newPage = outDoc.pages.add();
        final graphics = newPage.graphics;
        final pageSize = newPage.size;

        graphics.drawPdfTemplate(template, Offset.zero);

        if (pageText.isNotEmpty) {
          final overlayBrush = sf.PdfSolidBrush(sf.PdfColor(255, 255, 255, 220));
          final textHeight = pageSize.height * 0.35;
          graphics.drawRectangle(
            brush: overlayBrush,
            bounds: Rect.fromLTWH(
              0,
              pageSize.height - textHeight,
              pageSize.width,
              textHeight,
            ),
          );

          final font = sf.PdfStandardFont(
            sf.PdfFontFamily.helvetica,
            10,
          );
          final brush = sf.PdfSolidBrush(sf.PdfColor(0, 0, 0));
          final format = sf.PdfStringFormat(
            alignment: sf.PdfTextAlignment.left,
            lineAlignment: sf.PdfVerticalAlignment.top,
            wordWrap: sf.PdfWordWrapType.word,
          );

          graphics.drawString(
            pageText,
            font,
            brush: brush,
            bounds: Rect.fromLTWH(
              24,
              pageSize.height - textHeight + 12,
              pageSize.width - 48,
              textHeight - 24,
            ),
            format: format,
          );
        }
      }

      final outBytes = await outDoc.save();
      await File(outputPath).writeAsBytes(outBytes);
      outDoc.dispose();
    } finally {
      sourceDoc.dispose();
    }
  }
}
