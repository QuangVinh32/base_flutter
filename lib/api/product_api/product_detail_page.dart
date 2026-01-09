import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductForAdmin product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductSizeDTO? _selectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.product.sizes.isNotEmpty) {
      _selectedSize = widget.product.sizes.first;
    }
  }

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
          widget.product.productName,
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
                  _buildSizeOptions(theme),
                  const SizedBox(height: 20),
                  _buildPrice(theme),
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

  // ================= IMAGE =================
  Widget _buildImageSlider(AppTheme theme) {
    if (widget.product.productImages.isEmpty) {
      return Container(
        height: 220,
        color: theme.colors.surface,
        child: const Center(child: Icon(Icons.fastfood, size: 64)),
      );
    }

    return SizedBox(
      height: 220,
      child: PageView.builder(
        itemCount: widget.product.productImages.length,
        itemBuilder: (_, i) => Image.network(
          widget.product.productImages[i],
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.product.productName, style: theme.text.h1),
        const SizedBox(height: 6),
        _chip(widget.product.categoryStatus ?? 'Chưa phân loại', theme),
      ],
    );
  }

  // ================= SIZE OPTIONS =================
  Widget _buildSizeOptions(AppTheme theme) {
    final sizes = widget.product.sizes;

    if (sizes.isEmpty) {
      return Text('Chưa có size', style: theme.text.caption);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chọn size',
          style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sizes.map((s) {
            final selected = identical(_selectedSize, s);

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = s;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: selected
                      ? theme.colors.textPrimary
                      : theme.colors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: selected
                        ? theme.colors.textPrimary
                        : theme.colors.border,
                  ),
                ),
                child: Text(
                  s.sizeName,
                  style: theme.text.body.copyWith(
                    color: selected
                        ? Colors.white
                        : theme.colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ================= PRICE =================
  Widget _buildPrice(AppTheme theme) {
    if (_selectedSize == null) return const SizedBox();

    final s = _selectedSize!;
    final double finalPrice =
        s.discount > 0 ? s.price * (100 - s.discount) / 100 : s.price;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppUtils.formatVnd(finalPrice),
          style: theme.text.h1.copyWith(
            color: theme.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (s.discount > 0)
          Row(
            children: [
              Text(
                AppUtils.formatVnd(s.price),
                style: theme.text.caption.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '-${s.discount}%',
                style: theme.text.caption.copyWith(
                  color: theme.colors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
      ],
    );
  }

  // ================= DESCRIPTION =================
  Widget _buildDescription(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mô tả',
            style: theme.text.body.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(
          widget.product.description,
          style:
              theme.text.body.copyWith(color: theme.colors.textSecondary),
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
