class PdfAssistantSessionModel {
  const PdfAssistantSessionModel({
    required this.id,
    required this.displayName,
    required this.originalPath,
    required this.translatedPdfPath,
    required this.extractedTextPdfPath,
    required this.targetLanguageCode,
    required this.targetLanguageName,
    required this.createdAt,
  });

  final String id;
  final String displayName;
  final String originalPath;
  final String translatedPdfPath;
  final String extractedTextPdfPath;
  final String targetLanguageCode;
  final String targetLanguageName;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'originalPath': originalPath,
        'translatedPdfPath': translatedPdfPath,
        'extractedTextPdfPath': extractedTextPdfPath,
        'targetLanguageCode': targetLanguageCode,
        'targetLanguageName': targetLanguageName,
        'createdAt': createdAt.toIso8601String(),
      };

  factory PdfAssistantSessionModel.fromJson(Map<String, dynamic> json) {
    return PdfAssistantSessionModel(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      originalPath: json['originalPath'] as String,
      translatedPdfPath: json['translatedPdfPath'] as String,
      extractedTextPdfPath: json['extractedTextPdfPath'] as String,
      targetLanguageCode: json['targetLanguageCode'] as String,
      targetLanguageName: json['targetLanguageName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
