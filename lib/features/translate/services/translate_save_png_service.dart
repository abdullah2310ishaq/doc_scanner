import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';

import '../../../core/theme/app_colors.dart';
import '../models/translate_export_data.dart';
import '../models/translate_export_scope.dart';
import 'translate_export_storage.dart';

class TranslateSavePngService {
  Future<String> save({
    required TranslateExportData data,
    required TranslateExportScope scope,
  }) async {
    final screenshotController = ScreenshotController();

    // Determine the source and translated text based on scope
    final sourceText = data.sourceText.trim();
    final translatedText = data.translatedText?.trim() ?? '';
    final showSource = scope == TranslateExportScope.selectedText || scope == TranslateExportScope.completeFile;
    final showTranslated = scope == TranslateExportScope.translatedText || (scope == TranslateExportScope.completeFile && data.hasTranslatedText);

    // Trigger font loading dynamically and wait for completion
    if (showSource) {
      _getTextStyle(text: sourceText, fontSize: 14, color: Colors.black);
    }
    if (showTranslated) {
      _getTextStyle(text: translatedText, fontSize: 14, color: Colors.black);
    }
    await GoogleFonts.pendingFonts();

    // Create a beautiful, solid-white card widget
    final cardWidget = Container(
      width: 500,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Bar
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  gradient: AppColors.navbarGradient,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const Icon(
                  Icons.translate,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doc Scanner',
                      style: _getTextStyle(
                        text: 'Doc Scanner',
                        fontSize: 16,
                        color: AppColors.textPrimary,
                        bold: true,
                      ),
                    ),
                    Text(
                      data.targetLanguageName != null
                          ? 'Translation: ${data.targetLanguageName}'
                          : 'Document Translation',
                      style: _getTextStyle(
                        text: data.targetLanguageName ?? 'Document Translation',
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _formattedDate(),
                style: _getTextStyle(
                  text: _formattedDate(),
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Source Text Block
          if (showSource)
            _buildTextSection(
              label: data.selectedTextLabel,
              text: sourceText,
              isSource: true,
            ),
          
          if (scope == TranslateExportScope.completeFile && data.hasTranslatedText) ...[
            const SizedBox(height: 16),
            // Connecting indicator line
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_downward, size: 14, color: AppColors.textLink),
                    const SizedBox(width: 6),
                    Text(
                      'Translated',
                      style: _getTextStyle(
                        text: 'Translated',
                        fontSize: 10,
                        color: AppColors.textLink,
                        bold: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Translated Text Block
          if (showTranslated)
            _buildTextSection(
              label: data.targetLanguageName != null
                  ? '${data.translatedTextLabel} (${data.targetLanguageName})'
                  : data.translatedTextLabel,
              text: translatedText,
              isSource: false,
            ),
          const SizedBox(height: 24),
          
          // Footer
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFF1F5F9), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF10B981),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  'Verified offline translation export',
                  style: _getTextStyle(
                    text: 'Verified offline translation export',
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // Capture the widget off-screen using screenshot controller.
    // Wrap with IntrinsicWidth/IntrinsicHeight and a solid white Material canvas
    // to guarantee 100% solid opacity with no transparent border padding.
    final pngBytes = await screenshotController.captureFromWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(),
          child: Material(
            type: MaterialType.canvas,
            color: Colors.white,
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: cardWidget,
              ),
            ),
          ),
        ),
      ),
      pixelRatio: 2.5, // Crisp high-res image
    );

    final fileName = _fileName(scope);
    return TranslateExportStorage.saveBytes(bytes: pngBytes, fileName: fileName);
  }

  Widget _buildTextSection({
    required String label,
    required String text,
    required bool isSource,
  }) {
    final bgColor = isSource ? const Color(0xFFF8FAFC) : const Color(0xFFEFF6FF);
    final borderColor = isSource ? const Color(0xFFE2E8F0) : const Color(0xFFBFDBFE);
    final labelColor = isSource ? const Color(0xFF64748B) : const Color(0xFF2563EB);
    final isRtl = _isRtl(text);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              label,
              style: _getTextStyle(
                text: label,
                fontSize: 11,
                color: labelColor,
                bold: true,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: isRtl ? TextAlign.right : TextAlign.left,
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            style: _getTextStyle(
              text: text,
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
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

  TextStyle _getTextStyle({
    required String text,
    required double fontSize,
    required Color color,
    bool bold = false,
  }) {
    final baseStyle = TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      height: 1.5,
      fontFamilyFallback: const ['NotoNaskhArabic', 'NotoSans'],
    );

    if (_containsCjk(text)) {
      return GoogleFonts.notoSansSc(textStyle: baseStyle);
    }
    if (_containsDevanagari(text)) {
      return GoogleFonts.notoSansDevanagari(textStyle: baseStyle);
    }
    if (_containsArabicScript(text)) {
      return GoogleFonts.notoNaskhArabic(textStyle: baseStyle);
    }
    return GoogleFonts.notoSans(textStyle: baseStyle);
  }

  bool _containsCjk(String text) {
    return text.runes.any(
      (code) =>
          (code >= 0x4E00 && code <= 0x9FFF) ||
          (code >= 0x3400 && code <= 0x4DBF) ||
          (code >= 0x3040 && code <= 0x309F) ||
          (code >= 0x30A0 && code <= 0x30FF) ||
          (code >= 0xAC00 && code <= 0xD7AF) ||
          (code >= 0x1100 && code <= 0x11FF),
    );
  }

  bool _containsArabicScript(String text) {
    return text.runes.any(
      (code) =>
          (code >= 0x0600 && code <= 0x06FF) ||
          (code >= 0x0750 && code <= 0x077F) ||
          (code >= 0xFB50 && code <= 0xFDFF) ||
          (code >= 0xFE70 && code <= 0xFEFF),
    );
  }

  bool _containsDevanagari(String text) {
    return text.runes.any((code) => code >= 0x0900 && code <= 0x097F);
  }

  String _fileName(TranslateExportScope scope) {
    final suffix = switch (scope) {
      TranslateExportScope.selectedText => 'selected',
      TranslateExportScope.translatedText => 'translated',
      TranslateExportScope.completeFile => 'complete',
    };
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'translation_${suffix}_$timestamp.png';
  }

  String _formattedDate() {
    final now = DateTime.now();
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }
}
