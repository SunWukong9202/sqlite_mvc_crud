import 'package:path/path.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  static const _databaseName = "Tasks.db";
  static const _version = 1;

  ///Nombre de la table
  static const _table = "tasks";

  static Future<Database>? _db;

  static Future<Database> getDB() {
    _db ??= _init();
    return _db!;
  }

  static Future<Database> _init() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // var documentsDir = await getApplicationDocumentsDirectory();
    var documentsDir = Directory.current;
    final path = join(documentsDir.path, 'databases', _databaseName);

    final db = await databaseFactory.openDatabase(path);

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        expireDate TEXT NOT NULL,
        isCompleted TEXT NOT NULL
      )
    ''');

    return db;
  }

  static Future _onCreate(Database db, int version) async {
    ///Creación de nuetra tabla
    await db.execute('''
      CREATE TABLE $_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        expireDate TEXT NOT NULL,
        isCompleted TEXT NOT NULL
      )
    ''');
  }
}
