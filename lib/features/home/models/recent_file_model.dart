enum RecentFileType { pdf, image }

/// A PDF or image file shown in Recent Documents.
class RecentFileModel {
  const RecentFileModel({
    required this.id,
    required this.path,
    required this.displayName,
    required this.type,
    required this.sizeBytes,
    required this.modifiedAt,
    this.isFavorite = false,
  });

  final String id;
  final String path;
  final String displayName;
  final RecentFileType type;
  final int sizeBytes;
  final DateTime modifiedAt;
  final bool isFavorite;

  String get fileName => displayName.contains('.')
      ? displayName
      : type == RecentFileType.pdf
          ? '$displayName.pdf'
          : displayName;

  RecentFileModel copyWith({
    String? id,
    String? path,
    String? displayName,
    RecentFileType? type,
    int? sizeBytes,
    DateTime? modifiedAt,
    bool? isFavorite,
  }) {
    return RecentFileModel(
      id: id ?? this.id,
      path: path ?? this.path,
      displayName: displayName ?? this.displayName,
      type: type ?? this.type,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'path': path,
        'displayName': displayName,
        'type': type.name,
        'sizeBytes': sizeBytes,
        'modifiedAt': modifiedAt.toIso8601String(),
        'isFavorite': isFavorite,
      };

  factory RecentFileModel.fromJson(Map<String, dynamic> json) {
    return RecentFileModel(
      id: json['id'] as String,
      path: json['path'] as String,
      displayName: json['displayName'] as String,
      type: json['type'] == 'image'
          ? RecentFileType.image
          : RecentFileType.pdf,
      sizeBytes: json['sizeBytes'] as int? ?? 0,
      modifiedAt: DateTime.parse(json['modifiedAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
