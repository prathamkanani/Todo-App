import '../../domain/entity/task_entity.dart';
import 'package:sqflite/sqflite.dart';
import '../model/task_model.dart';
import 'task_database_init.dart';

abstract interface class HomeTaskSource {
  Future<List<TaskEntity>> getFilteredTasks(TaskFilter filter);

  Future<void> deleteTask(int id);

  Future<void> markAsComplete(TaskEntity task);

  Future<void> revert(TaskEntity task);
}

class HomeTaskLocalSource implements HomeTaskSource {
  final LocalTaskDatabase localDatabase = LocalTaskDatabase();

  int taskFilterToInt(DateTime startDate, DateTime dueDate) {
    DateTime now = DateTime.now();
    if (startDate.isAtSameMomentAs(now) &&
        (dueDate.isAfter(now) || dueDate.isAtSameMomentAs(now))) {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  Future<void> deleteTask(id) async {
    final Database db = await localDatabase.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<TaskEntity>> getFilteredTasks(TaskFilter filter) async {
    final Database db = await localDatabase.database;
    List<Map<String, dynamic>> data = [];
    if (filter == TaskFilter.all) {
      data = await db.query('tasks');
    } else {
      data = await db.query(
        'tasks',
        where: 'filter = ?',
        whereArgs: [filter.idx],
      );
    }
    return data.map((e) => TaskModel.fromJson(e)).toList();
  }

  @override
  Future<void> markAsComplete(TaskEntity task) async {
    final Database db = await localDatabase.database;
    await db.update(
      'tasks',
      {'filter': 3},
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<void> revert(TaskEntity task) async {
    final Database db = await localDatabase.database;
    int filter = 2;
    if (task.startDate != null && task.dueDate != null) {
      filter = taskFilterToInt(task.startDate!, task.dueDate!);
    }
    await db.update(
      'tasks',
      {'filter': filter},
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
