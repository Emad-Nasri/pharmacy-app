class ProductModel {
  final int productId;
  final String name;
  final String? description;
  final int? categoryId;
  final String? categoryName;
  final num? sellPrice;
  final int? minimumStockLevel;
  final dynamic medicineResponse;

  ProductModel({
    required this.productId,
    required this.name,
    this.description,
    this.categoryId,
    this.categoryName,
    this.sellPrice,
    this.minimumStockLevel,
    this.medicineResponse,
  });

  factory ProductModel.fromJson(Map<String, dynamic> j) => ProductModel(
        productId: j['productId'] ?? 0,
        name: j['name'] ?? '',
        description: j['description'],
        categoryId: j['categoryId'],
        categoryName: j['categoryName'],
        sellPrice: j['sellPrice'],
        minimumStockLevel: j['minimumStockLevel'],
        medicineResponse: j['medicineResponse'],
      );
}
