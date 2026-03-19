import 'package:flutter/material.dart';

import 'package:ohlify/shared/notifiers/query_state.dart';
import 'package:ohlify/ui/widgets/app_error_state/app_error_state.dart';
import 'package:ohlify/ui/widgets/app_loader/app_loader.dart';

class AppQueryView<T> extends StatelessWidget {
  const AppQueryView({
    super.key,
    required this.state,
    required this.onSuccess,
    this.emptyCheck,
  });

  final QueryState<T> state;
  final Widget Function(T data) onSuccess;
  final bool Function(T data)? emptyCheck;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      QueryIdle() => const SizedBox.shrink(),
      QueryLoading() => const AppLoader(),
      QueryError(:final error) => AppErrorState(error: error),
      QuerySuccess(:final data) => emptyCheck?.call(data) == true
          ? const AppEmptyState()
          : onSuccess(data),
    };
  }
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({super.key, this.message = 'Nothing here yet.'});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
