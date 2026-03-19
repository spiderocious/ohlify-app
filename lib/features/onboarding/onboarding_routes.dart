import 'package:go_router/go_router.dart';

import 'package:ohlify/features/onboarding/screen/onboarding_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final onboardingRoutes = [
  GoRoute(
    path: AppRoutes.onboarding,
    builder: (context, state) => const OnboardingScreen(),
  ),
];
