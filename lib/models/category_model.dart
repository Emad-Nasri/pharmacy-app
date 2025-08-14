class CategoryModel {
  final int id;
  final String name;
  final String? image;

  CategoryModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    // التعامل مع أخطاء الحقول
    final rawId = json['cateogryID'] ?? json['categoryId'];
    final id = rawId is int ? rawId : 0;

    final rawName = json['name'];
    final name =
        (rawName is String && rawName.isNotEmpty) ? rawName : 'Unnamed';

    return CategoryModel(
      id: id,
      name: name,
      image: json['image'], // بيكون null غالباً
    );
  }
}
