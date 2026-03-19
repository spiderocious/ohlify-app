import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input.dart';
import 'package:ohlify/ui/widgets/screen_continue_bar.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  String _password = '';
  String _confirm = '';
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  bool get _hasMinLength => _password.length >= 8;
  bool get _hasNumber => RegExp(r'\d').hasMatch(_password);
  bool get _hasSpecial => RegExp(r'[!@#\$%^&*(),.?":{}|<>@&$*]').hasMatch(_password);
  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_password);
  bool get _passwordsMatch => _password.isNotEmpty && _password == _confirm;

  bool get _isValid =>
      _hasMinLength && _hasNumber && _hasSpecial && _hasUppercase && _passwordsMatch;

  @override
  Widget build(BuildContext context) {
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
                      'Create password',
                      variant: AppTextVariant.bodyTitle,
                      align: TextAlign.start,
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 8),

                    const AppText(
                      'Create a password to secure your account',
                      variant: AppTextVariant.body,
                      align: TextAlign.start,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 28),

                    AppTextInput(
                      label: 'Password',
                      placeholder: 'Enter preferred password',
                      obscureText: _obscurePassword,
                      onChanged: (v) => setState(() => _password = v),
                      endIcon: GestureDetector(
                        onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                        child: Icon(
                          _obscurePassword ? AppIcons.eyeOff : AppIcons.eye,
                          size: 18,
                          color: AppColors.textSlate,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    AppTextInput(
                      label: 'Confirm password',
                      placeholder: 'Enter preferred password',
                      obscureText: _obscureConfirm,
                      onChanged: (v) => setState(() => _confirm = v),
                      errorMessage: _confirm.isNotEmpty && !_passwordsMatch
                          ? 'Passwords do not match'
                          : null,
                      endIcon: GestureDetector(
                        onTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        child: Icon(
                          _obscureConfirm ? AppIcons.eyeOff : AppIcons.eye,
                          size: 18,
                          color: AppColors.textSlate,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    _PasswordRules(
                      hasMinLength: _hasMinLength,
                      hasNumber: _hasNumber,
                      hasSpecial: _hasSpecial,
                      hasUppercase: _hasUppercase,
                    ),
                  ],
                ),
              ),
            ),
          ),

          ScreenContinueBar(
            onPressed: _isValid
                ? () => context.push(AppRoutes.verifyOtp)
                : null,
          ),
        ],
      ),
    );
  }
}

class _PasswordRules extends StatelessWidget {
  const _PasswordRules({
    required this.hasMinLength,
    required this.hasNumber,
    required this.hasSpecial,
    required this.hasUppercase,
  });

  final bool hasMinLength;
  final bool hasNumber;
  final bool hasSpecial;
  final bool hasUppercase;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        _RuleChip(label: 'Minimum 8 characters', met: hasMinLength),
        _RuleChip(label: 'Number', met: hasNumber),
        _RuleChip(label: 'Special character (e.g., @&\$*)', met: hasSpecial),
        _RuleChip(label: 'UPPERCASE letter', met: hasUppercase),
      ],
    );
  }
}

class _RuleChip extends StatelessWidget {
  const _RuleChip({required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: met ? AppColors.success.withValues(alpha: 0.12) : AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              AppIcons.check,
              size: 14,
              color: met ? AppColors.success : AppColors.textSlate,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: met ? AppColors.textPrimary : AppColors.textSlate,
            ),
          ),
        ],
      ),
    );
  }
}
