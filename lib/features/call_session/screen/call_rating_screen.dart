import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_area_input/app_text_area_input.dart';

/// Shown after a call ends and feedback is submitted. Asks the user to rate
/// the professional they spoke to. Skippable.
class CallRatingScreen extends StatefulWidget {
  const CallRatingScreen({
    super.key,
    required this.peerName,
    required this.peerAvatarUrl,
  });

  final String peerName;
  final String? peerAvatarUrl;

  @override
  State<CallRatingScreen> createState() => _CallRatingScreenState();
}

class _CallRatingScreenState extends State<CallRatingScreen> {
  int _stars = 0;
  String _comment = '';

  void _submit() {
    DrawerService.instance.toast(
      'Thanks for rating ${widget.peerName}',
      options: const ToastOptions(type: ToastType.success),
    );
    _exit();
  }

  void _exit() {
    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  AppIconButton(
                    icon: const Icon(AppIcons.back, color: AppColors.textJet),
                    variant: AppIconButtonVariant.ghost,
                    backgroundColor: AppColors.surfaceLight,
                    size: 44,
                    iconSize: 20,
                    onPressed: _exit,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _exit,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: AppText(
                        'Not now',
                        variant: AppTextVariant.body,
                        color: AppColors.textMuted,
                        weight: FontWeight.w500,
                        align: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppText(
                      'Rate this call',
                      variant: AppTextVariant.title,
                      color: AppColors.textJet,
                      weight: FontWeight.w800,
                      align: TextAlign.start,
                    ),
                    const SizedBox(height: 6),
                    AppText(
                      'How was your conversation with ${widget.peerName}?',
                      variant: AppTextVariant.body,
                      color: AppColors.textMuted,
                      align: TextAlign.start,
                    ),
                    const SizedBox(height: 24),
                    _StarRow(
                      value: _stars,
                      onChanged: (v) => setState(() => _stars = v),
                    ),
                    const SizedBox(height: 24),
                    const AppText(
                      'Leave a comment (optional)',
                      variant: AppTextVariant.bodyNormal,
                      color: AppColors.textMuted,
                      align: TextAlign.start,
                    ),
                    const SizedBox(height: 8),
                    AppTextAreaInput(
                      value: _comment,
                      placeholder:
                          'Share what you liked, or how they could improve…',
                      maxLength: 500,
                      onChanged: (v) => setState(() => _comment = v),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: AppButton(
                label: 'Submit rating',
                expanded: true,
                radius: 100,
                isDisabled: _stars == 0,
                onPressed: _stars == 0 ? null : _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () => onChanged(i),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Icon(
                i <= value ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 40,
                color: i <= value ? const Color(0xFFF5A623) : AppColors.border,
              ),
            ),
          ),
      ],
    );
  }
}
