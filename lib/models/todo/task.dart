import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required int id,
    required String name,
    required String description,
    required bool isCompleted,
    required bool isDeleted,
  }) = _Task;
}
