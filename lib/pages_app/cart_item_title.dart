import 'package:flutter/material.dart';
import 'package:shop_food_app/api/cart_api/cart_model.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onAdd;
  final VoidCallback onMinus;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onMinus,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Size: ${item.sizeName}'),
              ],
            ),
            Row(
              children: [
                IconButton(icon: const Icon(Icons.remove), onPressed: onMinus),
                Text('${item.quantity}'),
                IconButton(icon: const Icon(Icons.add), onPressed: onAdd),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
