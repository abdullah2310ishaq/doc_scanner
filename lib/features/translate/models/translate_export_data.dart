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

  String textForScope(TranslateExportScope scope) {
    return switch (scope) {
      TranslateExportScope.selectedText => sourceText,
      TranslateExportScope.completeFile => _completeText(),
    };
  }

  String _completeText() {
    final buffer = StringBuffer();
    buffer.writeln(selectedTextLabel);
    buffer.writeln(sourceText);

    final translation = translatedText?.trim();
    if (translation != null && translation.isNotEmpty) {
      buffer.writeln();
      final title = targetLanguageName == null
          ? translatedTextLabel
          : '$translatedTextLabel ($targetLanguageName)';
      buffer.writeln(title);
      buffer.writeln(translation);
    }

    return buffer.toString().trim();
  }
}
