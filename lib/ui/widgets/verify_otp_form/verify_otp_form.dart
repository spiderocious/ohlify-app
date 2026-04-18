import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_otp_input/app_otp_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class VerifyOtpForm extends StatefulWidget {
  const VerifyOtpForm({
    super.key,
    required this.channelHint,
    required this.onVerify,
    this.onResend,
    this.submitLabel = 'Verify',
    this.length = 6,
  });

  /// Human-readable hint (e.g. "We sent a 6-digit code to a***@gmail.com").
  final String channelHint;

  /// Called with the typed code when the user taps Verify.
  final ValueChanged<String> onVerify;

  final VoidCallback? onResend;
  final String submitLabel;
  final int length;

  @override
  State<VerifyOtpForm> createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  String _code = '';

  bool get _isComplete => _code.length == widget.length;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          widget.channelHint,
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 20),
        AppOtpInput(
          length: widget.length,
          onChanged: (v) => setState(() => _code = v),
          onComplete: (v) => setState(() => _code = v),
        ),
        if (widget.onResend != null) ...[
          const SizedBox(height: 14),
          GestureDetector(
            onTap: widget.onResend,
            behavior: HitTestBehavior.opaque,
            child: const AppText(
              'Resend code',
              variant: AppTextVariant.body,
              color: AppColors.primary,
              weight: FontWeight.w600,
              align: TextAlign.center,
            ),
          ),
        ],
        const SizedBox(height: 20),
        AppButton(
          label: widget.submitLabel,
          expanded: true,
          radius: 100,
          isDisabled: !_isComplete,
          onPressed: !_isComplete ? null : () => widget.onVerify(_code),
        ),
      ],
    );
  }
}
