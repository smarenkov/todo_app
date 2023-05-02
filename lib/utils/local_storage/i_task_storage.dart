import 'package:todo_mobile_app/models/models.dart';

abstract class ITaskStorage {
  Future<void> init();

  Future<List<Task>> fetchAll();

  Future<Task?> fetch(int key);

  Future<Task> save(TaskDto task);

  Future<void> delete(Task task);

  Future<void> update(Task task);
}
