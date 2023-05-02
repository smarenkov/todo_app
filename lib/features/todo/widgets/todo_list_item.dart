import 'package:flutter/material.dart';
import 'package:todo_mobile_app/models/models.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    required this.task,
    required this.onChanged,
    required this.onPressDelete,
    super.key,
  });

  final Task task;
  final Function(bool) onChanged;
  final Function() onPressDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name),
      subtitle: Text(task.description),
      leading: Checkbox(
        value: task.status == TaskStatus.completed,
        onChanged: (value) => onChanged(value ?? false),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        color: Colors.red,
        onPressed: () => onPressDelete,
      ),
    );
  }
}
