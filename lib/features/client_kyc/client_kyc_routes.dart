import 'package:go_router/go_router.dart';

import 'package:ohlify/features/client_kyc/providers/client_kyc_provider.dart';
import 'package:ohlify/features/client_kyc/screen/client_kyc_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final clientKycRoutes = [
  ShellRoute(
    builder: (context, state, child) => ClientKycProvider(child: child),
    routes: [
      GoRoute(
        path: AppRoutes.clientKyc,
        builder: (context, state) => const ClientKycScreen(),
      ),
    ],
  ),
];
