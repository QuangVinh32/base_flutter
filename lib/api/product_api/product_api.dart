import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_food_app/api/api_client.dart';
import 'product_models.dart';

class ProductApi {
  // =========================
  // GET ALL (ADMIN)
  // =========================
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

    if (res.statusCode != 200) {
      throw Exception('Get products failed: ${res.statusCode}');
    }

    return PageResponse.fromJson(
      jsonDecode(res.body),
      (e) => ProductForAdmin.fromJson(e),
    );
  }

  // =========================
  // GET BY ID (ADMIN)
  // =========================
  static Future<ProductForAdmin> getProductForAdmin(int id) async {
    final res = await ApiClient.get('/products/admin/$id');

    if (res.statusCode != 200) {
      throw Exception('Get product failed: ${res.statusCode}');
    }

    return ProductForAdmin.fromJson(jsonDecode(res.body));
  }

  // =========================
  // GET BY ID (USER)
  // =========================
  static Future<ProductForUser> getProductForUser(int id) async {
    final res = await ApiClient.get('/products/user/$id');

    if (res.statusCode != 200) {
      throw Exception('Get product failed: ${res.statusCode}');
    }

    return ProductForUser.fromJson(jsonDecode(res.body));
  }

  // =========================
  // CREATE PRODUCT (MULTIPART)
  // =========================
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

    final body = await res.stream.bytesToString();

    if (res.statusCode != 201) {
      throw Exception('Create product failed: $body');
    }
  }

  // =========================
  // UPDATE PRODUCT (MULTIPART)
  // =========================
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

    final body = await res.stream.bytesToString();

    if (res.statusCode != 200) {
      throw Exception('Update product failed: $body');
    }
  }

  // =========================
  // DELETE PRODUCT
  // =========================
  static Future<void> deleteProduct(int id) async {
    final res = await ApiClient.delete('/products/$id');

    if (res.statusCode != 200) {
      throw Exception('Delete product failed: ${res.body}');
    }
  }
}
