import 'package:flutter/material.dart';
import 'package:shop_food_app/api/cart_api/cart_api.dart';
import 'package:shop_food_app/api/product_size_api/product_size_models.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class SizeSelectView extends StatefulWidget {
  final int productId;
  final List<ProductSize> sizes;

  const SizeSelectView({
    super.key,
    required this.productId,
    required this.sizes,
  });

  @override
  State<SizeSelectView> createState() => _SizeSelectViewState();
}

class _SizeSelectViewState extends State<SizeSelectView> {
  late ProductSize selectedSize;
  final Map<int, int> quantities = {}; // quantity theo từng size
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.sizes.first;

    // init quantity = 1 cho mỗi size
    for (final s in widget.sizes) {
      quantities[s.productSizeId] = 1;
    }
  }

  int get quantity => quantities[selectedSize.productSizeId]!;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final price = selectedSize.price;
    final discount = selectedSize.discount ?? 0;
    final stock = selectedSize.quantity;
    final discountedPrice = price - (price * discount / 100);
    final totalPrice = discountedPrice * quantity;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chọn size',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          /// SIZE SELECT
          Wrap(
            spacing: 8,
            children: widget.sizes.map((s) {
              final isSelected = s.productSizeId == selectedSize.productSizeId;
              return ChoiceChip(
                label: Text(s.sizeName),
                selected: isSelected,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppUtils.radius),
                ),
                onSelected: (_) {
                  setState(() => selectedSize = s);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          /// STOCK
          Text(
            'Còn lại: $stock sản phẩm',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: stock > 0 ? theme.colors.accent : Colors.red,
            ),
          ),

          const SizedBox(height: 12),

          /// PRICE + QUANTITY
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// PRICE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Giá'),
                  if (discount > 0)
                    Text(
                      '${price.toStringAsFixed(0)} đ',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  Row(
                    children: [
                      Text(
                        '${discountedPrice.toStringAsFixed(0)} đ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      if (discount > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '-$discount%',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),

              /// QUANTITY
              Row(
                children: [
                  _qtyButton(
                    icon: Icons.remove,
                    onTap: quantity > 1
                        ? () => setState(
                            () => quantities[selectedSize.productSizeId] =
                                quantity - 1,
                          )
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _qtyButton(
                    icon: Icons.add,
                    onTap: quantity < stock
                        ? () => setState(
                            () => quantities[selectedSize.productSizeId] =
                                quantity + 1,
                          )
                        : null,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// TOTAL
          Text(
            'Tổng: ${totalPrice.toStringAsFixed(0)} đ',
            style: TextStyle(
              fontSize: 18,
              color: Colors.green[600],
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          /// ADD TO CART
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: stock == 0 || _loading ? null : _addToCart,
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Thêm vào giỏ hàng'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addToCart() async {
    setState(() => _loading = true);
    try {
      await CartApi.addToCart(
        productId: widget.productId,
        productSizeId: selectedSize.productSizeId,
        quantity: quantity,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _qtyButton({required IconData icon, VoidCallback? onTap}) {
    return SizedBox(
      width: 28,
      height: 28,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppUtils.radius),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onTap == null ? Colors.grey.shade300 : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16),
        ),
      ),
    );
  }
}
