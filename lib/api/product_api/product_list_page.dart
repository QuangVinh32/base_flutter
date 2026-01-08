import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_api.dart';
import 'package:shop_food_app/api/product_api/product_card.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/component/swiper_banner.dart';
import 'package:shop_food_app/component/category_swiper.dart';
import 'package:shop_food_app/component/custom_text_field.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<PageResponse<ProductForAdmin>> _future;
  final TextEditingController _searchController = TextEditingController();

  List<ProductForAdmin> _allProducts = [];
  List<ProductForAdmin> _filteredProducts = [];
  List<String> _categories = [];

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _future = ProductApi.getAllProducts();
  }

  // 🔍 FILTER CHUNG (SEARCH + CATEGORY)
  void _applyFilter({String? keyword, String? category}) {
    final q = (keyword ?? _searchController.text).trim().toLowerCase();

    setState(() {
      // category null = TẤT CẢ
      _selectedCategory = category;

      _filteredProducts = _allProducts.where((p) {
        final matchSearch =
            q.isEmpty ||
            p.productName.toLowerCase().contains(q) ||
            p.description.toLowerCase().contains(q);

        final matchCategory =
            _selectedCategory == null || p.categoryStatus == _selectedCategory;

        return matchSearch && matchCategory;
      }).toList();
    });
  }

  void _buildCategories() {
    _categories = _allProducts
        .map((e) => e.categoryStatus)
        .whereType<String>()
        .toSet()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.bgPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colors.bgSecondary,
        foregroundColor: theme.colors.textPrimary,
        title: const Text(
          'Danh sách sản phẩm',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder<PageResponse<ProductForAdmin>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          final page = snapshot.data!;
          _allProducts = page.content;

          if (_filteredProducts.isEmpty) {
            _filteredProducts = _allProducts;
            _buildCategories();
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              // 🔍 SEARCH
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: CustomTextField(
                  theme: theme,
                  controller: _searchController,
                  hintText: 'Tìm kiếm sản phẩm',
                  prefixIcon: Icons.search,
                  suffixIcon: Icons.close,
                  onChanged: (v) => _applyFilter(keyword: v),
                ),
              ),

              const SwiperBanner(
                images: [
                  'https://picsum.photos/800/400?1',
                  'https://picsum.photos/800/400?2',
                  'https://picsum.photos/800/400?3',
                ],
              ),

              const SizedBox(height: 12),

              // 🏷️ CATEGORY SWIPER
              if (_categories.isNotEmpty)
                CategorySwiper(
                  categories: _categories,
                  onSelected: (c) => _applyFilter(category: c),
                ),

              const SizedBox(height: 16),

              // 📦 PRODUCT LIST
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _filteredProducts.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'Không có sản phẩm',
                            style: theme.text.caption.copyWith(
                              color: theme.colors.textSecondary,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: _filteredProducts
                            .map(
                              (p) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ProductCard(theme: theme, product: p),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
