class InvoiceItem {
  String name;
  double price;
  int quantity;

  InvoiceItem(
      {required this.name, required this.price, required this.quantity});

  double get total => price * quantity;

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
