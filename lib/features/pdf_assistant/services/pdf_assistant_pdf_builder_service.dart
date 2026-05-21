import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../translate/services/translate_pdf_fonts.dart';

class PdfAssistantPdfBuilderService {
  const PdfAssistantPdfBuilderService();

  /// Extracted text PDF (clean multi-page text document)
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

        build: (context) {
          final isRtl = _isRtl(translatedText);
          final widgets = <pw.Widget>[];

          widgets.add(
            pw.Text(
              title,
              textAlign: isRtl ? pw.TextAlign.right : pw.TextAlign.left,
              textDirection: isRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
              style: TranslatePdfFonts.headerStyle(title).copyWith(
                color: const PdfColor.fromInt(0xFF1E3A8A),
              ),
            ),
          );

          widgets.add(pw.SizedBox(height: 16));

          final paragraphs = _splitIntoParagraphs(translatedText);
          for (var i = 0; i < paragraphs.length; i++) {
            final para = paragraphs[i];
            if (para.trim().isEmpty) {
              widgets.add(pw.SizedBox(height: 6));
              continue;
            }
            final isParaRtl = _isRtl(para);
            widgets.add(
              pw.Text(
                para,
                textAlign: isParaRtl ? pw.TextAlign.right : pw.TextAlign.left,
                textDirection: isParaRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
                style: TranslatePdfFonts.bodyStyle(para),
              ),
            );
            if (i < paragraphs.length - 1) {
              widgets.add(pw.SizedBox(height: 8));
            }
          }

          return widgets;
        },
      ),
    );

    final bytes = await doc.save();
    await File(outputPath).writeAsBytes(bytes);
  }

  /// Translated pages PDF (FIXED VERSION)
  Future<void> buildTranslatedPagesPdf({
    required String outputPath,
    required List<String> translatedPageTexts,
    void Function(double progress)? onProgress,
  }) async {
    await TranslatePdfFonts.ensureLoaded();

    final doc = pw.Document();
    final totalPages = translatedPageTexts.length;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(48),

        build: (context) {
          final widgets = <pw.Widget>[];

          for (var i = 0; i < totalPages; i++) {
            final rawText = translatedPageTexts[i].trim();
            final pageLabel = 'Page ${i + 1}';
            final isPageRtl = _isRtl(rawText);

            widgets.add(
              pw.Text(
                pageLabel,
                textAlign: isPageRtl ? pw.TextAlign.right : pw.TextAlign.left,
                textDirection: isPageRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
                style: TranslatePdfFonts.headerStyle(pageLabel).copyWith(
                  color: const PdfColor.fromInt(0xFF6366F1),
                  fontSize: 10,
                ),
              ),
            );

            widgets.add(pw.SizedBox(height: 6));
            widgets.add(pw.Divider(color: const PdfColor.fromInt(0xFFE5E7EB)));
            widgets.add(pw.SizedBox(height: 10));

            if (rawText.isEmpty) {
              widgets.add(
                pw.Text(
                  '[No translatable text on this page]',
                  textAlign: pw.TextAlign.left,
                  textDirection: pw.TextDirection.ltr,
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: const PdfColor.fromInt(0xFF9CA3AF),
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              );
            } else {
              final paragraphs = _splitIntoParagraphs(rawText);
              for (var j = 0; j < paragraphs.length; j++) {
                final para = paragraphs[j];
                if (para.trim().isEmpty) {
                  widgets.add(pw.SizedBox(height: 6));
                  continue;
                }
                final isParaRtl = _isRtl(para);
                widgets.add(
                  pw.Text(
                    para,
                    textAlign: isParaRtl ? pw.TextAlign.right : pw.TextAlign.left,
                    textDirection: isParaRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
                    style: TranslatePdfFonts.bodyStyle(para),
                  ),
                );
                if (j < paragraphs.length - 1) {
                  widgets.add(pw.SizedBox(height: 8));
                }
              }
            }

            widgets.add(pw.SizedBox(height: 30));

            onProgress?.call((i + 1) / totalPages);
          }

          return widgets;
        },
      ),
    );

    final bytes = await doc.save();
    await File(outputPath).writeAsBytes(bytes);
  }

  List<String> _splitIntoParagraphs(String text) {
    final normalized = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    final result = <String>[];
    for (final line in normalized.split('\n')) {
      if (line.length <= 800) {
        result.add(line);
      } else {
        // Split long line into chunks of max 800 chars, trying to break on space
        var start = 0;
        while (start < line.length) {
          var end = start + 800;
          if (end >= line.length) {
            result.add(line.substring(start));
            break;
          }
          // Find last space in the chunk
          var lastSpace = line.lastIndexOf(' ', end);
          if (lastSpace > start) {
            result.add(line.substring(start, lastSpace));
            start = lastSpace + 1;
          } else {
            // No space found, hard cut
            result.add(line.substring(start, end));
            start = end;
          }
        }
      }
    }
    return result;
  }

  bool _isRtl(String text) {
    return text.runes.any(
      (code) =>
          (code >= 0x0590 && code <= 0x05FF) || // Hebrew
          (code >= 0x0600 && code <= 0x06FF) || // Arabic, Urdu, Persian
          (code >= 0x0750 && code <= 0x077F) || // Arabic Supplement
          (code >= 0x08A0 && code <= 0x08FF) || // Arabic Extended-A
          (code >= 0xFB50 && code <= 0xFDFF) || // Arabic Presentation Forms-A
          (code >= 0xFE70 && code <= 0xFEFF),   // Arabic Presentation Forms-B
    );
  }
}
