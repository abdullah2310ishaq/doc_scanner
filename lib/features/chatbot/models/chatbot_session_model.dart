import 'chatbot_message_model.dart';

class ChatbotSessionModel {
  const ChatbotSessionModel({
    required this.id,
    required this.pdfPath,
    required this.displayName,
    required this.extractedText,
    required this.summary,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String pdfPath;
  final String displayName;
  final String extractedText;
  final String summary;
  final List<ChatbotMessageModel> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatbotSessionModel copyWith({
    String? displayName,
    String? summary,
    List<ChatbotMessageModel>? messages,
    DateTime? updatedAt,
  }) {
    return ChatbotSessionModel(
      id: id,
      pdfPath: pdfPath,
      displayName: displayName ?? this.displayName,
      extractedText: extractedText,
      summary: summary ?? this.summary,
      messages: messages ?? this.messages,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get previewText {
    if (messages.isNotEmpty) {
      return messages.last.content;
    }
    return summary;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'pdfPath': pdfPath,
        'displayName': displayName,
        'extractedText': extractedText,
        'summary': summary,
        'messages': messages.map((m) => m.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory ChatbotSessionModel.fromJson(Map<String, dynamic> json) {
    final rawMessages = json['messages'] as List<dynamic>? ?? [];
    return ChatbotSessionModel(
      id: json['id'] as String,
      pdfPath: json['pdfPath'] as String,
      displayName: json['displayName'] as String,
      extractedText: json['extractedText'] as String,
      summary: json['summary'] as String,
      messages: rawMessages
          .map((m) => ChatbotMessageModel.fromJson(m as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
