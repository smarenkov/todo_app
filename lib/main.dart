import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/features/todo/data/task_repository.dart';
import 'package:todo_app/features/todo/data/task_storage.dart';
import 'package:todo_app/features/todo/widgets/todo_screen.dart';
import 'package:todo_app/theme/theme_provider.dart';
import 'package:todo_app/utils/utils.dart';

void main() {
  _runApp();
}

Future<void> _runApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final themeProvider = ThemeProvider();

  final database = Database();
  final taskStorage = TaskStorageImpl(database: database);
  final taskRepository = TaskRepositoryImpl(localStorage: taskStorage);

  FlutterNativeSplash.remove();

  runApp(
    MainApp(
      appDependencies: AppDependencies(
        themeProvider: themeProvider,
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
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => appDependencies.themeProvider,
        ),
        RepositoryProvider<TaskRepository>(
          create: (context) => appDependencies.taskRepository,
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Todo',
          theme: context.watch<ThemeProvider>().theme,
          home: const TodoScreen(),
        );
      },
    );
  }
}
