import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/extensions/build_context_x.dart';
import 'package:todo_app/features/settings/widgets/settings_screen.dart';
import 'package:todo_app/features/todo/data/task_repository.dart';
import 'package:todo_app/features/todo/data/task_storage.dart';
import 'package:todo_app/features/todo/widgets/todo_screen.dart';
import 'package:todo_app/router/routes.dart';
import 'package:todo_app/theme/locale_provider.dart';
import 'package:todo_app/theme/theme_provider.dart';
import 'package:todo_app/utils/utils.dart';

void main() {
  _runApp();
}

Future<void> _runApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final themeProvider = ThemeProvider();
  final localeProvider = LocaleProvider();

  final database = Database();
  final taskStorage = TaskStorageImpl(database: database);
  final taskRepository = TaskRepositoryImpl(localStorage: taskStorage);

  FlutterNativeSplash.remove();

  runApp(
    MainApp(
      appDependencies: AppDependencies(
        themeProvider: themeProvider,
        localeProvider: localeProvider,
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
        ChangeNotifierProvider<LocaleProvider>(
          create: (context) => appDependencies.localeProvider,
        ),
        RepositoryProvider<TaskRepository>(
          create: (context) => appDependencies.taskRepository,
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: context.watch<ThemeProvider>().theme,
          locale: context.watch<LocaleProvider>().locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (context) => context.l10n.applicationName,
          routes: {
            AppRoutes.todos: (context) => const TodoScreen(),
            AppRoutes.settings: (context) => const SettingsScreen(),
          },
          home: const TodoScreen(),
        );
      },
    );
  }
}
