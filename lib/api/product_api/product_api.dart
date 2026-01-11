import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_food_app/api/api_client.dart';
import 'package:shop_food_app/api/upload_client.dart';
import 'product_models.dart';

class ProductApi {
  // =========================
  // GET ALL
  // =========================
  static Future<PageResponse<ProductForAdmin>> getAllProducts({
    int page = 0,
    int size = 10,
    Map<String, dynamic>? filter,
  }) async {
    final res = await ApiClient.get<PageResponse<ProductForAdmin>>(
      '/products/get-all',
      query: {'page': page, 'size': size, ...?filter},
      parser: (json) {
        debugPrint("Log GetAll ${json.toString()}");

        return PageResponse.fromJson(json, (e) => ProductForAdmin.fromJson(e));
      },
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Get products failed');
    }

    return res.data!;
  }

  // =========================
  // GET BY ID
  // =========================
  static Future<ProductForUser> getProductForUser(int id) async {
    final res = await ApiClient.get<ProductForUser>(
      '/products/user/$id',

      parser: (json) {
        debugPrint('===== RAW PRODUCT JSON =====');
        debugPrint(json.toString());
        debugPrint('============================');
        return ProductForUser.fromJson(json);
      },
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Get product failed');
    }

    return res.data!;
  }

  // =========================
  // CREATE (MULTIPART)
  // =========================
  static Future<void> createProduct({
    required Map<String, String> fields,
    required List<http.MultipartFile> images,
  }) async {
    final res = await UploadClient.multipart(
      '/products',
      'POST',
      fields: fields,
      files: images,
    );

    final body = await res.stream.bytesToString();

    if (res.statusCode != 201) {
      throw Exception(body);
    }
  }

  // =========================
  // UPDATE (MULTIPART)
  // =========================
  static Future<void> updateProduct({
    required int id,
    required Map<String, String> fields,
    List<http.MultipartFile> images = const [],
  }) async {
    final res = await UploadClient.multipart(
      '/products/$id',
      'PUT',
      fields: fields,
      files: images,
    );

    final body = await res.stream.bytesToString();

    if (res.statusCode != 200) {
      throw Exception(body);
    }
  }

  // =========================
  // DELETE
  // =========================
  static Future<void> deleteProduct(int id) async {
    final res = await ApiClient.delete<void>('/products/$id');

    if (!res.isSuccess) {
      throw Exception(res.message ?? 'Delete product failed');
    }
  }
}
