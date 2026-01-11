import 'package:flutter/material.dart';
import 'package:shop_food_app/api/api_client.dart';
import 'product_size_models.dart';

class ProductSizeApi {
  // =========================
  // GET SIZE BY PRODUCT (PUBLIC)
  // =========================
  static Future<List<ProductSize>> getSizesByProduct(int productId) async {
    final res = await ApiClient.get<List<ProductSize>>(
      '/product_sizes/product/$productId',
      parser: (json) {
        debugPrint('RAW SIZE JSON: $json');
        return (json as List)
            .map((e) => ProductSize.fromJson(e))
            .toList();
      },
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Get product sizes failed');
    }

    return res.data!;
  }

  // =========================
  // GET SIZE BY ID
  // =========================
  static Future<ProductSize> getById(int sizeId) async {
    final res = await ApiClient.get<ProductSize>(
      '/product_sizes/$sizeId',
      parser: (json) => ProductSize.fromJson(json),
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Get size failed');
    }

    return res.data!;
  }

  // =========================
  // CREATE SIZE (ADMIN)
  // =========================
  static Future<ProductSize> create({
    required int productId,
    required Map<String, dynamic> body,
  }) async {
    final res = await ApiClient.post<ProductSize>(
      '/product_sizes/product/$productId',
      body: body,
      parser: (json) => ProductSize.fromJson(json),
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Create size failed');
    }

    return res.data!;
  }

  // =========================
  // UPDATE SIZE
  // =========================
  static Future<ProductSize> update({
    required int sizeId,
    required Map<String, dynamic> body,
  }) async {
    final res = await ApiClient.put<ProductSize>(
      '/product_sizes/$sizeId',
      body: body,
      parser: (json) => ProductSize.fromJson(json),
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Update size failed');
    }

    return res.data!;
  }

  // =========================
  // BULK UPSERT
  // =========================
  static Future<void> bulkUpsert({
    required int productId,
    required List<Map<String, dynamic>> body,
  }) async {
    final res = await ApiClient.post<void>(
      '/product_sizes/bulk/$productId',
      body: body,
    );

    if (!res.isSuccess) {
      throw Exception(res.message ?? 'Bulk upsert failed');
    }
  }
}
