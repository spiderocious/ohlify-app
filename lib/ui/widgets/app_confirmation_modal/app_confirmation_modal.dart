import 'package:flutter/material.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class AppConfirmationModal extends StatelessWidget {
  const AppConfirmationModal({
    super.key,
    required this.entry,
    required this.onDismiss,
    this.isFullscreen = false,
  });

  final ConfirmationModalEntry entry;
  final VoidCallback onDismiss;
  final bool isFullscreen;

  // ── Icon circle config per kind ───────────────────────────────────────────

  static const _circleColors = {
    ModalConfirmationKind.neutral: Color(0xFFF3F4F6),
    ModalConfirmationKind.success: Color(0xFFDCFCE7),
    ModalConfirmationKind.error: Color(0xFFFEE2E2),
    ModalConfirmationKind.warning: Color(0xFFFFF7ED),
    ModalConfirmationKind.info: Color(0xFFEFF6FF),
  };

  static const _circleBorderColors = {
    ModalConfirmationKind.neutral: AppColors.border,
    ModalConfirmationKind.success: AppColors.success,
    ModalConfirmationKind.error: AppColors.error,
    ModalConfirmationKind.warning: AppColors.warning,
    ModalConfirmationKind.info: AppColors.primary,
  };

  static const _defaultIcons = {
    ModalConfirmationKind.neutral: Icons.help_outline_rounded,
    ModalConfirmationKind.success: Icons.check_rounded,
    ModalConfirmationKind.error: Icons.close_rounded,
    ModalConfirmationKind.warning: Icons.priority_high_rounded,
    ModalConfirmationKind.info: Icons.info_outline_rounded,
  };

  Widget _buildIcon(ModalConfirmationKind kind) {
    final borderColor = _circleBorderColors[kind]!;
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: _circleColors[kind]!,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 3),
      ),
      child: Icon(_defaultIcons[kind]!, size: 36, color: borderColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final opts = entry.options;

    // Resolve icon: custom > typed > none
    final Widget? iconWidget =
        opts.icon ?? (opts.showIcon ? _buildIcon(opts.kind) : null);

    if (isFullscreen) {
      return _FullscreenConfirmation(
        entry: entry,
        onDismiss: onDismiss,
        iconWidget: iconWidget,
        buildDestructiveButton: _buildDestructiveButton,
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
                onTap: () {
                  opts.onCancel?.call();
                  onDismiss();
                },
                child: const Icon(
                  Icons.close_rounded,
                  size: 22,
                  color: AppColors.textMuted,
                ),
              ),
            ),

          if (opts.showCloseButton) const SizedBox(height: 4),

          // Icon circle
          if (iconWidget != null) ...[
            iconWidget,
            const SizedBox(height: 20),
          ],

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

          // Confirm button — danger style when destructive
          if (opts.destructive)
            _buildDestructiveButton(
              label: opts.confirmButtonText,
              isLoading: opts.isLoading,
              onPressed: () {
                opts.onConfirm?.call();
                if (!opts.isLoading) onDismiss();
              },
            )
          else
            AppButton(
              label: opts.confirmButtonText,
              expanded: true,
              radius: 100,
              isLoading: opts.isLoading,
              onPressed: () {
                opts.onConfirm?.call();
                if (!opts.isLoading) onDismiss();
              },
            ),

          // Cancel button
          if (opts.showCancelButton) ...[
            const SizedBox(height: 10),
            AppButton(
              label: opts.cancelButtonText,
              variant: AppButtonVariant.outline,
              expanded: true,
              radius: 100,
              onPressed: () {
                opts.onCancel?.call();
                onDismiss();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDestructiveButton({
    required String label,
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return _DestructiveButton(
      label: label,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}

class _FullscreenConfirmation extends StatelessWidget {
  const _FullscreenConfirmation({
    required this.entry,
    required this.onDismiss,
    required this.iconWidget,
    required this.buildDestructiveButton,
  });

  final ConfirmationModalEntry entry;
  final VoidCallback onDismiss;
  final Widget? iconWidget;
  final Widget Function({
    required String label,
    required bool isLoading,
    required VoidCallback onPressed,
  }) buildDestructiveButton;

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
                  onTap: () {
                    opts.onCancel?.call();
                    onDismiss();
                  },
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
                  if (iconWidget != null) ...[
                    iconWidget!,
                    const SizedBox(height: 24),
                  ],
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

            // Buttons pinned to bottom — Row layout
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: opts.showCancelButton
                  ? Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: opts.cancelButtonText,
                            variant: AppButtonVariant.outline,
                            expanded: true,
                            radius: 100,
                            onPressed: () {
                              opts.onCancel?.call();
                              onDismiss();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: opts.destructive
                              ? buildDestructiveButton(
                                  label: opts.confirmButtonText,
                                  isLoading: opts.isLoading,
                                  onPressed: () {
                                    opts.onConfirm?.call();
                                    if (!opts.isLoading) onDismiss();
                                  },
                                )
                              : AppButton(
                                  label: opts.confirmButtonText,
                                  expanded: true,
                                  radius: 100,
                                  isLoading: opts.isLoading,
                                  onPressed: () {
                                    opts.onConfirm?.call();
                                    if (!opts.isLoading) onDismiss();
                                  },
                                ),
                        ),
                      ],
                    )
                  : (opts.destructive
                      ? buildDestructiveButton(
                          label: opts.confirmButtonText,
                          isLoading: opts.isLoading,
                          onPressed: () {
                            opts.onConfirm?.call();
                            if (!opts.isLoading) onDismiss();
                          },
                        )
                      : AppButton(
                          label: opts.confirmButtonText,
                          expanded: true,
                          radius: 100,
                          isLoading: opts.isLoading,
                          onPressed: () {
                            opts.onConfirm?.call();
                            if (!opts.isLoading) onDismiss();
                          },
                        )),
            ),
          ],
        ),
      ),
    );
  }
}

class _DestructiveButton extends StatelessWidget {
  const _DestructiveButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
