import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SQLHelper {
  static Future<sql.Database> db() async {
    String dbName = "lit0.db";
    if (kIsWeb) {
      var factory = databaseFactoryFfiWeb;
      var db = await factory.openDatabase(dbName);
      var sqliteVersion =
          (await db.rawQuery('select sqlite_version()')).first.values.first;
      print(sqliteVersion);
      return db;
    } else {
      return sql.openDatabase(
        dbName,
        version: 1,
        onCreate: (sql.Database database, int version) async {
          await createTables(database);
        },
      );
    }
  }

  static Future<void> createTables(sql.Database database) async {
    //ntes
    await database.execute(""" 
        CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        title TEXT,
        content TEXT,
        category TEXT,
        date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      ) 
     """);
  }

  static Future<int> createItem(tableName, data) async {
    final db = await SQLHelper.db();
    final id = await db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems(tableName,
      [String? orderBy = "id"]) async {
    final db = await SQLHelper.db();
    return db.rawQuery("SELECT * FROM $tableName ORDER BY $orderBy DESC");
  }

  static Future<List<Map<String, dynamic>>> searchItem(
      tableName, String queryParam, dynamic keyword) async {
    final db = await SQLHelper.db();
    return db.rawQuery(
        "SELECT * FROM $tableName WHERE $queryParam LIKE '%$keyword%' ORDER BY id DESC");
  }

  static Future<List<Map<String, dynamic>>> searchWhereTwoColumn(
      tableName, String queryParam1, String queryParam2, String keyword) async {
    final db = await SQLHelper.db();

    return db.rawQuery(
        "SELECT * FROM $tableName WHERE $queryParam1 LIKE '%$keyword%' OR $queryParam2 LIKE '%$keyword%'");
  }

  static Future<List<Map<String, dynamic>>> searchWhereTwoColumnWithLimitOffset(
      tableName,
      String queryParam1,
      String queryParam2,
      String keyword,
      int limit,
      int offset) async {
    final db = await SQLHelper.db();

    return db.rawQuery(
        "SELECT * FROM $tableName WHERE $queryParam1 LIKE '%$keyword%' OR $queryParam2 LIKE '%$keyword%' LIMIT $limit OFFSET $offset ");
  }

  static Future<List<Map<String, dynamic>>> searchWithTwoColumn(
      tableName,
      String queryParam1,
      String queryParam2,
      String keyword1,
      String keyword2) async {
    final db = await SQLHelper.db();

    return db.rawQuery(
        "SELECT * FROM $tableName WHERE $queryParam1 LIKE '%$keyword1%' AND $queryParam2 LIKE '%$keyword2%'");
  }

  static Future<List<Map<String, dynamic>>> searchWithThreeColumn(
      tableName,
      String queryParam1,
      String queryParam2,
      String queryParam3,
      String keyword1,
      String keyword2,
      String keyword3) async {
    final db = await SQLHelper.db();

    return db.rawQuery(
        "SELECT * FROM $tableName WHERE $queryParam1 LIKE '%$keyword1%' AND $queryParam2 LIKE '%$keyword2%' AND $queryParam3 LIKE '%$keyword3%'");
  }

  static Future<int> updateItem(tableName, String param, id, data) async {
    final db = await SQLHelper.db();

    final result =
        await db.update(tableName, data, where: "$param = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id, tbl) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(tbl, where: "id = ?", whereArgs: [id]);
    } catch (err) {}
  }

  static Future<bool> clearTable(tableName) async {
    try {
      final db = await SQLHelper.db();
      db.rawDelete("Delete from $tableName");
      return true;
    } catch (e) {
      return false;
    }
  }
}
