import 'translate_export_scope.dart';

class TranslateExportData {
  const TranslateExportData({
    required this.sourceText,
    required this.selectedTextLabel,
    required this.translatedTextLabel,
    this.translatedText,
    this.targetLanguageName,
  });

  final String sourceText;
  final String selectedTextLabel;
  final String translatedTextLabel;
  final String? translatedText;
  final String? targetLanguageName;

  bool get hasTranslatedText {
    final text = translatedText?.trim();
    return text != null && text.isNotEmpty;
  }

  /// Original OCR / selected text from the scan.
  String get selectedTextOnly => sourceText.trim();

  String textForScope(TranslateExportScope scope) {
    return switch (scope) {
      TranslateExportScope.selectedText => selectedTextOnly,
      TranslateExportScope.translatedText => translatedText?.trim() ?? '',
      TranslateExportScope.completeFile => _completeText(),
    };
  }

  String _completeText() {
    final buffer = StringBuffer();
    buffer.writeln(selectedTextLabel);
    buffer.writeln(sourceText);

    if (hasTranslatedText) {
      buffer.writeln();
      final title = targetLanguageName == null
          ? translatedTextLabel
          : '$translatedTextLabel ($targetLanguageName)';
      buffer.writeln(title);
      buffer.writeln(translatedText!.trim());
    }

    return buffer.toString().trim();
  }
}
