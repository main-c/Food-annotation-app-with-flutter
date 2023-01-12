class Category {
  Category({this.id, required this.name});

  int? id;
  String name;

  factory Category.fromMap(Map data) => Category(
        id: data['id'],
        name: data['name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  @override
  String toString() {
    return 'Category(id: $id, name: $name)';
  }
}
