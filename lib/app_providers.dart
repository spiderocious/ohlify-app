import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/query_cache.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/drawer_service.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Global query cache (shared across all QueryNotifiers)
        ChangeNotifierProvider<QueryCache>.value(value: QueryCache.instance),
        // Toast / drawer state
        ChangeNotifierProvider<ToastNotifier>(
          create: (_) {
            final notifier = ToastNotifier();
            DrawerService.instance.init(notifier);
            return notifier;
          },
        ),
        ChangeNotifierProvider<ModalNotifier>(
          create: (_) {
            final notifier = ModalNotifier();
            DrawerService.instance.initModal(notifier);
            return notifier;
          },
        ),
        // Feature-level providers are registered in their own provider files
        // and composed into the router shell — not globally here.
      ],
      child: child,
    );
  }
}
