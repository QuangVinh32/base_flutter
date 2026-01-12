import 'package:flutter/material.dart';
import 'package:shop_food_app/theme/app_theme.dart';
import 'package:shop_food_app/library/app_utils.dart';
import '../api/category_api/category_models.dart';

class CategorySwiper extends StatefulWidget {
  final List<CategoryDTO> categories;
  final ValueChanged<String?> onSelected;

  const CategorySwiper({
    super.key,
    required this.categories,
    required this.onSelected,
  });

  @override
  State<CategorySwiper> createState() => _CategorySwiperState();
}

class _CategorySwiperState extends State<CategorySwiper> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final itemCount = widget.categories.length + 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), 
      child: SizedBox(
        height: 80,
        child: ListView.separated(
          // Bỏ padding ở đây đi
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final bool isAll = i == 0;
            final String label = isAll
                ? 'Tất cả'
                : widget.categories[i - 1].categoryStatus ?? '';
            final String? imageUrl = isAll
                ? null
                : widget.categories[i - 1].categoryImage;
            final bool active = isAll ? selected == null : selected == label;

            return InkWell(
              onTap: () {
                setState(() {
                  selected = isAll ? null : label;
                });
                widget.onSelected(selected);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipOval(
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.category,
                              size: 40,
                              color: theme.colors.textSecondary,
                            ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 60,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.text.body.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: active
                            ? theme.colors.accent
                            : theme.colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
