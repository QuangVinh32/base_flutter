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
      sizeName: json['sizeName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discount: json['discount'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }
}

class ReviewDTO {
  final int rating;
  final String reviewText;
  final DateTime createdAt;
  final UserDTO? user;

  ReviewDTO({
    required this.rating,
    required this.reviewText,
    required this.createdAt,
    this.user,
  });

  factory ReviewDTO.fromJson(Map<String, dynamic> json) {
    return ReviewDTO(
      rating: json['rating'] ?? 0,
      reviewText: json['reviewText'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      user: json['userDTO'] != null
          ? UserDTO.fromJson(json['userDTO'])
          : null,
    );
  }
}



class ProductForAdmin {
  final int productId;
  final String productName;
  // final String description;
  final String? categoryStatus;
  final List<String> productImages;
  // final List<ProductSizeDTO> sizes;

  ProductForAdmin({
    required this.productId,
    required this.productName,
    // required this.description,
    this.categoryStatus,
    required this.productImages,
    // required this.sizes,
  });

  factory ProductForAdmin.fromJson(Map<String, dynamic> json) {
    return ProductForAdmin(
      productId: json['productId'],
      productName: json['productName'],
      // description: json['description'],
      categoryStatus: json['categoryStatus'],
      productImages: List<String>.from(json['productImages'] ?? []),
      // sizes: (json['sizes'] as List? ?? [])
      //     .map((e) => ProductSizeDTO.fromJson(e))
      //     .toList(),
    );
  }
}


class ProductForUser {
  final String productName;
  final String description;
  final List<String> productImages;
  final List<ProductSizeDTO> sizes;
  final List<ReviewDTO> reviews;

  final int? categoryId;
  final String? categoryImage;
  final String? categoryStatus;

  ProductForUser({
    required this.productName,
    required this.description,
    required this.productImages,
    required this.sizes,
    required this.reviews,
    this.categoryId,
    this.categoryImage,
    this.categoryStatus,
  });

  factory ProductForUser.fromJson(Map<String, dynamic> json) {
    return ProductForUser(
      productName: json['productName'] ?? '',
      description: json['description'] ?? '',
      productImages: List<String>.from(json['productImages'] ?? []),
      sizes: (json['sizes'] as List? ?? [])
          .map((e) => ProductSizeDTO.fromJson(e))
          .toList(),
      reviews: (json['reviews'] as List? ?? [])
          .map((e) => ReviewDTO.fromJson(e))
          .toList(),
      categoryId: json['categoryId'],
      categoryImage: json['categoryImage'],
      categoryStatus: json['categoryStatus'],
    );
  }
}




class UserDTO {
  final int id;
  final String fullName;

  UserDTO({
    required this.id,
    required this.fullName,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? 'Người dùng',
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
