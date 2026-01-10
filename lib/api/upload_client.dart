import 'package:http/http.dart' as http;

class UploadClient {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<http.StreamedResponse> multipart(
    String path,
    String method, {
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
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
