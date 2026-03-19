import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';
import 'package:ohlify/ui/widgets/screen_continue_bar/screen_continue_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email = '';

  static final _emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$');

  bool get _emailValid => _emailRegex.hasMatch(_email);

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
                            'Forgot Password',
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

                    const AppText(
                      'Provide the credentials below to get started.',
                      variant: AppTextVariant.bodyTitle,
                      align: TextAlign.start,
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 28),

                    AppTextInput(
                      label: 'Email',
                      placeholder: 'Ex. you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      errorMessage: _email.isNotEmpty && !_emailValid
                          ? 'Please enter a valid email address.'
                          : null,
                      onChanged: (v) => setState(() => _email = v),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ScreenContinueBar(
            onPressed: _emailValid
                ? () => context.push(
                      AppRoutes.forgotPasswordVerifyOtp,
                      extra: _email,
                    )
                : null,
          ),
        ],
      ),
    );
  }
}
