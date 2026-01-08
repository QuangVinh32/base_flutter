import 'package:flutter/material.dart';
import 'package:shop_food_app/component/custom_icon_button.dart';
import 'package:shop_food_app/component/custom_text_field.dart';
import 'package:shop_food_app/library/app_text_sizes.dart';
import 'package:shop_food_app/theme/app_theme.dart';

class Header extends StatefulWidget {
  final bool showMenu;
  final VoidCallback? onMenuTap;

  const Header({super.key, this.showMenu = false, this.onMenuTap});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final canBack = Navigator.of(context).canPop();

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: theme.colors.bgSecondary,
        border: Border(bottom: BorderSide(color: theme.colors.border)),
      ),
      child: Row(
        children: [
          CustomIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.of(context).maybePop(),
          ),

          if (!canBack && widget.showMenu)
            CustomIconButton(icon: Icons.menu, onTap: widget.onMenuTap),

          const SizedBox(width: 8),
          const Spacer(),

          SizedBox(
            width: 200,
            child: CustomTextField(
              theme: theme,
              hintText: "Search",
              prefixIcon: Icons.search,
              fontSize: AppTextSizes.h6,
              suffixIcon: Icons.clear,
              controller: searchController,
              borderColor: theme.colors.border,
              focusedBorderColor: theme.colors.accent,
              onSuffixTap: () {
                searchController.clear();
              },
              onChanged: (value) {
                print("Search: $value");
              },
            ),
          ),
        ],
      ),
    );
  }
}
