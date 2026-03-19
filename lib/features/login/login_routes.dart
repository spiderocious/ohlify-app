import 'package:go_router/go_router.dart';

import 'package:ohlify/features/login/screen/login_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final loginRoutes = [
  GoRoute(
    path: AppRoutes.login,
    builder: (context, state) => const LoginScreen(),
  ),
];
