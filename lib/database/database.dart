import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:todo_mobile_app/database/tables/tasks.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Tasks])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 0;

  Future<List<TaskData>> getTasks() async {
    return select(tasks).get();
  }

  Future<int> insertTask(TasksCompanion companion) async {
    return into(tasks).insert(companion);
  }

  Future<int> deleteTask(TasksCompanion companion) async {
    return delete(tasks).delete(companion);
  }

  Future<bool> updateTask(TasksCompanion companion) async {
    return update(tasks).replace(companion);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final foler = await getApplicationDocumentsDirectory();
    final file = File(path.join(foler.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
