import 'package:todo_mobile_app/features/todo/data/i_task_repository.dart';
import 'package:todo_mobile_app/models/models.dart';
import 'package:todo_mobile_app/utils/utils.dart';

class TaskRepository implements ITaskRepository {
  TaskRepository({
    required ITaskStorage localStorage,
  }) : _localStorage = localStorage;

  final ITaskStorage _localStorage;

  @override
  Future<List<Task>> getAll() async {
    final tasks = await _localStorage.fetchAll();
    return tasks;
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
