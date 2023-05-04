import 'package:flutter/material.dart';
import 'package:todo_mobile_app/models/models.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    required this.task,
    required this.onChangedCompleted,
    required this.onPressed,
    super.key,
  });

  final Task task;
  final Function(bool) onChangedCompleted;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '#${task.id} ${task.name}',
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          task.description,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          shape: const CircleBorder(),
          onChanged: (value) => onChangedCompleted(value ?? false),
        ),
        onTap: onPressed,
      ),
    );
  }
}
