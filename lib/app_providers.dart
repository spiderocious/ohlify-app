import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/shared/notifiers/query_cache.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Global query cache (shared across all QueryNotifiers)
        ChangeNotifierProvider<QueryCache>.value(value: QueryCache.instance),
        // Feature-level providers are registered in their own provider files
        // and composed into the router shell — not globally here.
      ],
      child: child,
    );
  }
}
