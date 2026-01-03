import 'package:flutter/widgets.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme extends InheritedWidget {
  final AppColors colors;
  final AppText text;

   AppTheme({
    super.key,
    required this.colors,
    required super.child,
  }) : text = AppText(colors);

  static AppTheme of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'AppTheme not found');
    return theme!;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) =>
      colors != oldWidget.colors;
}
