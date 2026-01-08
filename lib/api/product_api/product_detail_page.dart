import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductForAdmin product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.bgPrimary,
      appBar: AppBar(
        backgroundColor: theme.colors.bgSecondary,
        foregroundColor: theme.colors.textPrimary,
        elevation: 0,
        title: Text(
          product.productName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(theme),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(theme),
                  const SizedBox(height: 16),
                  _buildSizes(theme),
                  const SizedBox(height: 20),
                  _buildDescription(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🖼️ SLIDER ẢNH
  Widget _buildImageSlider(AppTheme theme) {
    if (product.productImages.isEmpty) {
      return Container(
        height: 220,
        color: theme.colors.surface,
        child: const Center(child: Icon(Icons.fastfood, size: 64)),
      );
    }

    return SizedBox(
      height: 220,
      child: PageView.builder(
        itemCount: product.productImages.length,
        itemBuilder: (_, index) {
          return Image.network(
            product.productImages[index],
            fit: BoxFit.cover,
            width: double.infinity,
          );
        },
      ),
    );
  }

  // 🧾 TÊN + LOẠI
  Widget _buildHeader(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.productName,
        ),
        const SizedBox(height: 6),
        _chip(
          product.categoryStatus ?? 'Chưa phân loại',
          theme,
        ),
      ],
    );
  }

  Widget _buildSizes(AppTheme theme) {
    if (product.sizes.isEmpty) {
      return Text(
        'Chưa có size',
        style: theme.text.caption,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Các loại',
          style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...product.sizes.map(
          (s) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: theme.colors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.sizeName,
                  style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppUtils.formatVnd(s.price),
                      style: theme.text.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (s.discount > 0)
                      Text(
                        'Giảm ${s.discount}%',
                        style: theme.text.caption.copyWith(
                          color: theme.colors.error,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mô tả',
          style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: theme.text.body.copyWith(
            color: theme.colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _chip(String text, AppTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: theme.text.caption.copyWith(
          color: theme.colors.textSecondary,
        ),
      ),
    );
  }
}
