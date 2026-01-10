class ApiResponse<T> {
  final int statusCode;
  final T? data;
  final dynamic raw;
  final String? message;

  ApiResponse({
    required this.statusCode,
    this.data,
    this.raw,
    this.message,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}
