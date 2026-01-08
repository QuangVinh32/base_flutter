import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_food_app/api/api_client.dart';
import 'product_models.dart';

class ProductApi {
  /// GET /api/products/get-all
  static Future<PageResponse<ProductForAdmin>> getAllProducts({
    int page = 0,
    int size = 10,
    Map<String, dynamic>? filter,
  }) async {
    final res = await ApiClient.get(
      '/products/get-all',
      query: {
        'page': page,
        'size': size,
        ...?filter,
      },
    );

    final jsonData = jsonDecode(res.body);
    return PageResponse.fromJson(
      jsonData,
      (e) => ProductForAdmin.fromJson(e),
    );
  }

  /// GET /api/products/admin/{id}
  static Future<ProductForAdmin> getProductForAdmin(int id) async {
    final res = await ApiClient.get('/products/admin/$id');
    return ProductForAdmin.fromJson(jsonDecode(res.body));
  }

  /// GET /api/products/user/{id}
  static Future<ProductForUser> getProductForUser(int id) async {
    final res = await ApiClient.get('/products/user/$id');
    return ProductForUser.fromJson(jsonDecode(res.body));
  }

  /// POST /api/products
  static Future<void> createProduct({
    required Map<String, String> fields,
    required List<http.MultipartFile> images,
  }) async {
    final res = await ApiClient.multipart(
      '/products',
      'POST',
      fields,
      images,
    );

    if (res.statusCode != 201) {
      throw Exception('Create product failed');
    }
  }

  /// PUT /api/products/{id}
  static Future<void> updateProduct({
    required int id,
    required Map<String, String> fields,
    List<http.MultipartFile> images = const [],
  }) async {
    final res = await ApiClient.multipart(
      '/products/$id',
      'PUT',
      fields,
      images,
    );

    if (res.statusCode != 200) {
      throw Exception('Update product failed');
    }
  }

  /// DELETE /api/products/{id}
  static Future<void> deleteProduct(int id) async {
    final res = await ApiClient.delete('/products/$id');
    if (res.statusCode != 200) {
      throw Exception('Delete product failed');
    }
  }
}
