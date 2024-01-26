class CommentEntity {
  final int id;
  final String title;
  final String content;
  final String data;
  final String email;

  CommentEntity(this.id, this.title, this.content, this.data, this.email);

  factory CommentEntity.fromJson(Map<String, dynamic> jsonMap) {
    return CommentEntity(
      jsonMap['id'],
      jsonMap['title'],
      jsonMap['content'],
      jsonMap['date'],
      jsonMap['author']['email'],
    );
  }
}
