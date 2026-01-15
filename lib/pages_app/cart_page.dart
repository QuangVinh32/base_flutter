import 'package:flutter/material.dart';
import 'package:shop_food_app/api/cart_api/cart_api.dart';
import 'package:shop_food_app/api/cart_api/cart_model.dart';
import 'package:shop_food_app/pages_app/cart_item_title.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> futureCart;

  @override
  void initState() {
    super.initState();
    _reloadCart();
  }

  void _reloadCart() {
    futureCart = CartApi.getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng')),
      body: FutureBuilder<List<CartItem>>(
        future: futureCart,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) => CartItemTile(
              item: items[i],
              onAdd: () async {
                await CartApi.addToCart(
                  productId: items[i].productId,
                  productSizeId: items[i].productSizeId,
                );
                setState(_reloadCart);
              },
              onMinus: () async {
                await CartApi.decreaseQuantity(
                  productId: items[i].productId,
                  productSizeId: items[i].productSizeId,
                );
                setState(_reloadCart);
              },
              onRemove: () async {
                await CartApi.removeFromCart(
                  productId: items[i].productId,
                  productSizeId: items[i].productSizeId,
                );
                setState(_reloadCart);
              },
            ),
          );
        },
      ),
    );
  }
}
