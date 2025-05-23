class Task {
  final String id;
  String title;
  bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
