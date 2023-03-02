import 'dart:convert';

class Task {
  int id;
  String title;
  String? description;
  bool done;
  DateTime? limitDate;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.done = false,
    this.limitDate,
  });

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, done: $done, limitDate: $limitDate)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'done': done});
    if (limitDate != null) {
      result.addAll({'limitDate': limitDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'],
      done: map['done'] ?? false,
      limitDate: map['limitDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['limitDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
