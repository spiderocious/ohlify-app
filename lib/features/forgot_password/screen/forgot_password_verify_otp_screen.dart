import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_otp_input/app_otp_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/screen_continue_bar/screen_continue_bar.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key, required this.email});

  final String email;

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState
    extends State<ForgotPasswordVerifyOtpScreen> {
  String _otp = '';

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

  /// Masks email: ade**ji@gmail.com
  String get _maskedEmail {
    final parts = widget.email.split('@');
    if (parts.length != 2) return widget.email;
    final name = parts[0];
    if (name.length <= 4) return widget.email;
    final masked =
        '${name.substring(0, 3)}**${name.substring(name.length - 2)}';
    return '$masked@${parts[1]}';
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
                    Row(
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
                        const Expanded(
                          child: Text(
                            'Verification',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'MonaSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 32),

                    AppText(
                      'Please enter the 6-digit OTP we sent to $_maskedEmail',
                      variant: AppTextVariant.bodyTitle,
                      align: TextAlign.start,
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 32),

                    AppOtpInput(
                      length: 6,
                      autoFocus: true,
                      onChanged: (v) => setState(() => _otp = v),
                      onComplete: (v) => setState(() => _otp = v),
                    ),
                    const SizedBox(height: 20),

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
                ? () => context.push(AppRoutes.resetPassword)
                : null,
          ),
        ],
      ),
    );
  }
}
