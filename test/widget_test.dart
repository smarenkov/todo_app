import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/features/todo/data/task_repository.dart';
import 'package:todo_app/features/todo/data/task_storage.dart';
import 'package:todo_app/features/todo/widgets/todo_screen.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/locale_provider.dart';
import 'package:todo_app/shared/theme_provider.dart';
import 'package:todo_app/utils/app_dependencies.dart';

Widget createTestableScreen({required Widget home}) {
  final themeProvider = ThemeProvider();
  final localeProvider = LocaleProvider();

  final database = Database();
  final taskStorage = TaskStorageImpl(database: database);
  final taskRepository = TaskRepositoryImpl(localStorage: taskStorage);

  return MainApp(
    appDependencies: AppDependencies(
      themeProvider: themeProvider,
      localeProvider: localeProvider,
      taskRepository: taskRepository,
    ),
    home: home,
  );
}

void main() {
  testWidgets('should add a todo successfully', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableScreen(home: const TodoScreen()));

    await _openCreateTaskBottomSheet(tester);
    expect(find.byKey(const Key('create_task_bottom_sheet')), findsOneWidget);

    await _enterTaskDetailsAndSubmit(tester);
    expect(find.byKey(const Key('create_task_bottom_sheet')), findsNothing);

    //TODO: Verify that the task is added to the list
  });
}

Future<void> _openCreateTaskBottomSheet(WidgetTester tester) async {
  final addTaskButton = find.byKey(const Key('add_task_button'));
  await tester.tap(addTaskButton);
  await tester.pumpAndSettle();
}

Future<void> _enterTaskDetailsAndSubmit(WidgetTester tester) async {
  final nameInput = find.byKey(const Key('task_name_input'));
  final descriptionInput = find.byKey(const Key('task_description_input'));
  final submitButton = find.byKey(const Key('submit_task_editing_button'));

  await tester.enterText(nameInput, 'Task 1');
  await tester.enterText(descriptionInput, 'Description 1');
  await tester.tap(submitButton);
  await tester.pumpAndSettle();
}
