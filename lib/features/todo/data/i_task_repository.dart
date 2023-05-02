import 'package:todo_mobile_app/models/models.dart';

abstract class ITaskRepository {

  Future<List<Task>> getAll();

  Future<Task> getById(int id);

  Future<Task> save(TaskDto task);

  Future<void> update(Task task);

  Future<void> delete(Task task);

}
