import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/services/drawer_service.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_otp_input/app_otp_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/screen_continue_bar/screen_continue_bar.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String _otp = '';

  // Resend countdown — 300 seconds
  static const _resendSeconds = 300;
  late int _secondsLeft;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _secondsLeft = _resendSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _countdownLabel {
    final mins = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final secs = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final canResend = _secondsLeft == 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppIconButton(
                      icon: const Icon(
                        AppIcons.back,
                        color: AppColors.textPrimary,
                        size: 18,
                      ),
                      variant: AppIconButtonVariant.outline,
                      size: 40,
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(height: 28),

                    Image.asset(
                      'assets/logos/logo-primary.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(height: 20),

                    const AppText(
                      'Authentication',
                      variant: AppTextVariant.bodyTitle,
                      align: TextAlign.start,
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 8),

                    const AppText(
                      'Enter the 6-six digit code sent to the email address or phone number you provided below.',
                      variant: AppTextVariant.body,
                      align: TextAlign.start,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 32),

                    AppOtpInput(
                      length: 6,
                      autoFocus: true,
                      onChanged: (v) => setState(() => _otp = v),
                      onComplete: (v) => setState(() => _otp = v),
                    ),
                    const SizedBox(height: 20),

                    // Resend row
                    Row(
                      children: [
                        const Text(
                          "Didn't get the code? ",
                          style: TextStyle(
                            fontFamily: 'MonaSans',
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                        GestureDetector(
                          onTap: canResend ? _startCountdown : null,
                          child: Text(
                            canResend
                                ? 'Resend code'
                                : 'Resend in $_countdownLabel',
                            style: TextStyle(
                              fontFamily: 'MonaSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: canResend
                                  ? AppColors.primary
                                  : AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          ScreenContinueBar(
            onPressed: _otp.length == 6
                ? () => DrawerService.instance.showFeedbackModal(
                      'Account Created Successfully',
                      'Great! Your account has been created. You can now proceed to log in with your details.',
                      options: FeedbackModalOptions(
                        kind: ModalFeedbackKind.success,
                        position: ModalPosition.fullscreen,
                        showCloseButton: false,
                        dismissible: false,
                        confirmButtonText: 'Continue',
                        onConfirm: () => context.pushReplacement(AppRoutes.roleSelection),
                      ),
                    )
                : null,
          ),
        ],
      ),
    );
  }
}
