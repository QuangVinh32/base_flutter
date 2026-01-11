import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_size_api/product_size_models.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class SizeSelectView extends StatefulWidget {
  final List<ProductSize> sizes;

  const SizeSelectView({super.key, required this.sizes});

  @override
  State<SizeSelectView> createState() => _SizeSelectViewState();
}

class _SizeSelectViewState extends State<SizeSelectView> {
  late ProductSize selectedSize;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.sizes.first;
  }

  @override
  Widget build(BuildContext context) {
    final price = selectedSize.price;
    final discount = selectedSize.discount ?? 0;
    final stock = selectedSize.quantity;
    final discountedPrice = price - (price * discount / 100);
    final totalPrice = discountedPrice * quantity;

    final theme = AppTheme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          const Text(
            'Chọn size',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          /// SIZE BUTTONS (CHỈ HIỆN SIZE)
          Wrap(
            spacing: 8,
            children: widget.sizes.map((s) {
              final isSelected = s.productSizeId == selectedSize.productSizeId;
              return ChoiceChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppUtils.radius),
                ),

                label: Text(s.sizeName),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    selectedSize = s;
                    quantity = 1;
                  });
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

                  /// Giá gốc (nếu có discount)
                  if (discount > 0)
                    Text(
                      '${price.toStringAsFixed(0)} đ',
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),

                  /// Giá sau giảm
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
              const SizedBox(height: 8),

              /// QUANTITY
              Row(
                children: [
                  _qtyButton(
                    icon: Icons.remove,
                    onTap: quantity > 1
                        ? () => setState(() => quantity--)
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
                        ? () => setState(() => quantity++)
                        : null,
                  ),
                ],
              ),
            ],
          ),
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
              onPressed: stock == 0
                  ? null
                  : () {
                      Navigator.pop(context);
                      debugPrint(
                        'ADD CART → size=${selectedSize.sizeName}, '
                        'qty=$quantity, price=$price',
                      );
                    },
              child: const Text('Thêm vào giỏ hàng'),
            ),
          ),
        ],
      ),
    );
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
