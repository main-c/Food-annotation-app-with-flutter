import 'package:app/models/component.dart';

class Dish {
  Dish({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.country,
    this.foods,
  });

  int? id;
  String name;
  String country;
  String description;
  String image;
  List<Food>? foods;

  factory Dish.fromMap(Map data) => Dish(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        image: data['image'],
        country: data['country'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'country': country,
    };
  }

  @override
  String toString() {
    return 'Dish(name: $name, description: $description, image: $image, country: $country, foods: $foods)';
  }
}
