import 'package:intl/intl.dart';

class AppUtils {
  static const double radius = 10;

  static String formatVnd(num value) {
    return NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    ).format(value);
  }
}
