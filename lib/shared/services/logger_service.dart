import 'package:flutter/foundation.dart';

// Sensitive keys are masked before logging — never log raw values of these.
const _sensitiveKeys = {
  'password',
  'token',
  'bvn',
  'nin',
  'accountNumber',
  'pan',
  'secret',
  'authorization',
};

abstract final class LoggerService {
  static void info(String message, [Map<String, dynamic>? context]) {
    if (kDebugMode) {
      debugPrint('[INFO] $message ${_sanitize(context)}');
    }
  }

  static void warn(String message, [Map<String, dynamic>? context]) {
    if (kDebugMode) {
      debugPrint('[WARN] $message ${_sanitize(context)}');
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message — $error');
      if (stackTrace != null) debugPrint(stackTrace.toString());
    }
  }

  static Map<String, dynamic> _sanitize(Map<String, dynamic>? context) {
    if (context == null) return {};
    return {
      for (final entry in context.entries)
        entry.key: _sensitiveKeys.contains(entry.key.toLowerCase())
            ? '***'
            : entry.value,
    };
  }
}
