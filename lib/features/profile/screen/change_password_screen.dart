import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/profile/helpers/otp_gate.dart';
import 'package:ohlify/features/profile/screen/parts/password_rule_row.dart';
import 'package:ohlify/features/profile/screen/parts/profile_subscreen_scaffold.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _current = '';
  String _next = '';
  bool _showCurrent = false;
  bool _showNext = false;

  bool get _hasMinLength => _next.length >= 8;
  bool get _hasNumber => RegExp(r'\d').hasMatch(_next);
  bool get _hasSpecial => RegExp(r'[!@#$%^&*(),.?\":{}|<>\-_+=/\[\]`~]').hasMatch(_next);
  bool get _hasUpper => RegExp(r'[A-Z]').hasMatch(_next);

  bool get _isValid =>
      _current.isNotEmpty &&
      _hasMinLength &&
      _hasNumber &&
      _hasSpecial &&
      _hasUpper;

  void _onSubmit() {
    if (!_isValid) return;
    showOtpGate(
      channelHint:
          'We sent a 6-digit code to your email to confirm this password change.',
      onVerified: () {
        DrawerService.instance.toast(
          'Password updated',
          options: const ToastOptions(type: ToastType.success),
        );
        if (mounted) context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfileSubscreenScaffold(
      title: 'Change Password',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          AppTextInput(
            label: 'Current password',
            value: _current,
            placeholder: 'Old password',
            obscureText: !_showCurrent,
            endIcon: GestureDetector(
              onTap: () => setState(() => _showCurrent = !_showCurrent),
              child: Icon(
                _showCurrent
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: AppColors.textSlate,
              ),
            ),
            onChanged: (v) => setState(() => _current = v),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(child: Divider(color: AppColors.border)),
              SizedBox(width: 10),
              Icon(
                Icons.vpn_key_outlined,
                size: 14,
                color: AppColors.textMuted,
              ),
              SizedBox(width: 6),
              AppText(
                'New password',
                variant: AppTextVariant.bodyNormal,
                color: AppColors.textMuted,
                align: TextAlign.center,
              ),
              SizedBox(width: 10),
              Expanded(child: Divider(color: AppColors.border)),
            ],
          ),
          const SizedBox(height: 16),
          AppTextInput(
            label: 'New password',
            value: _next,
            placeholder: 'New password',
            obscureText: !_showNext,
            endIcon: GestureDetector(
              onTap: () => setState(() => _showNext = !_showNext),
              child: Icon(
                _showNext
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: AppColors.textSlate,
              ),
            ),
            onChanged: (v) => setState(() => _next = v),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              PasswordRuleRow(
                label: 'Minimum 8 characters',
                satisfied: _hasMinLength,
              ),
              PasswordRuleRow(label: 'Number', satisfied: _hasNumber),
              PasswordRuleRow(
                label: 'Special character (e.g., @&\$*)',
                satisfied: _hasSpecial,
              ),
              PasswordRuleRow(label: 'UPPERCASE letter', satisfied: _hasUpper),
            ],
          ),
        ],
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            label: 'Change password',
            expanded: true,
            radius: 100,
            isDisabled: !_isValid,
            onPressed: !_isValid ? null : _onSubmit,
          ),
          const SizedBox(height: 10),
          AppButton(
            label: 'Forgot password',
            variant: AppButtonVariant.outline,
            expanded: true,
            radius: 100,
            onPressed: () => context.push(AppRoutes.forgotPassword),
          ),
        ],
      ),
    );
  }
}
