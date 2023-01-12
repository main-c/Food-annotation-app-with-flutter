import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    try {
      Directory documentDirectory = await getApplicationDocumentsDirectory();

      String path = '${documentDirectory.path}/local.db';
      return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (db, version) async {
          await db.execute(
            "CREATE TABLE Dish(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, image TEXT, country TEXT); CREATE TABLE Food(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, category_id INTEGER, dish_id INTEGER, color INTEGER paintInfo TEXT);CREATE TABLE Category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT);",
          );
          await db.execute(
              "CREATE TABLE Food(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, category INTEGER, dish_id INTEGER, color INTEGER,  paintInfo TEXT);");
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
