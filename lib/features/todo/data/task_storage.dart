import 'package:drift/drift.dart' as drift;
import 'package:todo_mobile_app/database/database.dart';
import 'package:todo_mobile_app/extensions/task_x.dart';
import 'package:todo_mobile_app/models/models.dart';

abstract class TaskStorage {
  Future<void> init();

  Future<List<Task>> fetchAll();

  Future<void> save(TaskDto task);

  Future<void> delete(Task task);

  Future<void> update(Task task);
}

class TaskStorageImpl implements TaskStorage {
  late Database _database;

  @override
  Future<void> init() async {
    _database = Database();
  }

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
      isDeleted: drift.Value(taskDto.isDeleted),
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
      isDeleted: drift.Value(task.isDeleted),
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
      isDeleted: drift.Value(task.isDeleted),
    );
    
    await _database.updateTask(companion);
  }
}
