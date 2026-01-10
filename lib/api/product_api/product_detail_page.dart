import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_api.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductForUser? _product;
  ProductSizeDTO? _selectedSize;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

Future<void> _loadProduct() async {
  try {
    final res = await ProductApi.getProductForUser(widget.productId);

    if (!mounted) return;

    setState(() {
      _product = res;
      _selectedSize = res.sizes.isNotEmpty ? res.sizes.first : null;
      _loading = false;
    });
  } catch (e, s) {
    debugPrint('LOAD PRODUCT ERROR: $e');
    debugPrintStack(stackTrace: s);

    if (mounted) {
      setState(() => _loading = false);
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_product == null) {
      return const Scaffold(
        body: Center(child: Text('Không tìm thấy sản phẩm')),
      );
    }

    final product = _product!;

    return Scaffold(
      backgroundColor: theme.colors.bgPrimary,
      appBar: AppBar(
        backgroundColor: theme.colors.bgSecondary,
        foregroundColor: theme.colors.textPrimary,
        elevation: 0,
        title: Text(product.productName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImages(product, theme),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(product, theme),
                  const SizedBox(height: 16),
                  _buildSizeOptions(product, theme),
                  const SizedBox(height: 20),
                  _buildPrice(theme),
                  const SizedBox(height: 20),
                  _buildDescription(product, theme),
                  const SizedBox(height: 20),
                  _buildReviews(product, theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviews(ProductForUser product, AppTheme theme) {
    if (product.reviews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Chưa có đánh giá', style: theme.text.caption),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Đánh giá',
          style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...product.reviews.map((r) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.user?.fullName ?? 'Người dùng',
                  style: theme.text.body.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < r.rating ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(r.reviewText, style: theme.text.body),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ================= IMAGE =================
  Widget _buildImages(ProductForUser product, AppTheme theme) {
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
        itemBuilder: (_, i) => Image.network(
          product.productImages[i],
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(ProductForUser product, AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.productName, style: theme.text.h1),
        const SizedBox(height: 6),
        _chip(
          product.categoryStatus ?? 'Chưa phân loại',
          theme,
        ),
      ],
    );
  }

  // ================= SIZE =================
  Widget _buildSizeOptions(ProductForUser product, AppTheme theme) {
    if (product.sizes.isEmpty) {
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
          children: product.sizes.map((s) {
            final selected = identical(_selectedSize, s);

            return GestureDetector(
              onTap: () => setState(() => _selectedSize = s),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
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
                    color: selected ? Colors.white : theme.colors.textPrimary,
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
    final double finalPrice = s.discount > 0
        ? s.price * (100 - s.discount) / 100
        : s.price;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppUtils.formatVnd(finalPrice),
          style: theme.text.h1.copyWith(fontWeight: FontWeight.w700),
        ),
        if (s.discount > 0)
          Text(
            AppUtils.formatVnd(s.price),
            style: theme.text.caption.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }

  // ================= DESCRIPTION =================
  Widget _buildDescription(ProductForUser product, AppTheme theme) {
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
          style: theme.text.body.copyWith(color: theme.colors.textSecondary),
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
      child: Text(text, style: theme.text.caption),
    );
  }
}
