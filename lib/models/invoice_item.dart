// models/invoice_item.dart
class InvoiceItem {
  int productId; // مهم للباك
  String name;
  double price;
  int quantity;

  InvoiceItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  // الجسم المطلوب لإرسال الفاتورة (حسب الباك عندك)
  Map<String, dynamic> toSaleItemMap() => {
        'productID': productId,
        'quantity': quantity,
      };

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      productId: json['productId'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: (json['quantity'] ?? 0).toInt(),
    );
  }
}
