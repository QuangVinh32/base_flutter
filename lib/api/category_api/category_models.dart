class CategoryDTO {
  final String? categoryStatus;
  final String? categoryImage;

  CategoryDTO({this.categoryStatus, this.categoryImage});

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
      categoryStatus: json['categoryStatus'],
      categoryImage: json['categoryImage'],
    );
  }
}
