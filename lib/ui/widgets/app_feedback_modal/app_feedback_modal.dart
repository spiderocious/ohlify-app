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
    this.isFullscreen = false,
  });

  final FeedbackModalEntry entry;
  final VoidCallback onDismiss;
  final bool isFullscreen;

  // ── Icon circle config per kind ───────────────────────────────────────────

  static const _circleColors = {
    ModalFeedbackKind.success: Color(0xFFDCFCE7),
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

  Widget _buildIconCircle(ModalFeedbackKind kind) {
    final borderColor = _circleBorderColors[kind]!;
    final circleBg = _circleColors[kind]!;
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: circleBg,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 3),
      ),
      child: Icon(_defaultIcons[kind]!, size: 36, color: borderColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final opts = entry.options;
    final iconWidget = opts.icon ?? _buildIconCircle(opts.kind);

    if (isFullscreen) {
      return _FullscreenFeedback(
        entry: entry,
        onDismiss: onDismiss,
        iconWidget: iconWidget,
      );
    }

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
            onPressed: () {
              opts.onConfirm?.call();
              onDismiss();
            },
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

class _FullscreenFeedback extends StatelessWidget {
  const _FullscreenFeedback({
    required this.entry,
    required this.onDismiss,
    required this.iconWidget,
  });

  final FeedbackModalEntry entry;
  final VoidCallback onDismiss;
  final Widget iconWidget;

  @override
  Widget build(BuildContext context) {
    final opts = entry.options;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.background,
      child: SafeArea(
        child: Stack(
          children: [
            // Close button — pinned top-right
            if (opts.showCloseButton)
              Positioned(
                top: 16,
                right: 24,
                child: GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 24,
                    color: AppColors.textMuted,
                  ),
                ),
              ),

            // Centered content
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWidget,
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: AppText(
                      entry.title,
                      variant: AppTextVariant.medium,
                      align: TextAlign.center,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: AppText(
                      entry.message,
                      variant: AppTextVariant.body,
                      color: AppColors.textMuted,
                      align: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // Button pinned to bottom
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    label: opts.confirmButtonText,
                    expanded: true,
                    radius: 100,
                    onPressed: () {
                      opts.onConfirm?.call();
                      onDismiss();
                    },
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
