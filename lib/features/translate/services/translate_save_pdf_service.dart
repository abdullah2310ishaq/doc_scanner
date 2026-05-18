import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/translate_export_data.dart';
import '../models/translate_export_scope.dart';

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

  Future<void> save({
    required TranslateExportData data,
    required TranslateExportScope scope,
  }) async {
    final bytes = await buildBytes(data: data, scope: scope);
    final fileName = _fileName(scope);

    await _writeToExportsFolder(bytes, fileName);

    try {
      await Printing.sharePdf(bytes: bytes, filename: fileName);
    } catch (_) {
      // File is already saved locally; share sheet cancel should not fail export.
    }
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
                data.sourceText,
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

    final translation = data.translatedText?.trim();
    if (translation != null && translation.isNotEmpty) {
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
          translation,
          style: const pw.TextStyle(fontSize: 14, lineSpacing: 4),
        ),
      ]);
    }

    return widgets;
  }

  Future<void> _writeToExportsFolder(Uint8List bytes, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final exportsDir = Directory(p.join(dir.path, 'exports'));
    if (!await exportsDir.exists()) {
      await exportsDir.create(recursive: true);
    }

    final file = File(p.join(exportsDir.path, fileName));
    await file.writeAsBytes(bytes);
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
