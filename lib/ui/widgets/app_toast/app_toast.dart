import 'package:flutter/material.dart';

import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

/// Visual bar for a single toast.
/// Controlled entirely by [ToastEntry] from [ToastNotifier].
class AppToast extends StatelessWidget {
  const AppToast({
    super.key,
    required this.entry,
    required this.onDismiss,
  });

  final ToastEntry entry;
  final VoidCallback onDismiss;

  // ── Colours — sourced from AppColors ─────────────────────────────────────

  static const _bgColors = {
    ToastType.success: AppColors.toastSuccessBg,
    ToastType.error: AppColors.toastErrorBg,
    ToastType.warning: AppColors.toastWarningBg,
    ToastType.info: AppColors.toastInfoBg,
  };

  static const _iconColors = {
    ToastType.success: AppColors.toastSuccessIcon,
    ToastType.error: AppColors.toastErrorIcon,
    ToastType.warning: AppColors.toastWarningIcon,
    ToastType.info: AppColors.toastInfoIcon,
  };

  static const _defaultIcons = {
    ToastType.success: Icons.check_circle_outline_rounded,
    ToastType.error: Icons.error_outline_rounded,
    ToastType.warning: Icons.warning_amber_rounded,
    ToastType.info: Icons.info_outline_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final type = entry.options.type;
    final bg = _bgColors[type]!;
    final fullWidth = entry.options.fullWidth;

    Widget? iconWidget;
    if (entry.options.showIcon) {
      if (entry.options.icon is Widget) {
        iconWidget = entry.options.icon as Widget;
      } else {
        iconWidget = Icon(
          _defaultIcons[type]!,
          color: _iconColors[type]!,
          size: 20,
        );
      }
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: fullWidth ? 20 : 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: fullWidth ? BorderRadius.zero : BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading icon (optional)
          if (iconWidget != null) ...[
            iconWidget,
            const SizedBox(width: 12),
          ],

          // Message
          Expanded(
            child: Text(
              entry.message,
              style: const TextStyle(
                fontFamily: 'MonaSans',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textWhite,
                height: 1.4,
                decoration: TextDecoration.none,
              ),
            ),
          ),

          // Dismiss button
          if (entry.options.dismissible) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onDismiss,
              child: const Text(
                'Dismiss',
                style: TextStyle(
                  fontFamily: 'MonaSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
