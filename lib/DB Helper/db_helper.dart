import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper databaseHelper = DatabaseHelper._();

  Database? _database;
  String databaseName = 'attendance.db';
  String tableName = 'attendance';

  Future<Database> get database async => _database ?? await initDatabase();

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
        CREATE TABLE $tableName (
          id INTEGER NOT NULL,
          name TEXT NOT NULL,
          date TEXT NOT NULL,
          present INTEGER NOT NULL
        )
        ''';
        db.execute(sql);
      },
    );
  }

  Future<bool> firestoreExist(int id) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE id = ?
    ''';
    List<Map<String, Object?>> result = await db.rawQuery(sql, [id]);
    return result.isNotEmpty;
  }

  Future<int> addAttendanceDatabase(
      int id, String name, String date, String present) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName(
    id, name, date, present
    ) VALUES (?, ?, ?, ?, ?)
    ''';
    List args = [id, name, date, present];
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readAllAttendance() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> updateAttendance(int id, String name, String date,
      String present) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET name = ?, date = ?, present = ? WHERE id = ?
    ''';
    List args = [name, date, present, id];
    return await db.rawUpdate(sql, args);
  }

  Future<int> deleteAttendance(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db.rawDelete(sql, args);
  }
}