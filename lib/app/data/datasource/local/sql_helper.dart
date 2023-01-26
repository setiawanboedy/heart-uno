import 'package:flutter/foundation.dart';
import 'package:heart_usb/app/data/datasource/model/heart_item_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static const String table = 'heart';

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        age TEXT,
        path TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('heart.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  // save heart
  static Future<int> saveHeart(HeartItemModel heart) async {
    final db = await SQLHelper.db();

    final data = heart.toMap();
    final id = await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getHeartItems() async {
    final db = await SQLHelper.db();
    return db.query(table, orderBy: 'id');
  }

  // Read one item
  static Future<List<Map<String, dynamic>>> getHeartItem(int id) async {
    final db = await SQLHelper.db();
    return db.query(table, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteHeartItem(int id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete(table, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong: $e");
    }
  }
}
