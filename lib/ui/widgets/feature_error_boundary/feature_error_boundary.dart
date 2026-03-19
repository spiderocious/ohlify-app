import 'package:flutter/material.dart';

import 'package:ohlify/ui/widgets/app_error_state/app_error_state.dart';

class FeatureErrorBoundary extends StatefulWidget {
  const FeatureErrorBoundary({
    super.key,
    required this.child,
    this.fallback,
  });
  final Widget child;
  final Widget? fallback;

  @override
  State<FeatureErrorBoundary> createState() => _FeatureErrorBoundaryState();
}

class _FeatureErrorBoundaryState extends State<FeatureErrorBoundary> {
  Object? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.fallback ??
          const AppErrorState(message: 'Something went wrong.');
    }
    return widget.child;
  }
}
