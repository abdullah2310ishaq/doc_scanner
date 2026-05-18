import 'dart:typed_data';

import 'package:printing/printing.dart';

import '../models/translate_export_data.dart';
import '../models/translate_export_scope.dart';
import 'translate_export_storage.dart';
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
    return TranslateExportStorage.saveBytes(bytes: pngBytes, fileName: fileName);
  }

  Future<Uint8List> _rasterFirstPage(Uint8List pdfBytes) async {
    final rasterStream = Printing.raster(pdfBytes, dpi: 144);

    await for (final page in rasterStream) {
      return page.toPng();
    }

    throw StateError('Could not rasterize PNG');
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
