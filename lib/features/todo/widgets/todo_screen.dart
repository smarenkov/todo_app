import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile_app/features/todo/bloc/todo_list_bloc.dart';
import 'package:todo_mobile_app/features/todo/data/i_task_repository.dart';
import 'package:todo_mobile_app/features/todo/widgets/edit_task_bottom_sheet.dart';
import 'package:todo_mobile_app/features/todo/widgets/todo_list_item.dart';
import 'package:todo_mobile_app/features/todo/widgets/todo_screen_header.dart';
import 'package:todo_mobile_app/models/todo/task.dart';
import 'package:todo_mobile_app/ui_kit/app_elevated_button.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TodoListBloc(
          repository: context.read<ITaskRepository>(),
        ),
        child: BlocBuilder<TodoListBloc, TodoListState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  const TodoScreenHeader(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.displayedTasks.length,
                      itemBuilder: (context, index) {
                        final task = state.displayedTasks[index];
                        return TodoListItem(
                          task: task,
                          onPress: () {
                            showEditTask(context, task);
                          },
                          onChanged: (value) {
                            context.read<TodoListBloc>().add(
                                  TodoListEvent.updateTask(
                                    task: task.copyWith(isCompleted: value),
                                  ),
                                );
                          },
                          onPressDelete: () {
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
    return _showModalBottomSheet(
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
    return _showModalBottomSheet(
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

  //TODO(smarenkov): Extract to different file
  Future<dynamic> _showModalBottomSheet({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: builder,
    );
  }
}
