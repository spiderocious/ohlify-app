import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/notifications/providers/notifications_notifier.dart';

class NotificationsProvider extends StatelessWidget {
  const NotificationsProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationsNotifier>(
      create: (_) => NotificationsNotifier(),
      child: child,
    );
  }
}

extension NotificationsContext on BuildContext {
  NotificationsNotifier get notifications {
    try {
      return read<NotificationsNotifier>();
    } catch (_) {
      throw StateError(
        'notifications accessed outside NotificationsProvider',
      );
    }
  }
}
