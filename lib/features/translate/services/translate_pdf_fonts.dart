import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

abstract final class TranslatePdfFonts {
  static pw.Font? _latin;
  static pw.Font? _arabic;
  static pw.Font? _devanagari;
  static pw.Font? _cjk; // Chinese / Japanese / Korean

  static Future<void> ensureLoaded() async {
    _latin ??= await PdfGoogleFonts.notoSansRegular();
    _arabic ??= await PdfGoogleFonts.notoNaskhArabicRegular();
    _devanagari ??= await PdfGoogleFonts.notoSansDevanagariRegular();

    _cjk ??= await PdfGoogleFonts.notoSansSCRegular();
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

  /// Header style — note: do NOT call toUpperCase() on the text before
  /// passing it here; uppercase breaks CJK / Arabic / Urdu characters.
  static pw.TextStyle headerStyle(String text) {
    final font = _fontFor(text);
    return pw.TextStyle(
      font: font,
      fontSize: 12,
      letterSpacing: 1.5,
      fontWeight: pw.FontWeight.bold,
    );
  }

  /// Selects the correct font for [text] based on the Unicode ranges it
  /// contains.  Never falls back to Helvetica — that font only covers
  /// basic Latin and will render CJK / Arabic / Indic as □ boxes.
  static pw.Font _fontFor(String text) {
    // Check most-specific scripts first.
    if (_containsCjk(text) && _cjk != null) return _cjk!;
    if (_containsDevanagari(text) && _devanagari != null) return _devanagari!;
    if (_containsArabicScript(text) && _arabic != null) return _arabic!;
    // Noto Sans covers all remaining Latin / Cyrillic / Greek / etc.
    // If _latin is somehow null (ensureLoaded not called), throw clearly.
    assert(_latin != null, 'TranslatePdfFonts.ensureLoaded() was not awaited');
    return _latin!;
  }

  // ── Script detection helpers ────────────────────────────────────────────

  static bool _containsCjk(String text) {
    return text.runes.any(
      (code) =>
          // CJK Unified Ideographs (Chinese / Japanese Kanji / Korean Hanja)
          (code >= 0x4E00 && code <= 0x9FFF) ||
          // CJK Extension A
          (code >= 0x3400 && code <= 0x4DBF) ||
          // Hiragana
          (code >= 0x3040 && code <= 0x309F) ||
          // Katakana
          (code >= 0x30A0 && code <= 0x30FF) ||
          // Hangul syllables (Korean)
          (code >= 0xAC00 && code <= 0xD7AF) ||
          // Hangul Jamo
          (code >= 0x1100 && code <= 0x11FF),
    );
  }

  static bool _containsArabicScript(String text) {
    return text.runes.any(
      (code) =>
          (code >= 0x0600 && code <= 0x06FF) || // Arabic
          (code >= 0x0750 && code <= 0x077F) || // Arabic Supplement
          (code >= 0xFB50 && code <= 0xFDFF) || // Arabic Presentation Forms-A
          (code >= 0xFE70 && code <= 0xFEFF), // Arabic Presentation Forms-B
    );
  }

  static bool _containsDevanagari(String text) {
    return text.runes.any((code) => code >= 0x0900 && code <= 0x097F);
  }
}
