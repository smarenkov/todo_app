import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile_app/features/todo/bloc/todo_list_bloc.dart';
import 'package:todo_mobile_app/features/todo/data/i_task_repository.dart';
import 'package:todo_mobile_app/features/todo/widgets/edit_task_bottom_sheet.dart';
import 'package:todo_mobile_app/features/todo/widgets/todo_list_item.dart';
import 'package:todo_mobile_app/ui_kit/app_elevated_button.dart';

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
              return SafeArea(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Inbox tasks',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final task in state.tasks.where(
                            (task) => !task.isDeleted,
                          ))
                            TodoListItem(
                              task: task,
                              onChanged: (value) => context
                                  .read<TodoListBloc>()
                                  .add(
                                    TodoListEvent.updateTask(
                                      task: task.copyWith(isCompleted: value),
                                    ),
                                  ),
                              onPress: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (_) {
                                  return EditTaskBottomSheet(
                                    initialName: task.name,
                                    initialDescription: task.description,
                                    onSubmit: (taskDto) => context
                                        .read<TodoListBloc>()
                                        .add(
                                          TodoListEvent.updateTask(
                                            task: task.copyWith(
                                              name: taskDto.name,
                                              description: taskDto.description,
                                            ),
                                          ),
                                        ),
                                  );
                                },
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
                      child: AppElevatedButton(
                        icon: const Icon(Icons.add),
                        color: Colors.blue,
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (_) {
                            return EditTaskBottomSheet(
                              onSubmit: (taskDto) =>
                                  context.read<TodoListBloc>().add(
                                        TodoListEvent.addTask(
                                          taskDto: taskDto,
                                        ),
                                      ),
                            );
                          },
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
