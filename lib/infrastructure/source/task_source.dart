import 'package:sqflite/sqflite.dart';
import '../../domain/entity/task_entity.dart';
import '../model/task_model.dart';
import 'task_database_init.dart';

abstract interface class TaskSource {
  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
}

class TaskLocalSource implements TaskSource {
  final LocalTaskDatabase localDatabase = LocalTaskDatabase();

  @override
  Future<void> createTask(TaskEntity task) async {
    final Database db = await localDatabase.database;
    await db.insert(
      'tasks',
      TaskModel.fromEntity(task).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTask(task) async {
    final Database db = await localDatabase.database;
    await db.update(
      'tasks',
      TaskModel.fromEntity(task).toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
