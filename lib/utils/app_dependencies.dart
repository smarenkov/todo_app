import 'package:todo_mobile_app/features/todo/data/i_task_repository.dart';

class AppDependencies {
  AppDependencies({
    required this.taskRepository,
  });

  final ITaskRepository taskRepository;
}
