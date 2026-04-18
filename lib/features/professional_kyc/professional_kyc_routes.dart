import 'package:go_router/go_router.dart';

import 'package:ohlify/features/professional_kyc/providers/professional_kyc_provider.dart';
import 'package:ohlify/features/professional_kyc/screen/professional_kyc_rates_screen.dart';
import 'package:ohlify/features/professional_kyc/screen/professional_kyc_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final professionalKycRoutes = [
  ShellRoute(
    builder: (context, state, child) =>
        ProfessionalKycProvider(child: child),
    routes: [
      GoRoute(
        path: AppRoutes.professionalKyc,
        builder: (context, state) => const ProfessionalKycScreen(),
        routes: [
          GoRoute(
            path: 'rates',
            builder: (context, state) => const ProfessionalKycRatesScreen(),
          ),
        ],
      ),
    ],
  ),
];
