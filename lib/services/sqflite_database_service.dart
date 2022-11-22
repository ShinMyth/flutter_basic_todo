import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? db;
String dbName = "todo.db";

class SqfliteDatabaseService {
  Future<void> setupDatabase() async {
    var path = await getDatabasesPath();
    String databasesPath = join(path, dbName);

    db = await openDatabase(
      databasesPath,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todo (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      status TEXT NOT NULL
    )
    ''');
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Select all todo records based on the status
  Future<List> selectTodo({required String status}) async {
    try {
      List result = await db!.rawQuery('''
        SELECT
          *
        FROM todo
        WHERE status = ?
      ''', [status]);

      return result;
    } catch (e) {
      log("selectTodo: $e");
      return [];
    }
  }

  // Insert new todo record on the todo table
  Future insertTodo({
    required String title,
    required String content,
    required String status,
  }) async {
    try {
      db!.transaction(
        (txn) async {
          await txn.rawInsert('''
        INSERT INTO todo (
          title,
          content,
          status
        ) VALUES(?,?,?)
        ''', [title, content, status]);
        },
      );
    } catch (e) {
      log("insertTodo: $e");
    }
  }

  // Update todo record on the todo table based on the id
  Future updateTodo({
    required int id,
    required String title,
    required String content,
    required String status,
  }) async {
    try {
      db!.transaction(
        (txn) async {
          await txn.rawUpdate('''
        UPDATE todo SET
          title = ?,
          content = ?,
          status = ?
        WHERE id = ?
        ''', [title, content, status, id]);
        },
      );
    } catch (e) {
      log("updateTodo: $e");
    }
  }

  // Delete todo record on the todo table based on the id
  Future deleteTodo({required int id}) async {
    try {
      db!.transaction(
        (txn) async {
          await txn.rawDelete('''
          DELETE FROM todo
          WHERE id = ?
          ''', [id]);
        },
      );
    } catch (e) {
      log("deleteTodo: $e");
    }
  }
}
