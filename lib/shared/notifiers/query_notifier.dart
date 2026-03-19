import 'package:flutter/foundation.dart';

import 'package:ohlify/shared/notifiers/query_cache.dart';
import 'package:ohlify/shared/notifiers/query_state.dart';
import 'package:ohlify/shared/types/api_error.dart';

export 'package:ohlify/shared/notifiers/query_state.dart';

abstract class QueryNotifier<T> extends ChangeNotifier {
  QueryNotifier({
    required this.queryKey,
    required this.cache,
    this.staleTime = const Duration(minutes: 5),
    this.retryCount = 2,
  });

  final String queryKey;
  final QueryCache cache;
  final Duration staleTime;
  final int retryCount;

  QueryState<T> _state = const QueryIdle();
  QueryState<T> get state => _state;

  Future<T> fetch();

  Future<void> execute({bool force = false}) async {
    if (!force && !cache.isStale(queryKey, staleTime)) {
      final cached = cache.get(queryKey);
      if (cached != null) {
        _state = QuerySuccess(cached as T);
        notifyListeners();
        return;
      }
    }

    _state = const QueryLoading();
    notifyListeners();

    int attempts = 0;
    while (attempts <= retryCount) {
      try {
        final data = await fetch();
        cache.set(queryKey, data);
        _state = QuerySuccess(data);
        notifyListeners();
        return;
      } catch (e) {
        attempts++;
        if (e is ApiError && e.isUnauthorized) break;
        if (attempts > retryCount) {
          _state = QueryError(e);
          notifyListeners();
          return;
        }
        await Future<void>.delayed(Duration(milliseconds: 300 * attempts));
      }
    }
  }
}
