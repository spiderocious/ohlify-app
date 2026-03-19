import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_phone_input/app_phone_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';
import 'package:ohlify/ui/widgets/screen_continue_bar/screen_continue_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _phone = '';
  String _email = '';

  static final _emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$');

  bool get _emailValid => _emailRegex.hasMatch(_email);
  bool get _isValid => _phone.length >= 10 && _emailValid;

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
                    // Back button
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

                    // Logo icon
                    Image.asset(
                      'assets/logos/logo-primary.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(height: 20),

                    // Title
                    const AppText(
                      'Create an account',
                      variant: AppTextVariant.bodyTitle,
                      align: TextAlign.start,
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    const AppText(
                      'Create an account with your phone number or email address below.',
                      variant: AppTextVariant.body,
                      align: TextAlign.start,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 28),

                    // Phone input
                    AppPhoneInput(
                      placeholder: '808 123 4567',
                      value: _phone,
                      onChanged: (v) => setState(() => _phone = v),
                    ),
                    const SizedBox(height: 16),

                    // Email input
                    AppTextInput(
                      label: 'Email address',
                      placeholder: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      errorMessage: _email.isNotEmpty && !_emailValid
                          ? 'Please enter a valid email address.'
                          : null,
                      onChanged: (v) => setState(() => _email = v),
                    ),
                    const SizedBox(height: 20),

                    // Terms & conditions
                    _TermsText(),
                  ],
                ),
              ),
            ),
          ),

          ScreenContinueBar(
            onPressed: _isValid
                ? () => context.push(AppRoutes.createPassword)
                : null,
          ),
        ],
      ),
    );
  }
}

class _TermsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'MonaSans',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textMuted,
          height: 1.6,
        ),
        children: [
          const TextSpan(text: 'By clicking "Continue", you agree to our '),
          TextSpan(
            text: 'Terms and Conditions',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: open terms
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: open privacy policy
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
