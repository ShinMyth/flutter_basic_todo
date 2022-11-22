class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
  });

  final int id;
  final String title;
  final String content;
  final String status;

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      status: map['status'] as String,
    );
  }
}
