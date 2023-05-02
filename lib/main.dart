import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobile_app/features/features.dart';
import 'package:todo_mobile_app/features/todo/data/i_task_repository.dart';
import 'package:todo_mobile_app/features/todo/data/task_repository.dart';
import 'package:todo_mobile_app/utils/utils.dart';

void main() {
  _runApp();
}

Future<void> _runApp() async {
  final taskStorage = TaskStorage();
  await taskStorage.init();

  final taskRepository = TaskRepository(localStorage: taskStorage);

  runApp(
    MainApp(
      appDependencies: AppDependencies(
        taskRepository: taskRepository,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    required this.appDependencies,
    super.key,
  });

  final AppDependencies appDependencies;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<ITaskRepository>(
          create: (context) => appDependencies.taskRepository,
        ),
      ],
      child: const MaterialApp(
        home: TodoScreen(),
      ),
    );
  }
}
