import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_dto.freezed.dart';

@freezed
class TaskDto with _$TaskDto {
  const factory TaskDto({
    required String name,
    required String description,
    required bool isCompleted,
  }) = _TaskDto;
}
