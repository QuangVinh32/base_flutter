import 'package:flutter/material.dart';
import 'package:shop_food_app/api/product_api/product_api.dart';
import 'package:shop_food_app/api/product_api/product_card.dart';
import 'package:shop_food_app/api/product_api/product_models.dart';
import 'package:shop_food_app/component/empty_result_view.dart';
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
  late Future<PageResponse<ProductForAdmin>> future;
  final TextEditingController searchController = TextEditingController();
  List<ProductForAdmin> allProducts = [];
  List<ProductForAdmin> filteredProducts = [];
  List<String> categories = [];
  String? electedCategory;
  bool initialized = false;

  // =========================
  // INIT
  // =========================
  @override
  void initState() {
    super.initState();
    future = ProductApi.getAllProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =========================
  // INIT DATA SAU KHI LOAD API
  // =========================
  void _initData(List<ProductForAdmin> products) {
    allProducts = products;
    filteredProducts = products;

    categories = products
        .map((e) => e.categoryStatus)
        .whereType<String>()
        .toSet()
        .toList();
    initialized = true;
  }

  // =========================
  // FILTER (SEARCH + CATEGORY)
  // =========================
  void _applyFilter({String? keyword, String? category}) {
    final q = (keyword ?? searchController.text).trim().toLowerCase();

    setState(() {
      electedCategory = category;
      filteredProducts = allProducts.where((p) {
        final name = p.productName.toLowerCase();
        final desc = (p.description).toLowerCase();
        final matchSearch = q.isEmpty || name.contains(q) || desc.contains(q);
        final matchCategory =
            electedCategory == null || p.categoryStatus == electedCategory;
        return matchSearch && matchCategory;
      }).toList();
    });
  }

  // =========================
  // UI
  // =========================
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
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          final page = snapshot.data!;
          if (!initialized) {
            _initData(page.content);
          }
          return _buildBody(theme);
        },
      ),
    );
  }

  Widget _buildBody(AppTheme theme) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: CustomTextField(
            theme: theme,
            controller: searchController,
            hintText: 'Tìm kiếm sản phẩm',
            prefixIcon: Icons.search,
            suffixIcon: Icons.close,
            onChanged: (v) => _applyFilter(keyword: v),
          ),
        ),

        const SwiperBanner(
          images: [
            // 'assets/images/hue.jpg',
            'assets/images/hue12.jpg',
            'assets/images/hue123.jpg',
          ],
        ),
        const SizedBox(height: 6),
        if (categories.isNotEmpty)
          CategorySwiper(
            categories: categories,
            onSelected: (c) => _applyFilter(category: c == 'Tất cả' ? null : c),
          ),

        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: filteredProducts.isEmpty
              ? const EmptyResultView()
              : Column(
                  children: filteredProducts
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
  }

  Widget _buildEmpty(AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Text(
          'Không có sản phẩm',
          style: theme.text.caption.copyWith(color: theme.colors.textSecondary),
        ),
      ),
    );
  }
}
