import 'package:app/models/category.dart';
import 'package:app/src/_paint_over_image.dart';

class Food {
  Food(
      {this.id,
      required this.name,
      required this.type,
      required this.category,
      required this.color,
      this.dishId,
      required this.paintInfo});

  int? id;
  String name;
  String type;
  String category;
  int color;
  int? dishId;
  String paintInfo;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'color': color,
      'category': category,
      'dish_id': dishId,
      'paintInfo': paintInfo.toString(),
    };
  }

  factory Food.fromMap(Map data) => Food(
        id: data['id'],
        name: data['name'],
        type: data['type'],
        paintInfo: data['paintInfo'],
        category: data['category'],
        color: data['color'],
        dishId: data['dish_id'],
      );
  @override
  String toString() {
    return 'Food{id: $id, name: $name, type: $type, category: $category, color: $color, dishId: $dishId, paintInfo: $paintInfo}';
  }
}
