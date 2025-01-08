import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/features/todo/widgets/todo_screen.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/locale_provider.dart';
import 'package:todo_app/shared/theme_provider.dart';
import 'package:todo_app/utils/app_dependencies.dart';

import 'bloc_test.dart';
import 'bloc_test.mocks.dart';

void main() {
  group('TodoScreen', () {
    late final MockDatabase database;
    late final MockTaskStorageImpl taskStorage;
    late final MockTaskRepositoryImpl taskRepository;

    setUp(() {
      database = MockDatabase();
      taskStorage = MockTaskStorageImpl(database: database);
      taskRepository = MockTaskRepositoryImpl(localStorage: taskStorage);
    });

    Widget createTestableScreen({required Widget home}) {
      final themeProvider = ThemeProvider();
      final localeProvider = LocaleProvider();

      final database = MockDatabase();
      final taskStorage = MockTaskStorageImpl(database: database);
      final taskRepository = MockTaskRepositoryImpl(localStorage: taskStorage);

      return MainApp(
        appDependencies: AppDependencies(
          themeProvider: themeProvider,
          localeProvider: localeProvider,
          taskRepository: taskRepository,
        ),
        home: home,
      );
    }

    Future<void> openCreateTaskBottomSheet(WidgetTester tester) async {
      final addTaskButton = find.byKey(const Key('add_task_button'));
      await tester.tap(addTaskButton);
      await tester.pumpAndSettle();
    }

    Future<void> enterTaskDetailsAndSubmit(WidgetTester tester) async {
      final nameInput = find.byKey(const Key('task_name_input'));
      final descriptionInput = find.byKey(const Key('task_description_input'));
      final submitButton = find.byKey(const Key('submit_task_editing_button'));

      await tester.enterText(nameInput, 'Task 1');
      await tester.enterText(descriptionInput, 'Description 1');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
    }

    testWidgets('should add a todo successfully', (WidgetTester tester) async {
      when(taskRepository.getAll()).thenAnswer((_) async => []);

      await tester.pumpWidget(createTestableScreen(home: const TodoScreen()));

      // await openCreateTaskBottomSheet(tester);
      // expect(find.byKey(const Key('create_task_bottom_sheet')), findsOneWidget);

      // await enterTaskDetailsAndSubmit(tester);
      // expect(find.byKey(const Key('create_task_bottom_sheet')), findsNothing);

      // when(taskRepository.getAll()).thenAnswer((_) async => [task]);

      //TODO: Verify that the task is added to the list
    });
  });
}
