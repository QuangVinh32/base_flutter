import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_detail_page.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final AppTheme theme;
  final ProductForAdmin product;

  const ProductCard({
    super.key,
    required this.theme,
    required this.product,
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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: _buildImage(),
        title: Text(
          product.productName,
          style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: _buildCategory(),
        ),
        trailing: const Icon(Icons.chevron_right),

        /// ✅ CHỈ TRUYỀN ID
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ProductDetailPage(productId: product.productId),
            ),
          );
        },
      ),
    );
  }

  // 🏷️ CATEGORY
  Widget _buildCategory() {
    return _chip(
      product.categoryStatus ?? 'Chưa phân loại',
      textColor: theme.colors.textSecondary,
    );
  }

  // 🎨 CHIP
  Widget _chip(String text,
      {Color? textColor, FontWeight? fontWeight}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(AppUtils.radius),
      ),
      child: Text(
        text,
        style: theme.text.caption.copyWith(
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  // 🖼️ IMAGE
  Widget _buildImage() {
    if (product.productImages.isEmpty) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(AppUtils.radius),
        ),
        child: Icon(
          Icons.fastfood,
          color: theme.colors.textDisabled,
        ),
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
