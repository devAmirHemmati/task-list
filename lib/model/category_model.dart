class CategoryModel {
  late String id;
  late String title;
  late String color;

  CategoryModel({
    required this.id,
    required this.title,
    required this.color,
  });

  Map<String, String> toMap() {
    return {
      '_id': id,
      'title': title,
      'color': color,
    };
  }
}
