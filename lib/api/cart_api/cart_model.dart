class CartItem {
  final int productId;
  final int productSizeId;
  final String productName;
  final String sizeName;
  final double price;
  final int quantity;
  final String? image;

  CartItem({
    required this.productId,
    required this.productSizeId,
    required this.productName,
    required this.sizeName,
    required this.price,
    required this.quantity,
    this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      productSizeId: json['productSizeId'],
      productName: json['productName'],
      sizeName: json['sizeName'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      image: json['image'],
    );
  }
}
