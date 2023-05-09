import 'package:todo_app/database/database.dart';
import 'package:todo_app/models/models.dart';

extension TaskX on Task {
  static Task fromData(TaskData data) => Task(
        id: data.id,
        name: data.name,
        description: data.description,
        isCompleted: data.isCompleted,
      );

  TaskData toData(Task task) => TaskData(
        id: id,
        name: name,
        description: description,
        isCompleted: isCompleted,
      );
}

extension TasksX on List<Task> {
  void sortByIsCompleted() => sort(
        (a, b) => a.isCompleted == b.isCompleted
            ? 0
            : a.isCompleted
                ? 1
                : -1,
      );
}
