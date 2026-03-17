/// Comment/review entity from LoadAllComment API (Sid, Name, Comment).
class Comment {
  final int sid;
  final String name;
  final String comment;

  const Comment({required this.sid, required this.name, required this.comment});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      sid: _parseInt(json['Sid']),
      name: (json['Name'] as String?)?.trim() ?? '',
      comment: (json['Comment'] as String?)?.trim() ?? '',
    );
  }

  static int _parseInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }
}
