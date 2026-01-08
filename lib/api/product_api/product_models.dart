class ProductSizeDTO {
  final String sizeName;
  final double price;
  final int discount;
  final int quantity;

  ProductSizeDTO({
    required this.sizeName,
    required this.price,
    required this.discount,
    required this.quantity,
  });

  factory ProductSizeDTO.fromJson(Map<String, dynamic> json) {
    return ProductSizeDTO(
      sizeName: json['sizeName'],
      price: (json['price'] as num).toDouble(),
      discount: json['discount'],
      quantity: json['quantity'],
    );
  }
}

class ProductForAdmin {
  final int productId;
  final String productName;
  final String description;
  final String? categoryStatus;
  final List<String> productImages;
  final List<ProductSizeDTO> sizes;

  ProductForAdmin({
    required this.productId,
    required this.productName,
    required this.description,
    this.categoryStatus,
    required this.productImages,
    required this.sizes,
  });

  factory ProductForAdmin.fromJson(Map<String, dynamic> json) {
    return ProductForAdmin(
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'],
      categoryStatus: json['categoryStatus'],
      productImages: List<String>.from(json['productImages'] ?? []),
      sizes: (json['sizes'] as List? ?? [])
          .map((e) => ProductSizeDTO.fromJson(e))
          .toList(),
    );
  }
}


class ProductForUser {
  final int productId;
  final String productName;
  final String description;
  final List<String> images;
  final List<ProductSizeDTO> sizes;

  ProductForUser({
    required this.productId,
    required this.productName,
    required this.description,
    required this.images,
    required this.sizes,
  });

  factory ProductForUser.fromJson(Map<String, dynamic> json) {
    return ProductForUser(
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'],
      images: List<String>.from(json['productImages'] ?? []),
      sizes: (json['sizes'] as List? ?? [])
          .map((e) => ProductSizeDTO.fromJson(e))
          .toList(),
    );
  }
}

class PageResponse<T> {
  final List<T> content;
  final int totalElements;
  final int totalPages;
  final int number;

  PageResponse({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.number,
  });

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PageResponse(
      content: (json['content'] as List)
          .map((e) => fromJsonT(e))
          .toList(),
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      number: json['number'],
    );
  }
}
