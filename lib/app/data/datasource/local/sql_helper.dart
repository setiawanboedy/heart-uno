import 'package:flutter/foundation.dart';
import 'package:heart_usb/app/data/datasource/model/detail_model.dart';
import '../model/heart_item_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static String table = 'heart';
  static String tableDetail = 'heart_detail';

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE heart(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        age TEXT,
        path TEXT,
        desc TEXT,
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
    final id = await db.insert(SQLHelper.table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getHeartItems() async {
    final db = await SQLHelper.db();
    return db.query(SQLHelper.table, orderBy: 'id');
  }

  // Read one item
  static Future<List<Map<String, dynamic>>> getHeartItem(int id) async {
    final db = await SQLHelper.db();
    return db.query(SQLHelper.table,
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteHeartItem(int id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete(SQLHelper.table, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong: $e");
    }
  }

  // ========================= detail database ==========================
  static Future<void> createDetailTables(sql.Database database) async {
    await database.execute("""CREATE TABLE heart_detail(
        id INTEGER PRIMARY KEY NOT NULL,
        original TEXT,
        spectrum TEXT,
        analysis TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> dbDetail() async {
    return sql.openDatabase('heart_detail.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createDetailTables(database);
    });
  }

  static Future<int> saveHeartDetail(DetailModel heart) async {
    final db = await SQLHelper.dbDetail();

    final data = heart.toMap();
    final id = await db.insert(SQLHelper.tableDetail, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
    // Read one item
  static Future<List<Map<String, dynamic>>> getHeartDetail(int id) async {
    final db = await SQLHelper.dbDetail();
    return db.query(SQLHelper.tableDetail,
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteHeartDetail(int id) async {
    final db = await SQLHelper.dbDetail();

    try {
      await db.delete(SQLHelper.tableDetail, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong: $e");
    }
  }
}
