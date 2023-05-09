import 'package:todo_app/features/todo/data/task_repository.dart';

class AppDependencies {
  AppDependencies({
    required this.taskRepository,
  });

  final TaskRepository taskRepository;
}
