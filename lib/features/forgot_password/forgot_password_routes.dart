import 'package:go_router/go_router.dart';

import 'package:ohlify/features/forgot_password/screen/forgot_password_screen.dart';
import 'package:ohlify/features/forgot_password/screen/forgot_password_verify_otp_screen.dart';
import 'package:ohlify/features/forgot_password/screen/reset_password_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final forgotPasswordRoutes = [
  GoRoute(
    path: AppRoutes.forgotPassword,
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
  GoRoute(
    path: AppRoutes.forgotPasswordVerifyOtp,
    builder: (context, state) => ForgotPasswordVerifyOtpScreen(
      email: state.extra as String,
    ),
  ),
  GoRoute(
    path: AppRoutes.resetPassword,
    builder: (context, state) => const ResetPasswordScreen(),
  ),
];
