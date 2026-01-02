import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalTaskDatabase {
  static const _databaseName = 'task_database.db';
  static const _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    // if (_database != null) return _database!;
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, priority INTEGER, filter INTEGER, color INTEGER, start_date TEXT, due_date TEXT)',
        );
        db.execute(
          'CREATE TABLE chat(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, sent_time TEXT, is_sent INTEGER, is_self INTEGER)',
        );
      },
    );
  }
}
