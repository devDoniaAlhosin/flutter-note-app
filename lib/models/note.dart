class Note {
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isEmpty => title.trim().isEmpty && content.trim().isEmpty;

  String get displayTitle {
    final value = title.trim();
    if (value.isNotEmpty) {
      return value;
    }
    final body = content.trim();
    if (body.isEmpty) {
      return 'Untitled';
    }
    final firstLine = body.split('\n').first;
    return firstLine.length > 40 ? '${firstLine.substring(0, 40)}…' : firstLine;
  }

  String get preview {
    final value = content.trim();
    return value.isEmpty ? 'No additional text' : value;
  }

  String get formattedUpdatedAt {
    final local = updatedAt.toLocal();
    final now = DateTime.now();
    final sameDay =
        local.year == now.year && local.month == now.month && local.day == now.day;
    final time =
        '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    if (sameDay) {
      return time;
    }
    return '${local.day}/${local.month}/${local.year}';
  }

  Note copyWith({
    String? title,
    String? content,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  factory Note.create({String title = '', String content = ''}) {
    final now = DateTime.now();
    return Note(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );
  }
}
