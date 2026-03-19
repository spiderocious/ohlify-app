import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

/// Sticky bottom action bar used across onboarding/auth screens.
/// Shows a "Continue" label on the left and a white circle arrow on the right.
/// Dims when [onPressed] is null.
class ScreenContinueBar extends StatelessWidget {
  const ScreenContinueBar({super.key, this.onPressed, this.label = 'Continue'});

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isEnabled
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.5),
        padding: EdgeInsets.fromLTRB(
          24,
          18,
          24,
          18 + MediaQuery.of(context).padding.bottom,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'MonaSans',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                AppIcons.chevronRight,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
