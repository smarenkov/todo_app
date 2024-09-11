import 'package:todo_app/features/todo/data/task_repository.dart';
import 'package:todo_app/theme/theme_provider.dart';

class AppDependencies {
  AppDependencies({
    required this.themeProvider,
    required this.taskRepository,
  });

  final ThemeProvider themeProvider;
  final TaskRepository taskRepository;
}
