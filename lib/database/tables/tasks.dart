
import 'package:drift/drift.dart';

@DataClassName('TaskData')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  BoolColumn get isCompleted => boolean()();
}
