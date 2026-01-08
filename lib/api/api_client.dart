import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(
      queryParameters: query?.map((k, v) => MapEntry(k, v.toString())),
    );
    return http.get(uri, headers: headers);
  }

  static Future<http.Response> delete(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    return http.delete(uri);
  }

  static Future<http.StreamedResponse> multipart(
    String path,
    String method,
    Map<String, String> fields,
    List<http.MultipartFile> files,
  ) async {
    final uri = Uri.parse('$baseUrl$path');
    final request = http.MultipartRequest(method, uri)
      ..fields.addAll(fields)
      ..files.addAll(files);

    return request.send();
  }
}
