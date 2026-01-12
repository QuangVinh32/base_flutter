// import 'package:flutter/material.dart';
// import 'package:shop_food_app/api/category_api/category_api.dart';
// import 'package:shop_food_app/api/category_api/category_models.dart';
// import 'package:shop_food_app/api/product_api/product_models.dart';
// import 'package:shop_food_app/component/category_swiper.dart';
// import 'package:shop_food_app/theme/app_theme.dart';

// class CategoryListView extends StatefulWidget {
//   const CategoryListView({super.key});

//   @override
//   State<CategoryListView> createState() => _CategoryListViewState();
// }

// class _CategoryListViewState extends State<CategoryListView> {
//   late Future<PageResponse<CategoryDTO>> futureCategories;
//   List<CategoryDTO> categories = [];
//   bool initialized = false;
//   String? selectedCategory;

//   @override
//   void initState() {
//     super.initState();
//     futureCategories = CategoryApi.getAllCategories(page: 0, size: 20);
//   }

//   void _onSelected(String? category) {
//     setState(() {
//       selectedCategory = category;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = AppTheme.of(context);
//     return FutureBuilder<PageResponse<CategoryDTO>>(
//       future: futureCategories,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Lỗi: ${snapshot.error}'));
//         }

//         final page = snapshot.data!;
//         categories = page.content;

//         return Column(
//           children: [
//             if (categories.isNotEmpty)
//               CategorySwiper(
//                 categories: categories,
//                 onSelected: _onSelected,
//               ),
//             const SizedBox(height: 12),
//             Text(
//               selectedCategory != null
//                   ? 'Bạn chọn: $selectedCategory'
//                   : 'Tất cả danh mục',
//               style: theme.text.body,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
