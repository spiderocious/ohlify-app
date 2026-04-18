import 'package:go_router/go_router.dart';

import 'package:ohlify/features/notifications/screen/notifications_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final notificationsRoutes = [
  GoRoute(
    path: AppRoutes.notifications,
    builder: (context, state) => const NotificationsScreen(),
  ),
];
