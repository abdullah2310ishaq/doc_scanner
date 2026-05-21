import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/translate_export_data.dart';
import '../models/translate_export_scope.dart';
import 'translate_export_storage.dart';
import 'translate_pdf_fonts.dart';

class TranslateSavePdfService {
  Future<Uint8List> buildBytes({
    required TranslateExportData data,
    required TranslateExportScope scope,
  }) async {
    final text = data.textForScope(scope);
    if (text.trim().isEmpty) {
      throw StateError('Nothing to export');
    }

    await TranslatePdfFonts.ensureLoaded();
    return Uint8List.fromList(await _buildPdfBytes(data: data, scope: scope));
  }

  Future<String> save({
    required TranslateExportData data,
    required TranslateExportScope scope,
  }) async {
    final bytes = await buildBytes(data: data, scope: scope);
    final fileName = _fileName(scope);
    return TranslateExportStorage.saveBytes(bytes: bytes, fileName: fileName);
  }

  Future<List<int>> _buildPdfBytes({
    required TranslateExportData data,
    required TranslateExportScope scope,
  }) async {
    // Professional Corporate Color Palette
    const primaryColor = PdfColor.fromInt(0xFF0F172A); // Deep Slate / Navy
    const secondaryColor = PdfColor.fromInt(0xFF475569); // Muted Slate
    const borderColor = PdfColor.fromInt(0xFFE2E8F0); // Light Border Gray
    const backgroundColor = PdfColor.fromInt(
      0xFFF8FAFC,
    ); // Soft Background White

    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40), // Standard corporate margins
        header: (context) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 20),
          padding: const pw.EdgeInsets.only(bottom: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: borderColor, width: 0.5),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment:
                pw.MainAxisAlignment.spaceBetween, // Fixed typo here
            children: [
              pw.Text(
                'Translation Export',
                style: pw.TextStyle(
                  fontSize: 9,
                  color: secondaryColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                _getFormattedDate(),
                style: const pw.TextStyle(fontSize: 9, color: secondaryColor),
              ),
            ],
          ),
        ),
        footer: (context) => pw.Container(
          margin: const pw.EdgeInsets.only(top: 20),
          padding: const pw.EdgeInsets.only(top: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(color: borderColor, width: 0.5),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment:
                pw.MainAxisAlignment.spaceBetween, // Fixed typo here
            children: [
              pw.Text(
                'Confidential Document',
                style: const pw.TextStyle(fontSize: 9, color: secondaryColor),
              ),
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: pw.TextStyle(
                  fontSize: 9,
                  color: secondaryColor,
                  font: TranslatePdfFonts.bodyStyle('Page').font,
                ),
              ),
            ],
          ),
        ),
        build: (context) {
          return switch (scope) {
            TranslateExportScope.selectedText => [
              _buildHeader(
                title: data.selectedTextLabel,
                primaryColor: primaryColor,
                isRtl: _isRtl(data.selectedTextOnly),
              ),
              pw.SizedBox(height: 12),
              ..._buildParagraphs(data.selectedTextOnly),
            ],
            TranslateExportScope.translatedText => [
              _buildHeader(
                title: data.translatedTextLabel,
                primaryColor: primaryColor,
                isRtl: _isRtl(data.translatedText ?? ''),
              ),
              pw.SizedBox(height: 12),
              ..._buildParagraphs(data.translatedText ?? ''),
            ],
            TranslateExportScope.completeFile => _completeFileWidgets(
              data,
              primaryColor,
              borderColor,
              backgroundColor,
            ),
          };
        },
      ),
    );

    return doc.save();
  }

  List<pw.Widget> _completeFileWidgets(
    TranslateExportData data,
    PdfColor primaryColor,
    PdfColor borderColor,
    PdfColor backgroundColor,
  ) {
    final sourceText = data.sourceText.trim();
    final isSourceRtl = _isRtl(sourceText);

    final widgets = <pw.Widget>[
      _buildHeader(
        title: data.selectedTextLabel,
        primaryColor: primaryColor,
        isRtl: isSourceRtl,
      ),
      pw.SizedBox(height: 12),
      ..._buildParagraphs(sourceText),
    ];

    if (data.hasTranslatedText) {
      final translatedText = (data.translatedText ?? '').trim();
      final isTranslatedRtl = _isRtl(translatedText);
      final title = data.targetLanguageName == null
          ? data.translatedTextLabel
          : '${data.translatedTextLabel} (${data.targetLanguageName})';

      widgets.addAll([
        pw.SizedBox(height: 28),
        _buildHeader(
          title: title,
          primaryColor: primaryColor,
          isRtl: isTranslatedRtl,
        ),
        pw.SizedBox(height: 12),
        ..._buildParagraphs(translatedText),
      ]);
    }

    return widgets;
  }

  pw.Widget _buildHeader({
    required String title,
    required PdfColor primaryColor,
    bool isRtl = false,
  }) {
    return pw.Directionality(
      textDirection: isRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Container(
            width: 4,
            height: 16,
            decoration: pw.BoxDecoration(
              color: primaryColor,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
            ),
          ),
          pw.SizedBox(width: 8),
          pw.Text(
            title,
            style: TranslatePdfFonts.headerStyle(title).copyWith(
              color: primaryColor,
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<pw.Widget> _buildParagraphs(String text) {
    final normalized = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    final paragraphs = _splitIntoParagraphs(normalized);
    final widgets = <pw.Widget>[];

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
          style: TranslatePdfFonts.bodyStyle(para).copyWith(
            fontSize: 10.5,
            lineSpacing: 4,
          ),
        ),
      );
      if (i < paragraphs.length - 1) {
        widgets.add(pw.SizedBox(height: 8));
      }
    }
    return widgets;
  }

  List<String> _splitIntoParagraphs(String text) {
    final result = <String>[];
    for (final line in text.split('\n')) {
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

  String _getFormattedDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  String _fileName(TranslateExportScope scope) {
    final suffix = switch (scope) {
      TranslateExportScope.selectedText => 'selected',
      TranslateExportScope.translatedText => 'translated',
      TranslateExportScope.completeFile => 'complete',
    };
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'translation_${suffix}_$timestamp.pdf';
  }
}
