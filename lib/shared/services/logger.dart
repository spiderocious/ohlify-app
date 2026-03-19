import 'package:flutter/foundation.dart';

const _sensitiveKeys = {'password', 'token', 'bvn', 'nin', 'accountNumber', 'pan'};

Map<String, dynamic> _sanitize(Map<String, dynamic> ctx) =>
    Map.fromEntries(
      ctx.entries.where(
        (e) => !_sensitiveKeys.any((s) => e.key.toLowerCase().contains(s)),
      ),
    );

// ignore: camel_case_types
abstract final class logger {
  static void debug(String msg, [Map<String, dynamic>? ctx]) =>
      _log('DEBUG', msg, ctx);
  static void info(String msg, [Map<String, dynamic>? ctx]) =>
      _log('INFO', msg, ctx);
  static void warn(String msg, [Map<String, dynamic>? ctx]) =>
      _log('WARN', msg, ctx);
  static void error(String msg, [Map<String, dynamic>? ctx]) =>
      _log('ERROR', msg, ctx);

  static void _log(String level, String msg, Map<String, dynamic>? ctx) {
    final safe = ctx != null ? _sanitize(ctx) : <String, dynamic>{};
    if (kDebugMode) {
      debugPrint('[$level] $msg ${safe.isNotEmpty ? safe : ""}');
    }
    // Forward to Sentry / Datadog in production
  }
}
