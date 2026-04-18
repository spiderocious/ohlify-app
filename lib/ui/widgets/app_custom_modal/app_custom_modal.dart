import 'package:flutter/material.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Renders a [CustomModalEntry]: title bar + close button + divider + body.
/// The body comes from the entry's [CustomModalEntry.builder].
class AppCustomModal extends StatelessWidget {
  const AppCustomModal({
    super.key,
    required this.entry,
    required this.onDismiss,
    required this.isFullscreen,
  });

  final CustomModalEntry entry;
  final VoidCallback onDismiss;
  final bool isFullscreen;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final maxWidth = isFullscreen ? double.infinity : screenWidth - 32;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
        margin: isFullscreen ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(isFullscreen ? 0 : 20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              title: entry.title,
              showClose: entry.options.showCloseButton,
              onDismiss: onDismiss,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(20),
              child: entry.builder(context, onDismiss),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.showClose,
    required this.onDismiss,
  });

  final String title;
  final bool showClose;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              title,
              variant: AppTextVariant.medium,
              color: AppColors.textJet,
              weight: FontWeight.w700,
              align: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (showClose)
            AppIconButton(
              icon: const Icon(AppIcons.close, color: AppColors.textJet),
              shape: AppIconButtonShape.squircle,
              backgroundColor: AppColors.surfaceLight,
              size: 36,
              iconSize: 18,
              onPressed: onDismiss,
            ),
        ],
      ),
    );
  }
}
