import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/extensions/build_context_x.dart';
import 'package:todo_app/features/todo/bloc/todo_list_bloc.dart';
import 'package:todo_app/features/todo/data/task_repository.dart';
import 'package:todo_app/features/todo/widgets/edit_task_bottom_sheet.dart';
import 'package:todo_app/features/todo/widgets/todo_list_item.dart';
import 'package:todo_app/models/todo/task.dart';
import 'package:todo_app/router/routes.dart';
import 'package:todo_app/ui_kit/app_elevated_button.dart';
import 'package:todo_app/utils/utils.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
        title: Text(
          context.l10n.todoScreenTitle,
          style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => TodoListBloc(
          repository: RepositoryProvider.of<TaskRepository>(context),
        ),
        child: BlocBuilder<TodoListBloc, TodoListState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  if (state.fetched && state.tasks.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        context.l10n.emptyTodoListDescription,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final task = state.tasks[index];
                              return TodoListItem(
                                task: task,
                                onPressed: () {
                                  showEditTask(context, task);
                                },
                                onCompleted: (value) {
                                  context.read<TodoListBloc>().add(
                                        TodoListEvent.updateTask(
                                          task:
                                              task.copyWith(isCompleted: value),
                                        ),
                                      );
                                },
                              );
                            },
                            childCount: state.tasks.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: AppElevatedButton(
                      key: const Key('add_task_button'),
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
          key: const Key('edit_task_bottom_sheet'),
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
          onDelete: () => context.read<TodoListBloc>().add(
                TodoListEvent.removeTask(
                  task: task,
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
          key: const Key('create_task_bottom_sheet'),
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
