import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_detail_page.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/api/product_size_api/product_size_models.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final AppTheme theme;
  final ProductForAdmin product;
  final ValueChanged<int>? onAddToCart;

  const ProductCard({
    super.key,
    required this.theme,
    required this.product,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.bgSecondary,
        borderRadius: BorderRadius.circular(AppUtils.radius),
        border: Border.all(color: theme.colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: _buildImage(),

        /// TITLE
        title: Text(
          product.productName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
        ),

        /// SUBTITLE = CATEGORY + CART
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              _buildCategory(),
              const Spacer(),
              _buildAddToCartButton(context),
            ],
          ),
        ),

        /// 👉 GIỮ MŨI TÊN
        trailing: const Icon(Icons.chevron_right),

        /// TAP CARD → DETAIL
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(productId: product.productId),
            ),
          );
        },
      ),
    );
  }

  // ======================
  // ADD TO CART BUTTON
  // ======================
  Widget _buildAddToCartButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onAddToCart?.call(product.productId);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã thêm vào giỏ hàng'),
            duration: Duration(milliseconds: 800),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: theme.colors.textPrimary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppUtils.radius),
        ),
        child: Icon(
          Icons.add_shopping_cart,
          size: 18,
          color: theme.colors.textPrimary,
        ),
      ),
    );
  }

  // ======================
  // CATEGORY CHIP
  // ======================
  Widget _buildCategory() {
    return _chip(
      product.categoryStatus ?? 'Chưa phân loại',
      textColor: theme.colors.textSecondary,
    );
  }

  Widget _chip(String text, {Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(AppUtils.radius),
      ),
      child: Text(text, style: theme.text.caption.copyWith(color: textColor)),
    );
  }

  // ======================
  // IMAGE
  // ======================
  Widget _buildImage() {
    if (product.productImages.isEmpty) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(AppUtils.radius),
        ),
        child: Icon(Icons.fastfood, color: theme.colors.textDisabled),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppUtils.radius),
      child: Image.network(
        product.productImages.first,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
      ),
    );
  }
}
