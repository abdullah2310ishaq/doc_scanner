import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Loads fonts that support Latin, Arabic/Urdu, and Indic scripts in exported PDFs.
abstract final class TranslatePdfFonts {
  static pw.Font? _latin;
  static pw.Font? _arabic;
  static pw.Font? _devanagari;

  static Future<void> ensureLoaded() async {
    _latin ??= await PdfGoogleFonts.notoSansRegular();
    _arabic ??= await PdfGoogleFonts.notoNaskhArabicRegular();
    _devanagari ??= await PdfGoogleFonts.notoSansDevanagariRegular();
  }

  static pw.TextStyle bodyStyle(String text, {bool bold = false}) {
    final font = _fontFor(text);
    return pw.TextStyle(
      font: font,
      fontSize: 12,
      lineSpacing: 6,
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
      color: const PdfColor.fromInt(0xFF1F2937),
    );
  }

  static pw.TextStyle headerStyle(String text) {
    final font = _fontFor(text);
    return pw.TextStyle(
      font: font,
      fontSize: 12,
      letterSpacing: 1.5,
      fontWeight: pw.FontWeight.bold,
    );
  }

  static pw.Font _fontFor(String text) {
    if (_containsDevanagari(text) && _devanagari != null) {
      return _devanagari!;
    }
    if (_containsArabicScript(text) && _arabic != null) {
      return _arabic!;
    }
    return _latin ?? pw.Font.helvetica();
  }

  static bool _containsArabicScript(String text) {
    return text.runes.any(
      (code) =>
          (code >= 0x0600 && code <= 0x06FF) ||
          (code >= 0x0750 && code <= 0x077F) ||
          (code >= 0xFB50 && code <= 0xFDFF) ||
          (code >= 0xFE70 && code <= 0xFEFF),
    );
  }

  static bool _containsDevanagari(String text) {
    return text.runes.any((code) => code >= 0x0900 && code <= 0x097F);
  }
}
