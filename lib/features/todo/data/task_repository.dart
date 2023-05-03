import 'package:todo_mobile_app/features/todo/data/task_storage.dart';
import 'package:todo_mobile_app/models/models.dart';

abstract class TaskRepository {
  Future<List<Task>> getAll();

  Future<Task> save(TaskDto task);

  Future<void> update(Task task);

  Future<void> delete(Task task);
}

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({
    required TaskStorage localStorage,
  }) : _localStorage = localStorage;

  final TaskStorage _localStorage;

  @override
  Future<List<Task>> getAll() async {
    return _localStorage.fetchAll();
  }

  @override
  Future<Task> save(TaskDto taskDto) async {
    return _localStorage.save(taskDto);
  }

  @override
  Future<void> update(Task task) async {
    await _localStorage.update(task);
  }

  @override
  Future<void> delete(Task task) async {
    await _localStorage.delete(task);
  }
}
