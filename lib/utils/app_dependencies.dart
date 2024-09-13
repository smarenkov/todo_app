import 'package:todo_app/features/todo/data/task_repository.dart';
import 'package:todo_app/shared/locale_provider.dart';
import 'package:todo_app/shared/theme_provider.dart';

class AppDependencies {
  AppDependencies({
    required this.themeProvider,
    required this.localeProvider,
    required this.taskRepository,
  });

  final ThemeProvider themeProvider;
  final LocaleProvider localeProvider;
  final TaskRepository taskRepository;
}
