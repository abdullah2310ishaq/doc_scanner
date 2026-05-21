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
    const primaryColor = PdfColor.fromInt(0xFF1E3A8A);
    const secondaryColor = PdfColor.fromInt(0xFF475569);
    const dividerColor = PdfColor.fromInt(0xFFE2E8F0);

    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 48, vertical: 48),
        header: (context) => pw.Container(
          alignment: pw.Alignment.topRight,
          margin: const pw.EdgeInsets.only(bottom: 24),
          child: pw.Container(height: 3, color: primaryColor),
        ),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 24),
          child: pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: pw.TextStyle(
              fontSize: 10,
              color: secondaryColor,
              font: TranslatePdfFonts.bodyStyle('Page').font,
            ),
          ),
        ),
        build: (context) {
          return switch (scope) {
            TranslateExportScope.selectedText => [
              _buildHeader(
                title: data.selectedTextLabel,
                primaryColor: primaryColor,
              ),
              pw.SizedBox(height: 16),
              _buildBodyText(data.selectedTextOnly),
            ],
            TranslateExportScope.completeFile => _completeFileWidgets(
              data,
              primaryColor,
              dividerColor,
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
    PdfColor dividerColor,
  ) {
    final widgets = <pw.Widget>[
      _buildHeader(title: data.selectedTextLabel, primaryColor: primaryColor),
      pw.SizedBox(height: 16),
      _buildBodyText(data.sourceText.trim()),
    ];

    if (data.hasTranslatedText) {
      final title = data.targetLanguageName == null
          ? data.translatedTextLabel
          : '${data.translatedTextLabel} (${data.targetLanguageName})';

      widgets.addAll([
        pw.SizedBox(height: 32),
        pw.Divider(color: dividerColor, height: 1, thickness: 1),
        pw.SizedBox(height: 24),
        _buildHeader(title: title, primaryColor: primaryColor),
        pw.SizedBox(height: 16),
        _buildBodyText((data.translatedText ?? '').trim()),
      ]);
    }

    return widgets;
  }

  pw.Widget _buildHeader({
    required String title,
    required PdfColor primaryColor,
  }) {
    // Do NOT call toUpperCase() — it breaks CJK, Arabic, and Urdu glyphs.
    return pw.Text(
      title,
      style: TranslatePdfFonts.headerStyle(title).copyWith(color: primaryColor),
    );
  }

  pw.Widget _buildBodyText(String text) {
    return pw.Text(text, style: TranslatePdfFonts.bodyStyle(text));
  }

  String _fileName(TranslateExportScope scope) {
    final suffix = switch (scope) {
      TranslateExportScope.selectedText => 'selected',
      TranslateExportScope.completeFile => 'complete',
    };
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'translation_${suffix}_$timestamp.pdf';
  }
}
