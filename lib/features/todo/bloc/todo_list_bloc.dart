import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_mobile_app/features/todo/data/i_task_repository.dart';
import 'package:todo_mobile_app/models/models.dart';

part 'todo_list_bloc.freezed.dart';

@freezed
class TodoListState with _$TodoListState {
  const TodoListState._();

  bool get fetching => maybeMap(
        fetching: (_) => true,
        orElse: () => false,
      );

  bool get fetched => maybeMap(
        fetched: (_) => true,
        orElse: () => false,
      );

  const factory TodoListState.initial({
    @Default(<Task>[]) List<Task> tasks,
  }) = _TodoListStateInitial;

  const factory TodoListState.fetching({
    @Default(<Task>[]) List<Task> tasks,
  }) = _TodoListStateFetching;

  const factory TodoListState.fetched({
    @Default(<Task>[]) List<Task> tasks,
  }) = _TodoListStateFetched;
}

@freezed
class TodoListEvent with _$TodoListEvent {
  const TodoListEvent._();

  const factory TodoListEvent.fetch() = _TodoListEventFetch;

  const factory TodoListEvent.addTask({
    required TaskDto taskDto,
  }) = _TodoListEventAddTask;

  const factory TodoListEvent.removeTask({
    required Task task,
  }) = _TodoListEventRemoveTask;

  const factory TodoListEvent.updateTask({
    required Task task,
  }) = _TodoListEventUpdateTask;
}

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc({
    required ITaskRepository repository,
  })  : _repository = repository,
        super(
          const TodoListState.initial(),
        ) {
    on<TodoListEvent>(
      (event, emitter) => event.map(
        fetch: (event) => _fetch(event, emitter),
        addTask: (event) => _addTask(event, emitter),
        removeTask: (event) => _removeTask(event, emitter),
        updateTask: (event) => _updateTask(event, emitter),
      ),
    );
    add(const TodoListEvent.fetch());
  }

  final ITaskRepository _repository;

  Future<void> _fetch(
    _TodoListEventFetch event,
    Emitter<TodoListState> emitter,
  ) async {
    emitter.call(
      const TodoListState.fetching(),
    );

    final tasks = await _repository.getAll();
    emitter.call(
      TodoListState.fetched(
        tasks: tasks,
      ),
    );
  }

  Future<void> _addTask(
    _TodoListEventAddTask event,
    Emitter<TodoListState> emitter,
  ) async {
    await _repository.save(event.taskDto);
    add(const TodoListEvent.fetch());
  }

  Future<void> _removeTask(
    _TodoListEventRemoveTask event,
    Emitter<TodoListState> emitter,
  ) async {
    await _repository.delete(event.task);
    add(const TodoListEvent.fetch());
  }

  Future<void> _updateTask(
    _TodoListEventUpdateTask event,
    Emitter<TodoListState> emitter,
  ) async {
    await _repository.update(event.task);
    add(const TodoListEvent.fetch());
  }
}
