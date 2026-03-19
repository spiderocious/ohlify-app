class ApiError implements Exception {
  const ApiError(this.statusCode, this.body);
  final int statusCode;
  final Map<String, dynamic> body;

  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;
  bool get isServerError => statusCode >= 500;

  String get message => body['message'] as String? ?? 'API error $statusCode';

  @override
  String toString() => 'ApiError($statusCode): $message';
}
