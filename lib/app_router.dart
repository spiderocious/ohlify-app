import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/call_details/call_details_routes.dart';
import 'package:ohlify/features/call_session/call_session_routes.dart';
import 'package:ohlify/features/calls/screen/calls_screen.dart';
import 'package:ohlify/features/client_kyc/client_kyc_routes.dart';
import 'package:ohlify/features/component_preview/component_preview_routes.dart';
import 'package:ohlify/features/forgot_password/forgot_password_routes.dart';
import 'package:ohlify/features/home/screen/home_screen.dart';
import 'package:ohlify/features/login/login_routes.dart';
import 'package:ohlify/features/notifications/notifications_routes.dart';
import 'package:ohlify/features/onboarding/onboarding_routes.dart';
import 'package:ohlify/features/professional_details/professional_details_routes.dart';
import 'package:ohlify/features/professional_kyc/professional_kyc_routes.dart';
import 'package:ohlify/features/professional_search/professional_search_routes.dart';
import 'package:ohlify/features/role_selection/role_selection_routes.dart';
import 'package:ohlify/features/profile/profile_routes.dart';
import 'package:ohlify/features/profile/screen/profile_screen.dart';
import 'package:ohlify/features/register/register_routes.dart';
import 'package:ohlify/features/schedule_call/schedule_call_routes.dart';
import 'package:ohlify/features/splash/splash_routes.dart';
import 'package:ohlify/features/wallet/screen/wallet_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/widgets/app_shell/app_shell.dart';

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
    ...onboardingRoutes,
    ...registerRoutes,
    ...loginRoutes,
    ...forgotPasswordRoutes,
    ...scheduleCallRoutes,
    ...professionalDetailsRoutes,
    ...professionalSearchRoutes,
    ...callDetailsRoutes,
    ...callSessionRoutes,
    ...roleSelectionRoutes,
    ...professionalKycRoutes,
    ...clientKycRoutes,
    ...notificationsRoutes,
    ...profileSubscreenRoutes,
    ...componentPreviewRoutes,

    // ── Main app shell (persistent bottom nav) ─────────────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.calls,
              builder: (context, state) => const CallsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.wallet,
              builder: (context, state) => const WalletScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
