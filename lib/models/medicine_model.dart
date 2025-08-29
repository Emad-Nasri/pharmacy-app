class ProductBrief {
  final int productId;
  final String name;
  final String? description;
  final String? categoryName;
  final num? sellPrice;
  final int? minimumStockLevel;

  ProductBrief({
    required this.productId,
    required this.name,
    this.description,
    this.categoryName,
    this.sellPrice,
    this.minimumStockLevel,
  });

  factory ProductBrief.fromJson(Map<String, dynamic>? j) {
    if (j == null) {
      return ProductBrief(productId: 0, name: '');
    }
    return ProductBrief(
      productId: j['productId'] ?? 0,
      name: j['name'] ?? '',
      description: j['description'],
      categoryName: j['categoryName'],
      sellPrice: j['sellPrice'],
      minimumStockLevel: j['minimumStockLevel'],
    );
  }
}

class MedicineDetails {
  final String? manufacturer;
  final String? activeIngredient;
  final String? categoryName; // قد تكون null بالرد
  final String? medicineTypeName; // قد تكون null
  final bool? isRequiredDescription;
  final ProductBrief productResponse;

  MedicineDetails({
    this.manufacturer,
    this.activeIngredient,
    this.categoryName,
    this.medicineTypeName,
    this.isRequiredDescription,
    required this.productResponse,
  });

  factory MedicineDetails.fromJson(Map<String, dynamic>? j) {
    if (j == null) {
      return MedicineDetails(productResponse: ProductBrief.fromJson(null));
    }
    return MedicineDetails(
      manufacturer: j['manufacturer'],
      activeIngredient: j['activeIngredient'],
      categoryName: j['categoryName'],
      medicineTypeName: j['medicineTypeName'],
      isRequiredDescription: j['isRequiredDescription'],
      productResponse: ProductBrief.fromJson(j['productResponse']),
    );
  }
}

class MedicineModel {
  final int productId; // من الرد الأساسي
  final String name;
  final String? description;
  final int? categoryId;
  final String? categoryName;
  final num? sellPrice;
  final int? minimumStockLevel;
  final MedicineDetails medicineDetails;

  MedicineModel({
    required this.productId,
    required this.name,
    this.description,
    this.categoryId,
    this.categoryName,
    this.sellPrice,
    this.minimumStockLevel,
    required this.medicineDetails,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> j) => MedicineModel(
        productId: j['productId'] ?? 0,
        name: j['name'] ?? '',
        description: j['description'],
        categoryId: j['categoryId'],
        categoryName: j['categoryName'],
        sellPrice: j['sellPrice'],
        minimumStockLevel: j['minimumStockLevel'],
        medicineDetails: MedicineDetails.fromJson(j['medicineResponse']),
      );
}
