import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, director TEXT,image TEXT)',
        );
      },
      version: 1,
    );
  }

  // To add data
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // To edit data
  static Future<void> edit(
      String table, Map<String, Object> data, String id) async {
    final db = await DBHelper.database();
    await db.update(
      table,
      data,
      where: 'id= ?',
      whereArgs: [id],
    );
  }

  // To delete data
  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    await db.delete(
      table,
      where: 'id= ?',
      whereArgs: [id],
    );
  }

  // To fetch data
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
