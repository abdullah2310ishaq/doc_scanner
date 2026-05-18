import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../models/translate_export_data.dart';
import '../models/translate_export_scope.dart';
import 'translate_save_pdf_service.dart';

class TranslateSavePngService {
  final TranslateSavePdfService _pdfService;

  TranslateSavePngService({TranslateSavePdfService? pdfService})
      : _pdfService = pdfService ?? TranslateSavePdfService();

  Future<String> save({
    required TranslateExportData data,
    required TranslateExportScope scope,
  }) async {
    final pdfBytes = await _pdfService.buildBytes(data: data, scope: scope);
    final pngBytes = await _rasterFirstPage(pdfBytes);
    final fileName = _fileName(scope);
    final filePath = await _writeToExportsFolder(pngBytes, fileName);

    try {
      await SharePlus.instance.share(
        ShareParams(files: [XFile(filePath)]),
      );
    } catch (_) {
      // File is already saved locally; share sheet cancel should not fail export.
    }

    return filePath;
  }

  Future<Uint8List> _rasterFirstPage(Uint8List pdfBytes) async {
    final rasterStream = Printing.raster(pdfBytes, dpi: 144);

    await for (final page in rasterStream) {
      return page.toPng();
    }

    throw StateError('Could not rasterize PNG');
  }

  Future<String> _writeToExportsFolder(Uint8List bytes, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final exportsDir = Directory(p.join(dir.path, 'exports'));
    if (!await exportsDir.exists()) {
      await exportsDir.create(recursive: true);
    }

    final filePath = p.join(exportsDir.path, fileName);
    await File(filePath).writeAsBytes(bytes);
    return filePath;
  }

  String _fileName(TranslateExportScope scope) {
    final suffix = switch (scope) {
      TranslateExportScope.selectedText => 'selected',
      TranslateExportScope.completeFile => 'complete',
    };
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'translation_${suffix}_$timestamp.png';
  }
}
