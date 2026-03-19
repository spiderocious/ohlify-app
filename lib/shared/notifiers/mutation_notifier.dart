import 'package:flutter/foundation.dart';

import 'package:ohlify/shared/notifiers/query_cache.dart';

abstract class MutationNotifier<TInput, TResult> extends ChangeNotifier {
  MutationNotifier({required this.cache});
  final QueryCache cache;

  bool _isPending = false;
  Object? _error;
  TResult? _result;

  bool get isPending => _isPending;
  Object? get error => _error;
  TResult? get result => _result;

  Future<TResult> mutate(TInput input);

  void onSuccess(TResult result) {}

  Future<void> execute(TInput input) async {
    _isPending = true;
    _error = null;
    notifyListeners();
    try {
      _result = await mutate(input);
      onSuccess(_result as TResult);
    } catch (e) {
      _error = e;
    } finally {
      _isPending = false;
      notifyListeners();
    }
  }

  void reset() {
    _isPending = false;
    _error = null;
    _result = null;
    notifyListeners();
  }
}
