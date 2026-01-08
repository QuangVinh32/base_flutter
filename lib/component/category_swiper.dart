import 'package:flutter/material.dart';
import 'package:shop_food_app/library/app_utils.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class CategorySwiper extends StatefulWidget {
  final List<String> categories;
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
  String? selected; // null = Tất cả

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    // +1 cho item "Tất cả"
    final itemCount = widget.categories.length + 1;

    return SizedBox(
      height: 32,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final bool isAll = i == 0;
          final String label = isAll ? 'Tất cả' : widget.categories[i - 1];
          final bool active =
              isAll ? selected == null : selected == label;

          return InkWell(
            borderRadius: BorderRadius.circular(AppUtils.radius),
            onTap: () {
              setState(() {
                selected = isAll ? null : label;
              });
              widget.onSelected(selected);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: active
                    ? theme.colors.accent
                    : theme.colors.surface,
                borderRadius: BorderRadius.circular(AppUtils.radius),
                border: Border.all(
                  color: active
                      ? theme.colors.accent
                      : theme.colors.border,
                ),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: theme.colors.accent.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.text.body.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: active
                      ? Colors.white
                      : theme.colors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
