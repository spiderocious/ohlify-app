import 'package:go_router/go_router.dart';

import 'package:ohlify/features/splash/screen/splash_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final splashRoutes = [
  GoRoute(
    path: AppRoutes.root,
    builder: (context, state) => const SplashScreen(),
  ),
];
