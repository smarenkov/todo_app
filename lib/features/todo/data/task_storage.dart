import 'package:drift/drift.dart' as drift;
import 'package:todo_app/database/database.dart';
import 'package:todo_app/extensions/task_x.dart';
import 'package:todo_app/models/models.dart';

abstract class TaskStorage {
  Future<List<Task>> fetchAll();

  Future<void> save(TaskDto task);

  Future<void> delete(Task task);

  Future<void> update(Task task);
}

class TaskStorageImpl implements TaskStorage {
  TaskStorageImpl({
    required Database database,
  }) : _database = database;

  final Database _database;

  @override
  Future<List<Task>> fetchAll() async {
    final datas = await _database.getTasks();
    return datas.map(TaskX.fromData).toList();
  }

  @override
  Future<void> save(TaskDto taskDto) async {
    final companion = TasksCompanion(
      name: drift.Value(taskDto.name),
      description: drift.Value(taskDto.description),
      isCompleted: drift.Value(taskDto.isCompleted),
    );

    await _database.insertTask(companion);
  }

  @override
  Future<void> delete(Task task) async {
    final companion = TasksCompanion(
      id: drift.Value(task.id),
      name: drift.Value(task.name),
      description: drift.Value(task.description),
      isCompleted: drift.Value(task.isCompleted),
    );

    await _database.deleteTask(companion);
  }

  @override
  Future<void> update(Task task) async {
    final companion = TasksCompanion(
      id: drift.Value(task.id),
      name: drift.Value(task.name),
      description: drift.Value(task.description),
      isCompleted: drift.Value(task.isCompleted),
    );

    await _database.updateTask(companion);
  }
}
