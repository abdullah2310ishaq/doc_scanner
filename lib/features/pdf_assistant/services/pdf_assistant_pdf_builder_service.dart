import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../translate/services/translate_pdf_fonts.dart';
import 'pdf_assistant_overlay_service.dart';
import 'pdf_assistant_translate_service.dart';

/// Coordinates PDF output generation:
///  • Translated PDF → produced via in-place overlay on the original.
///  • Extracted-text PDF → clean text document using package:pdf.
class PdfAssistantPdfBuilderService {
  PdfAssistantPdfBuilderService({PdfAssistantTranslateService? translateService})
      : _overlayService = PdfAssistantOverlayService(
          translateService: translateService,
        );

  final PdfAssistantOverlayService _overlayService;

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

  /// Builds the translated PDF by overlaying translations directly onto the
  /// original PDF pages — preserving layout, images, and visual structure.
  Future<void> buildTranslatedPagesPdf({
    required String outputPath,
    required String sourcePdfPath,
    // Kept for API compatibility — overlay service re-translates per line.
    // These pre-translated page texts are used only for the extracted-text PDF.
    required List<String> translatedPageTexts,
    required String languageName,
    required String languageCode,
    void Function(double progress)? onProgress,
  }) async {
    final resultBytes = await _overlayService.translateInPlace(
      sourcePdfPath: sourcePdfPath,
      targetLanguageName: languageName,
      targetLanguageCode: languageCode,
      onProgress: onProgress,
    );
    await File(outputPath).writeAsBytes(resultBytes);
  }
}
