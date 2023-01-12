import '../models/dish.dart';
import '../services/db_provider.dart';

class DishProvider {
  DBProvider dataProvider = DBProvider.db;

  // open database

  Future<int> insertDish(Dish dish) async {
    final db = await dataProvider.database;
    return await db.insert('Dish', dish.toMap());
  }

  Future<Dish> getDish(int id) async {
    final db = await dataProvider.database;
    List<Map> maps = await db.query('Dish',
        columns: ['id', 'name', 'description', 'image', 'country'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Dish.fromMap(maps.first);
    }
    throw Exception('Failed to load dish');
  }

  Future<List<Dish>> getAllDishes() async {
    final db = await dataProvider.database;
    List<Map> maps = await db.query('Dish',
        columns: ['id', 'name', 'description', 'image', 'country']);
    if (maps.isNotEmpty) {
      return maps.map((e) => Dish.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future<int> deleteDish(int id) async {
    final db = await dataProvider.database;
    return await db.delete('Dish', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateDish(Dish dish) async {
    final db = await dataProvider.database;
    return await db
        .update('Dish', dish.toMap(), where: 'id = ?', whereArgs: [dish.id]);
  }
}
