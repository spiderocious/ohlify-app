import 'package:go_router/go_router.dart';

import 'package:ohlify/features/register/screen/create_password_screen.dart';
import 'package:ohlify/features/register/screen/register_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final registerRoutes = [
  GoRoute(
    path: AppRoutes.register,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: AppRoutes.createPassword,
    builder: (context, state) => const CreatePasswordScreen(),
  ),
];
