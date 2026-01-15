import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_food_app/api/api_response.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:8080/api';

  // =========================
  // HEADER CHUNG (CÓ TOKEN)
  // =========================
  static Future<Map<String, String>> _defaultHeaders({
    Map<String, String>? extra,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty)
        'Authorization': 'Bearer $token', // ✅ QUAN TRỌNG
      ...?extra,
    };
  }

  // =========================
  // GET
  // =========================
  static Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    T Function(dynamic json)? parser,
  }) async {
    final uri = Uri.parse(
      '$baseUrl$path',
    ).replace(queryParameters: query?.map((k, v) => MapEntry(k, v.toString())));

    final res = await http.get(
      uri,
      headers: await _defaultHeaders(extra: headers),
    );

    return _handleResponse(res, parser);
  }

  // =========================
  // POST
  // =========================
  static Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(dynamic json)? parser,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    final res = await http.post(
      uri,
      headers: await _defaultHeaders(extra: headers),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(res, parser);
  }

  // =========================
  // PUT
  // =========================
  static Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(dynamic json)? parser,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    final res = await http.put(
      uri,
      headers: await _defaultHeaders(extra: headers),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(res, parser);
  }

  // =========================
  // PATCH
  // =========================
  static Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(dynamic json)? parser,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    final res = await http.patch(
      uri,
      headers: await _defaultHeaders(extra: headers),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(res, parser);
  }

  // =========================
  // DELETE
  // =========================
  static Future<ApiResponse<T>> delete<T>(
    String path, {
    Map<String, String>? headers,
    T Function(dynamic json)? parser,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    final res = await http.delete(
      uri,
      headers: await _defaultHeaders(extra: headers),
    );

    return _handleResponse(res, parser);
  }

  // =========================
  // HANDLE RESPONSE
  // =========================
  static ApiResponse<T> _handleResponse<T>(
    http.Response res,
    T Function(dynamic json)? parser,
  ) {
    final raw = res.body.isNotEmpty ? jsonDecode(res.body) : null;

    return ApiResponse<T>(
      statusCode: res.statusCode,
      raw: raw,
      data: parser != null && raw != null ? parser(raw) : null,
      message: raw is Map ? raw['message'] : null,
    );
  }
}
