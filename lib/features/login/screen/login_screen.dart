import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';
import 'package:ohlify/ui/widgets/screen_continue_bar/screen_continue_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool _obscurePassword = true;
  bool _rememberMe = false;

  bool get _isValid => _email.isNotEmpty && _password.isNotEmpty;

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
                      'Log into your account',
                      variant: AppTextVariant.bodyTitle,
                      align: TextAlign.start,
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 8),

                    const AppText(
                      'Sign in to your account with your phone number or email address.',
                      variant: AppTextVariant.body,
                      align: TextAlign.start,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 28),

                    AppTextInput(
                      label: 'Email address',
                      placeholder: 'Adedeji@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (v) => setState(() => _email = v),
                    ),
                    const SizedBox(height: 16),

                    AppTextInput(
                      label: 'Password',
                      placeholder: 'Enter preferred password',
                      obscureText: _obscurePassword,
                      onChanged: (v) => setState(() => _password = v),
                      endIcon: GestureDetector(
                        onTap: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                        child: Icon(
                          _obscurePassword ? AppIcons.eyeOff : AppIcons.eye,
                          size: 18,
                          color: AppColors.textSlate,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        _RememberMeToggle(
                          value: _rememberMe,
                          onChanged: (v) => setState(() => _rememberMe = v),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            fontFamily: 'MonaSans',
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.forgotPassword),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontFamily: 'MonaSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
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
            label: 'Login',
            onPressed: _isValid
                ? () {
                    // TODO: perform login
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class _RememberMeToggle extends StatelessWidget {
  const _RememberMeToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 20,
        decoration: BoxDecoration(
          color: value ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(100),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(2),
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
