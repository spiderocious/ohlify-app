import 'package:flutter/material.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class AppFeedbackModal extends StatelessWidget {
  const AppFeedbackModal({
    super.key,
    required this.entry,
    required this.onDismiss,
  });

  final FeedbackModalEntry entry;
  final VoidCallback onDismiss;

  // ── Icon circle config per kind ───────────────────────────────────────────

  static const _circleColors = {
    ModalFeedbackKind.success: Color(0xFFDCFCE7), // light green ring bg
    ModalFeedbackKind.error: Color(0xFFFEE2E2),
    ModalFeedbackKind.warning: Color(0xFFFFF7ED),
    ModalFeedbackKind.info: Color(0xFFEFF6FF),
  };

  static const _circleBorderColors = {
    ModalFeedbackKind.success: AppColors.success,
    ModalFeedbackKind.error: AppColors.error,
    ModalFeedbackKind.warning: AppColors.warning,
    ModalFeedbackKind.info: AppColors.primary,
  };

  static const _defaultIcons = {
    ModalFeedbackKind.success: Icons.check_rounded,
    ModalFeedbackKind.error: Icons.close_rounded,
    ModalFeedbackKind.warning: Icons.priority_high_rounded,
    ModalFeedbackKind.info: Icons.info_outline_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final opts = entry.options;
    final kind = opts.kind;
    final borderColor = _circleBorderColors[kind]!;
    final circleBg = _circleColors[kind]!;

    final iconWidget = opts.icon ??
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: circleBg,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 3),
          ),
          child: Icon(
            _defaultIcons[kind]!,
            size: 36,
            color: borderColor,
          ),
        );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button
          if (opts.showCloseButton)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onDismiss,
                child: const Icon(
                  Icons.close_rounded,
                  size: 22,
                  color: AppColors.textMuted,
                ),
              ),
            ),

          if (opts.showCloseButton) const SizedBox(height: 4),

          // Icon
          iconWidget,
          const SizedBox(height: 20),

          // Title
          AppText(
            entry.title,
            variant: AppTextVariant.medium,
            align: TextAlign.center,
            weight: FontWeight.w700,
          ),
          const SizedBox(height: 8),

          // Message
          AppText(
            entry.message,
            variant: AppTextVariant.body,
            color: AppColors.textMuted,
            align: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Primary confirm button
          AppButton(
            label: opts.confirmButtonText,
            expanded: true,
            radius: 100,
            onPressed: onDismiss,
          ),

          // Optional secondary action
          if (opts.actionLabel != null) ...[
            const SizedBox(height: 10),
            AppButton(
              label: opts.actionLabel!,
              variant: AppButtonVariant.plain,
              expanded: true,
              radius: 100,
              onPressed: () {
                opts.onAction?.call();
                onDismiss();
              },
            ),
          ],
        ],
      ),
    );
  }
}
