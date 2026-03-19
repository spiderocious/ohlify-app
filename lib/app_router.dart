import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';

// Global navigator key — used by interceptors to redirect without context
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: AppRoutes.root,
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Page not found: ${state.uri}')),
  ),
  routes: [
    GoRoute(
      path: AppRoutes.root,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Ohlify')),
      ),
    ),
    // Feature routes are added here as the app grows
  ],
);
