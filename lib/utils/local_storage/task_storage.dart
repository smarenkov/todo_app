import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_mobile_app/models/models.dart';

abstract class TaskStorage {
  Future<void> init();

  Future<List<Task>> fetchAll();

  Future<Task> save(TaskDto task);

  Future<void> delete(Task task);

  Future<void> update(Task task);
}

class TaskStorageImpl implements TaskStorage {
  late Box<Task> _taskBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());

    _taskBox = await Hive.openBox<Task>('tasks');
  }

  @override
  Future<List<Task>> fetchAll() async {
    return _taskBox.values.toList();
  }

  @override
  Future<Task> save(TaskDto taskDto) async {
    final task = Task(
      id: _taskBox.values.length,
      name: taskDto.name,
      description: taskDto.description,
      isCompleted: taskDto.isCompleted,
      isDeleted: taskDto.isDeleted,
    );

    await _taskBox.add(task);

    return task;
  }

  @override
  Future<void> delete(Task task) async {
    await _taskBox.put(task.id, task.copyWith(isDeleted: true));
  }

  @override
  Future<void> update(Task task) async {
    await _taskBox.put(task.id, task);
  }
}
