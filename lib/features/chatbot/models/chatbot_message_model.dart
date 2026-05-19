enum ChatbotMessageRole { user, assistant }

class ChatbotMessageModel {
  const ChatbotMessageModel({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  final String id;
  final ChatbotMessageRole role;
  final String content;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role.name,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };

  factory ChatbotMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatbotMessageModel(
      id: json['id'] as String,
      role: ChatbotMessageRole.values.byName(json['role'] as String),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
