import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/profile/helpers/otp_gate.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';

/// Two-step delete flow: destructive confirmation modal → OTP gate → route
/// back to the app entry point. Safe to call from any profile sub-screen.
void startDeleteAccountFlow(
  BuildContext context, {
  required String emailForOtp,
}) {
  var confirmed = false;
  final handle = DrawerService.instance.showConfirmationModal(
    'Delete account?',
    'Your profile, rates, call history, and wallet balance will be permanently removed. This action cannot be undone.',
    options: ConfirmationModalOptions(
      kind: ModalConfirmationKind.error,
      destructive: true,
      confirmButtonText: 'Yes, delete my account',
      cancelButtonText: 'Keep account',
      onConfirm: () => confirmed = true,
    ),
  );

  handle.onDismissed.then((_) {
    if (!confirmed) return;
    showOtpGate(
      channelHint:
          'We sent a 6-digit code to $emailForOtp to confirm account deletion.',
      onVerified: () {
        DrawerService.instance.toast(
          'Account deleted',
          options: const ToastOptions(type: ToastType.success),
        );
        if (context.mounted) context.go(AppRoutes.onboarding);
      },
    );
  });
}
