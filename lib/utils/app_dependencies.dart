import 'package:todo_mobile_app/features/todo/data/task_repository.dart';

class AppDependencies {
  AppDependencies({
    required this.taskRepository,
  });

  final TaskRepository taskRepository;
}
