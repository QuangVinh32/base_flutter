class ProductSize {
  final int productSizeId;
  final String sizeName;
  final double price;
  final double discount;
  final int quantity;

  ProductSize({
    required this.productSizeId,
    required this.sizeName,
    required this.price,
    required this.discount,
    required this.quantity,
  });

  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(
      productSizeId: json['productSizeId'],
      sizeName: json['sizeName'],
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }

  double get finalPrice => price - discount;
}
