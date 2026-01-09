import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'http://localhost:8080/api';

  // =========================
  // GET
  // =========================
  static Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(
      queryParameters: query?.map(
        (k, v) => MapEntry(k, v.toString()),
      ),
    );

    return http.get(uri, headers: headers);
  }

  // =========================
  // POST (JSON)
  // =========================
  static Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    return http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // =========================
  // PUT (JSON)
  // =========================
  static Future<http.Response> put(
    String path, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    return http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // =========================
  // PATCH (JSON)
  // =========================
  static Future<http.Response> patch(
    String path, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    return http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // =========================
  // DELETE
  // =========================
  static Future<http.Response> delete(
    String path, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    return http.delete(uri, headers: headers);
  }

  // =========================
  // MULTIPART (UPLOAD)
  // =========================
  static Future<http.StreamedResponse> multipart(
    String path,
    String method,
    Map<String, String> fields,
    List<http.MultipartFile> files, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$path');

    final request = http.MultipartRequest(method, uri)
      ..fields.addAll(fields)
      ..files.addAll(files);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    return request.send();
  }
}
