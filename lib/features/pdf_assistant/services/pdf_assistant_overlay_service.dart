import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'pdf_assistant_translate_service.dart';

// ── Isolate-safe data classes ──────────────────────────────────────────────

class _LineData {
  const _LineData({
    required this.text,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.fontSize,
  });
  final String text;
  final double left, top, width, height, fontSize;
}

class _OverlayEntry {
  const _OverlayEntry({required this.source, required this.translated});
  final _LineData source;
  final String translated;
}

class _ApplyArgs {
  const _ApplyArgs({
    required this.pdfBytes,
    required this.pageEntries,
    required this.latinFont,
    required this.arabicFont,
  });
  final List<int> pdfBytes;
  final List<List<_OverlayEntry>> pageEntries;
  final Uint8List latinFont;
  final Uint8List arabicFont;
}

// ── Top-level compute function (runs in a background isolate) ──────────────

Future<Uint8List> _applyOverlays(_ApplyArgs args) async {
  final doc = PdfDocument(inputBytes: args.pdfBytes);
  try {
    for (var pi = 0; pi < args.pageEntries.length; pi++) {
      if (pi >= doc.pages.count) break;
      final entries = args.pageEntries[pi];
      if (entries.isEmpty) continue;
      final g = doc.pages[pi].graphics;

      for (final entry in entries) {
        if (entry.translated.isEmpty) continue;
        final s = entry.source;
        final bounds = Rect.fromLTWH(s.left, s.top, s.width, s.height);
        final isArabic = _isArabicScript(entry.translated);

        // Erase original text
        g.drawRectangle(
          brush: PdfSolidBrush(PdfColor(255, 255, 255)),
          bounds: bounds,
        );

        // Pick correct font bytes
        final fontBytes = isArabic ? args.arabicFont : args.latinFont;

        // Shrink-to-fit
        double fontSize = s.fontSize > 0 ? s.fontSize : 10.0;
        PdfFont font = PdfTrueTypeFont(fontBytes, fontSize);
        try {
          while (fontSize > 4.0) {
            font = PdfTrueTypeFont(fontBytes, fontSize);
            final w = font.measureString(entry.translated).width;
            if (w <= bounds.width + 2) break;
            fontSize -= 0.5;
          }
        } catch (_) {
          // Some glyphs can't be measured — use current size as-is
        }

        // Draw translated text
        try {
          g.drawString(
            entry.translated,
            font,
            brush: PdfSolidBrush(PdfColor(0, 0, 0)),
            bounds: bounds,
            format: PdfStringFormat(
              alignment: isArabic
                  ? PdfTextAlignment.right
                  : PdfTextAlignment.left,
              lineAlignment: PdfVerticalAlignment.middle,
              wordWrap: PdfWordWrapType.word,
            ),
          );
        } catch (e) {
          if (kDebugMode) debugPrint('[Overlay] drawString p$pi: $e');
        }
      }
    }
    final out = await doc.save();
    return Uint8List.fromList(out);
  } finally {
    doc.dispose();
  }
}

bool _isArabicScript(String t) => t.runes.any(
  (c) =>
      (c >= 0x0600 && c <= 0x06FF) ||
      (c >= 0x0750 && c <= 0x077F) ||
      (c >= 0xFB50 && c <= 0xFDFF) ||
      (c >= 0xFE70 && c <= 0xFEFF),
);

// ── Service ────────────────────────────────────────────────────────────────

/// Translates a PDF in-place:
///   1. Extracts per-line text with exact bounding boxes.
///   2. Batch-translates each page via a single OpenAI call.
///   3. Applies white-erase + redraw in a background isolate (no UI freeze).
class PdfAssistantOverlayService {
  PdfAssistantOverlayService({PdfAssistantTranslateService? translateService})
    : _translateService = translateService ?? PdfAssistantTranslateService();

  final PdfAssistantTranslateService _translateService;

  static const _latinFontAsset = 'assets/fonts/NotoSans-Regular.ttf';
  static const _arabicFontAsset = 'assets/fonts/NotoNaskhArabic-Regular.ttf';

  Future<List<int>> translateInPlace({
    required String sourcePdfPath,
    required String targetLanguageName,
    required String targetLanguageCode,
    void Function(double progress)? onProgress,
  }) async {
    final sourceBytes = await File(sourcePdfPath).readAsBytes();

    // Load font bytes on main isolate — rootBundle doesn't work in isolates
    final latinFont = await _loadFontBytes(_latinFontAsset);
    final arabicFont = await _loadFontBytes(_arabicFontAsset);

    // ── Step 1: Extract TextLines per page ────────────────────────────────
    final allLines = _extractAllLines(sourceBytes);
    final pageCount = allLines.length;

    // ── Step 2: Translate per page via OpenAI (HTTP, must be main isolate) ─
    const delimiter = '|||';
    final pageEntries = <List<_OverlayEntry>>[];

    for (var pi = 0; pi < pageCount; pi++) {
      final lines = allLines[pi];
      final nonEmpty = lines.where((l) => l.text.isNotEmpty).toList();

      if (nonEmpty.isEmpty) {
        pageEntries.add([]);
        onProgress?.call((pi + 1) / pageCount);
        continue;
      }

      final batchInput = nonEmpty.map((l) => l.text).join('\n$delimiter\n');
      String batchOutput;
      try {
        batchOutput = await _translateService.translateText(
          text: _batchPrompt(batchInput, delimiter),
          targetLanguageName: targetLanguageName,
          targetLanguageCode: targetLanguageCode,
        );
      } catch (e) {
        if (kDebugMode) debugPrint('[Overlay] translate p$pi: $e');
        pageEntries.add([]);
        onProgress?.call((pi + 1) / pageCount);
        continue;
      }

      final parts = batchOutput
          .split(RegExp(r'\|\|\|'))
          .map((s) => s.trim())
          .toList();

      final entries = <_OverlayEntry>[];
      for (var i = 0; i < nonEmpty.length; i++) {
        entries.add(
          _OverlayEntry(
            source: nonEmpty[i],
            translated: i < parts.length ? parts[i] : nonEmpty[i].text,
          ),
        );
      }
      pageEntries.add(entries);
      onProgress?.call((pi + 1) / pageCount);
    }

    // ── Step 3: Apply overlays in background isolate (no UI freeze) ───────
    final result = await compute(
      _applyOverlays,
      _ApplyArgs(
        pdfBytes: sourceBytes,
        pageEntries: pageEntries,
        latinFont: latinFont,
        arabicFont: arabicFont,
      ),
    );

    return result;
  }

  // Extracts TextLine data from all pages synchronously (fast, no HTTP)
  List<List<_LineData>> _extractAllLines(List<int> pdfBytes) {
    final doc = PdfDocument(inputBytes: pdfBytes);
    final result = <List<_LineData>>[];
    try {
      final extractor = PdfTextExtractor(doc);
      for (var i = 0; i < doc.pages.count; i++) {
        try {
          final lines = extractor.extractTextLines(
            startPageIndex: i,
            endPageIndex: i,
          );
          result.add(
            lines
                .where((l) => l.text.trim().isNotEmpty)
                .map(
                  (l) => _LineData(
                    text: l.text.trim(),
                    left: l.bounds.left,
                    top: l.bounds.top,
                    width: l.bounds.width,
                    height: l.bounds.height,
                    fontSize: l.fontSize,
                  ),
                )
                .toList(),
          );
        } catch (e) {
          if (kDebugMode) debugPrint('[Overlay] extract p$i: $e');
          result.add([]);
        }
      }
    } finally {
      doc.dispose();
    }
    return result;
  }

  Future<Uint8List> _loadFontBytes(String assetPath) async {
    try {
      final data = await rootBundle.load(assetPath);
      return data.buffer.asUint8List();
    } catch (e) {
      // Fallback: return empty — PdfTrueTypeFont will throw but drawString
      // won't crash; errors are caught per-line in the isolate.
      if (kDebugMode) debugPrint('[Overlay] font load failed $assetPath: $e');
      return Uint8List(0);
    }
  }

  String _batchPrompt(String input, String delimiter) =>
      'Translate each segment separated by "$delimiter" into the target '
      'language. Return ONLY the translations in the same order, separated '
      'by "$delimiter". No explanations, no changed delimiters.\n\n$input';
}
