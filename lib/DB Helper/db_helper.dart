import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookHelper {
  BookHelper._();
  static BookHelper helper = BookHelper._();

  Database? _database;
  String databaseName = 'books.db';
  String tableName = 'books';

  Future<Database> get database async => _database ?? await initDatabase();

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);
    return await openDatabase(
      dbPath,
      version: 2, // Incremented version to handle schema updates
      onCreate: (db, version) {
        String sql = '''
        CREATE TABLE $tableName (
          id INTEGER NOT NULL,
          title TEXT NOT NULL,
          author TEXT NOT NULL,
          status TEXT NOT NULL,
          rating TEXT NOT NULL,
          genre TEXT NOT NULL
        )
        ''';
        db.execute(sql);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          String sql = '''
          ALTER TABLE $tableName ADD COLUMN genre TEXT NOT NULL DEFAULT 'Unknown Genre'
          ''';
          db.execute(sql);
        }
      },
    );
  }

  Future<bool> DataExist(int id) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE id = ?
    ''';
    List<Map<String, Object?>> result = await db.rawQuery(sql, [id]);
    return result.isNotEmpty;
  }

  Future<int> insertData({
    required int id,
    required String title,
    required String author,
    required String status,
    required String rating,
    required String genre, // Added genre
  }) async {
    final db = await database;
    String sql = '''
     INSERT INTO $tableName (
    id, title, author, status, rating, genre
    ) VALUES (?, ?, ?, ?, ?, ?)
    ''';
    List args = [id, title, author, status, rating, genre];
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readAllData() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> getSearchByCategory(String genre) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE genre LIKE '%$genre%'
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> updateData(
      int id,
      String title,
      String author,
      String status,
      String rating,
      String genre, // Added genre
      ) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET title = ?, author = ?, status = ?, rating = ?, genre = ? WHERE id = ?
    ''';
    List args = [title, author, status, rating, genre, id];
    return await db.rawUpdate(sql, args);
  }

  Future<int> deleteData(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db.rawDelete(sql, args);
  }
}
