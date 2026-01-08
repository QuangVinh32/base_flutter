import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_detail_page.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final AppTheme theme;
  final ProductForAdmin product;

  const ProductCard({super.key, required this.theme, required this.product});

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

        /// 🔥 GIÁ + LOẠI (THAY MÔ TẢ)
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              // _buildPriceRange(),
              // const SizedBox(width: 8),
              _buildCategory(),
            ],
          ),
        ),

        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(product: product),
            ),
          );
        },
      ),
    );
  }

  // 💰 GIÁ MIN - MAX
  // Widget _buildPriceRange() {
  //   if (product.sizes.isEmpty) {
  //     return _chip('Chưa có giá');
  //   }

  //   final prices = product.sizes.map((e) => e.price).toList();
  //   prices.sort();

  //   final min = prices.first;
  //   final max = prices.last;

  //   final text = min == max
  //       ? AppUtils.formatVnd(min)
  //       : '${AppUtils.formatVnd(min)} - ${AppUtils.formatVnd(max)}';

  //   return _chip(
  //     text,
  //     textColor: theme.colors.textPrimary,
  //     fontWeight: FontWeight.w600,
  //   );
  // }

  // 🏷️ LOẠI / TRẠNG THÁI
  Widget _buildCategory() {
    return _chip(
      product.categoryStatus ?? 'Chưa phân loại',
      textColor: theme.colors.textSecondary,
    );
  }

  // 🎨 CHIP DÙNG CHUNG
  Widget _chip(String text, {Color? textColor, FontWeight? fontWeight}) {
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

  // 🖼️ ẢNH
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
