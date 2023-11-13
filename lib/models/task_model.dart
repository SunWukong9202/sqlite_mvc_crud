import 'package:sqflite/sqflite.dart';

class Task {
  static const _table = 'tasks';
  static late Database _db;
  late int id;
  String title;
  DateTime expireDate;
  bool isCompleted;

  Task({
    required this.title,
    required this.expireDate,
    this.isCompleted = false,
  });

  Task.fromDB({
    required this.id,
    required this.title,
    required this.expireDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'expireDate': expireDate.toIso8601String(),
      'isCompleted': isCompleted ? 'true' : 'false'
    };
  }

  static set db(Database db) {
    Task._db = db;
  }

  static Future<int> insertTask(Task task) async {
    return await _db.insert(
      _table,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Task>> tasks() async {
    final List<Map<String, dynamic>> maps = await _db.query(_table);

    // Convert the List<Map<String, dynamic> into a List<Task>.
    return List.generate(maps.length, (i) {
      return Task.fromDB(
          id: maps[i]['id'] as int,
          title: maps[i]['title'] as String,
          expireDate: DateTime.parse(maps[i]['expireDate']),
          isCompleted: maps[i]['isCompleted'] == 'true');
    });
  }

  static Future<void> updateTask(Task task) async {
    await _db.update(
      _table,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<void> deleteTask(int id) async {
    await _db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
