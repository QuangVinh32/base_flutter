import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_food_app/api/api_client.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/api/upload_client.dart';
import 'category_models.dart'; // DTO CategoryDTO + PageResponse

class CategoryApi {
  // =========================
  // GET ALL
  // =========================
  static Future<PageResponse<CategoryDTO>> getAllCategories({
    int page = 0,
    int size = 10,
  }) async {
    final res = await ApiClient.get<PageResponse<CategoryDTO>>(
      '/categories/get-all',
      query: {'page': page, 'size': size},
      parser: (json) {
        debugPrint("Log GetAll Categories ${json.toString()}");
        return PageResponse.fromJson(json, (e) => CategoryDTO.fromJson(e));
      },
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Get categories failed');
    }

    return res.data!;
  }

  // =========================
  // GET BY ID
  // =========================
  static Future<CategoryDTO> getCategoryById(int id) async {
    final res = await ApiClient.get<CategoryDTO>(
      '/categories/$id',
      parser: (json) {
        debugPrint('===== RAW CATEGORY JSON =====');
        debugPrint(json.toString());
        debugPrint('============================');
        return CategoryDTO.fromJson(json);
      },
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Get category failed');
    }

    return res.data!;
  }

  // =========================
  // CREATE (MULTIPART)
  // =========================
  static Future<void> createCategory({
    required Map<String, String> fields,
    required List<http.MultipartFile> images,
  }) async {
    final res = await UploadClient.multipart(
      '/categories',
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
  static Future<void> updateCategory({
    required int id,
    required Map<String, String> fields,
    List<http.MultipartFile> images = const [],
  }) async {
    final res = await UploadClient.multipart(
      '/categories/$id',
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
  static Future<void> deleteCategory(int id) async {
    final res = await ApiClient.delete<void>('/categories/$id');

    if (!res.isSuccess) {
      throw Exception(res.message ?? 'Delete category failed');
    }
  }
}
