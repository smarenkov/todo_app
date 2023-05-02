import 'package:flutter/material.dart';
import 'package:todo_mobile_app/features/todo/widgets/todo_list_item.dart';
import 'package:todo_mobile_app/models/models.dart';
import 'package:todo_mobile_app/ui_kit/create_task_button.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TodoListItem(
                      task: Task.test(),
                      onChanged: (value) {},
                      onPressDelete: () {},
                    ),
                    TodoListItem(
                      task: Task.test(),
                      onChanged: (value) {},
                      onPressDelete: () {},
                    ),
                    TodoListItem(
                      task: Task.test(),
                      onChanged: (value) {},
                      onPressDelete: () {},
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                child: CreateTaskButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
