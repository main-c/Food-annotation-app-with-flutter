import 'package:app/services/db_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/component.dart';

class FoodProvider {
  DBProvider dataProvider = DBProvider.db;

  Future insertFood(Food food) async {
    final db = await dataProvider.database;
    food.id = await db.insert('Food', food.toMap());
    print(food.id);
    print(food.name);
  }

  Future<List<Food>> getFoodByDish(int id) async {
    final db = await dataProvider.database;
    List<Map> maps = await db.query('Food',
        columns: [
          'id',
          'name',
          'type',
          'category',
          'color',
          'dish_id',
          'paintInfo'
        ],
        where: 'dish_id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      maps.map((e) => Food.fromMap(e)).toList();
    }
    throw Exception('Failed to load food');
  }

  Future<List<Food>> getAllFoods() async {
    final db = await dataProvider.database;
    List<Map> maps = await db.query('Food', columns: [
      'id',
      'name',
      'type',
      'category',
      'color',
      'dish_id',
      'paintInfo'
    ]);
    if (maps.isNotEmpty) {
      return maps.map((e) => Food.fromMap(e)).toList();
    }
    throw Exception('Failed to load foods');
  }

  Future<int> deleteFood(int id) async {
    final db = await dataProvider.database;
    return await db.delete('Food', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateFood(Food food) async {
    final db = await dataProvider.database;
    return await db
        .update('Food', food.toMap(), where: 'id = ?', whereArgs: [food.id]);
  }
}
