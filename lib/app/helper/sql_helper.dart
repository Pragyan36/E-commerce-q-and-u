import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE notifications(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        body TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        image TEXT
      )
      """);
  }

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'app.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String title, String? body, String? image) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'body': body, 'image': image};
    final id = await db.insert('notifications', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    log("SQL Helper:createItem:Success");
    print("firebase messsage is $body");
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('notifications', orderBy: "id DESC");
  }

  // Delete
  static Future<void> deleteItem(id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("notifications", where: "createdAt = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAll() async {
    log("Sql Helper:deleteAll Called");
    final db = await SQLHelper.db();
    try {
      // await db.delete("notifications", where: "id = ?", whereArgs: [id]);
      await db.execute("delete from "
          "notifications");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
