import 'package:app/services/db_provider.dart';

import '../models/category.dart';

class CategoryProvider {
  DBProvider dbProvider = DBProvider.db;

  Future insertCategory(Category category) async {
    final db = await dbProvider.database;
    category.id = await db.insert('Category', category.toMap());
  }

  Future<Category> getCategory(int id) async {
    final db = await dbProvider.database;
    List<Map> maps = await db.query('Category',
        columns: ['id', 'name', 'description', 'image'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Category.fromMap(maps.first);
    }
    throw Exception('Failed to load category');
  }
  
}
