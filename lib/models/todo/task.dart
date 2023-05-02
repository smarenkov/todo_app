import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';
part 'task.freezed.dart';

@freezed

@HiveType(typeId: 0)
class Task with _$Task {
  const factory Task({
    @HiveField(0)
    required int id,
    @HiveField(1)
    required String name,
    @HiveField(2)
    required String description,
    @HiveField(3)
    required bool isCompleted,
    @HiveField(4)
    required bool isDeleted,
  }) = _Task;
}
