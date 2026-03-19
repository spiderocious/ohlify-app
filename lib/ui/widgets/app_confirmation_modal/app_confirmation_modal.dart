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
  });

  final ConfirmationModalEntry entry;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final opts = entry.options;

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

          // Optional icon
          if (opts.icon != null) ...[
            opts.icon!,
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
            _DestructiveButton(
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
