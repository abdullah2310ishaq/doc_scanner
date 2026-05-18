import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/translate_export_data.dart';
import '../models/translate_export_scope.dart';
import 'translate_export_storage.dart';

class TranslateSavePdfService {
  Future<Uint8List> buildBytes({
    required TranslateExportData data,
    required TranslateExportScope scope,
  }) async {
    final text = data.textForScope(scope);
    if (text.trim().isEmpty) {
      throw StateError('Nothing to export');
    }

    return Uint8List.fromList(
      await _buildPdfBytes(data: data, scope: scope),
    );
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
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return switch (scope) {
            TranslateExportScope.selectedText => [
              pw.Text(
                data.translatedTextOnly,
                style: const pw.TextStyle(fontSize: 14, lineSpacing: 4),
              ),
            ],
            TranslateExportScope.completeFile => _completeFileWidgets(data),
          };
        },
      ),
    );

    return doc.save();
  }

  List<pw.Widget> _completeFileWidgets(TranslateExportData data) {
    final widgets = <pw.Widget>[
      pw.Text(
        data.selectedTextLabel,
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blue800,
        ),
      ),
      pw.SizedBox(height: 8),
      pw.Text(
        data.sourceText,
        style: const pw.TextStyle(fontSize: 14, lineSpacing: 4),
      ),
    ];

    if (data.hasTranslatedText) {
      final title = data.targetLanguageName == null
          ? data.translatedTextLabel
          : '${data.translatedTextLabel} (${data.targetLanguageName})';

      widgets.addAll([
        pw.SizedBox(height: 24),
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue800,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          data.translatedText!.trim(),
          style: const pw.TextStyle(fontSize: 14, lineSpacing: 4),
        ),
      ]);
    }

    return widgets;
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
