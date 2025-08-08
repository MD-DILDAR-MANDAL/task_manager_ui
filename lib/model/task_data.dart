enum TaskStatus { NotStarted, Started, Completed }

class Task {
  String id;
  String title;
  String assignee;
  String priority;
  TaskStatus status;
  DateTime startDate;
  DateTime dueDate;

  Task({
    required this.id,
    required this.title,
    required this.assignee,
    required this.priority,
    required this.status,
    required this.startDate,
    required this.dueDate,
  });
}
