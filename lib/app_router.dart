import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/component_preview/component_preview_routes.dart';
import 'package:ohlify/features/splash/splash_routes.dart';

// Global navigator key — used by interceptors to redirect without context
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Page not found: ${state.uri}')),
  ),
  routes: [
    ...splashRoutes,
    ...componentPreviewRoutes,
    // Feature routes are added here as the app grows
  ],
);
