import 'package:flutter/material.dart';
import 'package:shop_food_app/api/api_client.dart';
import 'package:shop_food_app/api/cart_api/cart_model.dart';

class CartApi {
  // =========================
  // ADD PRODUCT TO CART
  // POST /carts/add/{productId}/{productSizeId}
  // =========================
  static Future<void> addToCart({
    required int productId,
    required int productSizeId,
  }) async {
    final res = await ApiClient.post<void>(
      '/carts/add/$productId/$productSizeId',
    );

    if (!res.isSuccess) {
      throw Exception(res.message ?? 'Add to cart failed');
    }
  }

  // =========================
  // DECREASE QUANTITY ( -1 )
  // PUT /carts/decrease/{productId}/{productSizeId}
  // =========================
  static Future<void> decreaseQuantity({
    required int productId,
    required int productSizeId,
  }) async {
    final res = await ApiClient.put<void>(
      '/carts/decrease/$productId/$productSizeId',
    );

    if (!res.isSuccess) {
      throw Exception(res.message ?? 'Decrease quantity failed');
    }
  }

  // =========================
  // REMOVE PRODUCT COMPLETELY
  // DELETE /carts/remove/{productId}/{productSizeId}
  // =========================
  static Future<void> removeFromCart({
    required int productId,
    required int productSizeId,
  }) async {
    final res = await ApiClient.delete<void>(
      '/carts/remove/$productId/$productSizeId',
    );

    if (!res.isSuccess) {
      throw Exception(res.message ?? 'Remove product failed');
    }
  }

  // =========================
  // CLEAR CART
  // DELETE /carts/clear
  // =========================
  static Future<void> clearCart() async {
    final res = await ApiClient.delete<void>(
      '/carts/clear',
    );

    if (!res.isSuccess) {
      throw Exception(res.message ?? 'Clear cart failed');
    }
  }

  // =========================
  // GET CART ITEMS
  // GET /carts/items
  // =========================
  static Future<List<CartItem>> getCartItems() async {
    final res = await ApiClient.get<List<CartItem>>(
      '/carts/items',
      parser: (json) {
        debugPrint('===== CART ITEMS =====');
        debugPrint(json.toString());
        debugPrint('======================');

        return (json as List)
            .map((e) => CartItem.fromJson(e))
            .toList();
      },
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Get cart items failed');
    }

    return res.data!;
  }

  // =========================
  // GET CART TOTAL
  // GET /carts/total
  // =========================
  static Future<double> getCartTotal() async {
    final res = await ApiClient.get<double>(
      '/carts/total',
      parser: (json) => (json as num).toDouble(),
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Get cart total failed');
    }

    return res.data!;
  }
}
