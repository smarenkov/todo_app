import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/features/todo/bloc/todo_list_bloc.dart';
import 'package:todo_app/features/todo/data/task_repository.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  TodoListBloc get todoListBloc => BlocProvider.of<TodoListBloc>(this);
  TaskRepository get taskRepository => RepositoryProvider.of<TaskRepository>(this);
}
