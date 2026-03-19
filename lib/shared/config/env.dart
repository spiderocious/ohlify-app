import 'package:flutter_dotenv/flutter_dotenv.dart';

String _require(String key) {
  final value = dotenv.env[key];
  if (value == null || value.isEmpty) {
    throw StateError('Missing required environment variable: $key');
  }
  return value;
}

abstract final class Env {
  static final apiBaseUrl = _require('API_BASE_URL');
  static final appEnv = dotenv.env['APP_ENV'] ?? 'development';
}
