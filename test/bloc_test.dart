import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/features/todo/bloc/todo_list_bloc.dart';
import 'package:todo_app/features/todo/data/task_repository.dart';
import 'package:todo_app/features/todo/data/task_storage.dart';
import 'package:todo_app/models/models.dart';

@GenerateNiceMocks([
  MockSpec<Database>(),
  MockSpec<Task>(),
])
import 'bloc_test.mocks.dart';

class MockTaskStorageImpl extends Mock implements TaskStorageImpl {
  MockTaskStorageImpl({required this.database});
  final Database database;
}

class MockTaskRepositoryImpl extends Mock implements TaskRepositoryImpl {
  MockTaskRepositoryImpl({required this.localStorage});
  final TaskStorageImpl localStorage;
}

void main() {
  group('TodoListBloc', () {
    late final MockDatabase database;
    late final MockTaskStorageImpl taskStorage;
    late final MockTaskRepositoryImpl taskRepository;
    late final MockTask task;

    setUp(() {
      database = MockDatabase();
      taskStorage = MockTaskStorageImpl(database: database);
      taskRepository = MockTaskRepositoryImpl(localStorage: taskStorage);
      task = MockTask();
    });

    blocTest<TodoListBloc, TodoListState>(
      'fetch event success',
      build: () => TodoListBloc(repository: taskRepository),
      setUp: () =>
          when(() => taskRepository.getAll()).thenAnswer((_) async => [task]),
      act: (bloc) => const TodoListEvent.fetch(),
      expect: () => <TodoListState>[
        const TodoListState.fetching(),
        TodoListState.fetched(tasks: [task]),
      ],
    );

    blocTest<TodoListBloc, TodoListState>(
      'fetch event error',
      build: () => TodoListBloc(repository: taskRepository),
      setUp: () => when(() => taskRepository.getAll()).thenThrow(Exception()),
      act: (bloc) => const TodoListEvent.fetch(),
      expect: () => <TodoListState>[
        const TodoListState.fetching(),
        const TodoListState.error(),
      ],
    );
  });
}
