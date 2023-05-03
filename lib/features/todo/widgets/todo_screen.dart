import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile_app/features/todo/bloc/todo_list_bloc.dart';
import 'package:todo_mobile_app/features/todo/data/task_repository.dart';
import 'package:todo_mobile_app/features/todo/widgets/edit_task_bottom_sheet.dart';
import 'package:todo_mobile_app/features/todo/widgets/todo_list_item.dart';
import 'package:todo_mobile_app/features/todo/widgets/todo_screen_header.dart';
import 'package:todo_mobile_app/models/todo/task.dart';
import 'package:todo_mobile_app/ui_kit/app_elevated_button.dart';
import 'package:todo_mobile_app/utils/utils.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TodoListBloc(
          repository: context.read<TaskRepository>(),
        ),
        child: BlocBuilder<TodoListBloc, TodoListState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  const TodoScreenHeader(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.unDeletedTasks.length,
                      itemBuilder: (context, index) {
                        final task = state.unDeletedTasks[index];
                        return TodoListItem(
                          task: task,
                          onPressed: () {
                            showEditTask(context, task);
                          },
                          onChangedCompleted: (value) {
                            context.read<TodoListBloc>().add(
                                  TodoListEvent.updateTask(
                                    task: task.copyWith(isCompleted: value),
                                  ),
                                );
                          },
                          onPressedDelete: () {
                            context.read<TodoListBloc>().add(
                                  TodoListEvent.removeTask(
                                    task: task,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: AppElevatedButton(
                      icon: const Icon(Icons.add),
                      color: Colors.blue,
                      onPressed: () => showCreateTask(context),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> showEditTask(BuildContext context, Task task) {
    return AppBottomSheet.showDefaultModalBottomSheet(
      context: context,
      builder: (_) {
        return EditTaskBottomSheet(
          initialName: task.name,
          initialDescription: task.description,
          onSubmit: (taskDto) => context.read<TodoListBloc>().add(
                TodoListEvent.updateTask(
                  task: task.copyWith(
                    name: taskDto.name,
                    description: taskDto.description,
                  ),
                ),
              ),
        );
      },
    );
  }

  Future<dynamic> showCreateTask(BuildContext context) {
    return AppBottomSheet.showDefaultModalBottomSheet(
      context: context,
      builder: (_) {
        return EditTaskBottomSheet(
          onSubmit: (taskDto) => context.read<TodoListBloc>().add(
                TodoListEvent.addTask(
                  taskDto: taskDto,
                ),
              ),
        );
      },
    );
  }
}
