import 'package:shop_food_app/api/api_client.dart';

class AuthApi {
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final res = await ApiClient.post<Map<String, dynamic>>(
      '/login',
      body: {
        'username': username,
        'password': password,
      },
      parser: (json) => json as Map<String, dynamic>,
    );

    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'Đăng nhập thất bại');
    }

    return res.data!;
  }
}
