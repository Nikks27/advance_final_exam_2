import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper databaseHelper = DatabaseHelper._();

  Database? _database;
  String databaseName = 'expense.db';
  String tableName = 'expense';

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
          title TEXT NOT NULL,
          athor TEXT NOT NULL,
          status TEXT NOT NULL
        )
        ''';
        db.execute(sql);
      },
    );
  }

  Future<bool> JoinFireStore(int id) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE id = ?
    ''';
    List<Map<String, Object?>> result = await db.rawQuery(sql, [id]);
    return result.isNotEmpty;
  }

  Future<int> addBookDatabase(
      int id, String title,  String athor, String status) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName(
    id, title, athor, status
    ) VALUES (?, ?, ?, ?, ?)
    ''';
    List args = [id, title, athor,status];
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readAllBook() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> getBookstatus(String status) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE status LIKE '%$status%'
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> updateBook(int id, String title, String athor,String status) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET title = ?, amount = ?, date = ?, status = ? WHERE id = ?
    ''';
    List args = [title, athor, status, id];
    return await db.rawUpdate(sql, args);
  }

  Future<int> deleteBook(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db.rawDelete(sql, args);
  }
}
