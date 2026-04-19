import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';

/// Circular control button used in the bottom action row of a live call.
class CallControlButton extends StatelessWidget {
  const CallControlButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.active = false,
    this.size = 52,
    this.iconSize,
    this.background,
    this.activeBackground,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onTap;

  /// When true the button uses the [activeBackground] colour, mirroring how
  /// iOS highlights pressed call controls (mute/speaker on).
  final bool active;

  final double size;
  final double? iconSize;

  /// Overrides the default translucent white chip background.
  final Color? background;
  final Color? activeBackground;

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final bg = active
        ? (activeBackground ?? Colors.white)
        : (background ?? Colors.white.withValues(alpha: 0.15));
    final fg = active ? AppColors.textJet : (iconColor ?? Colors.white);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Center(
          child: Icon(icon, size: iconSize ?? size * 0.42, color: fg),
        ),
      ),
    );
  }
}
