import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile_app/features/todo/bloc/todo_list_bloc.dart';
import 'package:todo_mobile_app/features/todo/data/i_task_repository.dart';
import 'package:todo_mobile_app/features/todo/widgets/todo_list_item.dart';
import 'package:todo_mobile_app/models/models.dart';
import 'package:todo_mobile_app/ui_kit/create_task_button.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => TodoListBloc(
            repository: context.read<ITaskRepository>(),
          ),
          child: BlocBuilder<TodoListBloc, TodoListState>(
            builder: (context, state) {
              return Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          for (final task
                              in state.tasks.where((task) => !task.isDeleted))
                            TodoListItem(
                              task: task,
                              onChanged: (value) => context
                                  .read<TodoListBloc>()
                                  .add(
                                    TodoListEvent.updateTask(
                                      task: task.copyWith(isCompleted: value),
                                    ),
                                  ),
                              onPressDelete: () =>
                                  context.read<TodoListBloc>().add(
                                        TodoListEvent.removeTask(
                                          task: task,
                                        ),
                                      ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: CreateTaskButton(
                        onPressed: () => context.read<TodoListBloc>().add(
                              const TodoListEvent.addTask(
                                taskDto: TaskDto(
                                  name: 'Test name',
                                  description: 'Test description',
                                  isCompleted: false,
                                  isDeleted: false,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
