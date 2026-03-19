import 'package:flutter/foundation.dart';

class QueryCache extends ChangeNotifier {
  QueryCache._();
  static final instance = QueryCache._();

  final _cache = <String, ({Object? data, DateTime fetchedAt})>{};
  final _invalidated = <String>{};

  bool isStale(String key, Duration staleTime) {
    if (_invalidated.contains(key)) return true;
    final entry = _cache[key];
    if (entry == null) return true;
    return DateTime.now().difference(entry.fetchedAt) > staleTime;
  }

  void set(String key, Object? data) {
    _invalidated.remove(key);
    _cache[key] = (data: data, fetchedAt: DateTime.now());
    notifyListeners();
  }

  Object? get(String key) => _cache[key]?.data;

  void invalidate(String key) {
    _invalidated.add(key);
    notifyListeners();
  }

  void invalidatePrefix(String prefix) {
    final keys = _cache.keys.where((k) => k.startsWith(prefix)).toList();
    _invalidated.addAll(keys);
    notifyListeners();
  }

  void invalidateAll() {
    _invalidated.addAll(_cache.keys);
    notifyListeners();
  }
}
