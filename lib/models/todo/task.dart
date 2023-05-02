import 'package:todo_mobile_app/models/todo/task_status.dart';

class Task {
  final String name;
  final String description;
  final TaskStatus status;

  const Task({
    required this.name,
    required this.description,
    required this.status,
  });

  factory Task.test() {
    return const Task(
      name: 'Test name',
      description: 'Test description',
      status: TaskStatus.inProgress,
    );
  }
}
