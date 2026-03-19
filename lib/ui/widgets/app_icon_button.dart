import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';

enum AppIconButtonVariant { filled, outline, ghost }

enum AppIconButtonShape { circle, squircle }

/// A branded icon-only button supporting filled, outline, and ghost variants
/// in circle or squircle (rounded-square) shapes.
///
/// Usage:
/// ```dart
/// // Filled purple circle (video/phone)
/// AppIconButton(
///   icon: Icon(AppIcons.phone, color: Colors.white),
///   onPressed: () {},
/// );
///
/// // Outline red circle (delete)
/// AppIconButton(
///   icon: Icon(AppIcons.delete, color: AppColors.danger),
///   variant: AppIconButtonVariant.outline,
///   borderColor: AppColors.danger,
///   onPressed: () {},
/// );
///
/// // Filled squircle with soft red bg (delete action chip)
/// AppIconButton(
///   icon: Icon(AppIcons.delete, color: Color(0xFF8B0000)),
///   shape: AppIconButtonShape.squircle,
///   backgroundColor: Color(0xFFFDECEA),
///   onPressed: () {},
/// );
/// ```
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = AppIconButtonVariant.filled,
    this.shape = AppIconButtonShape.circle,
    this.backgroundColor,
    this.borderColor,
    this.size = 52.0,
    this.iconSize,
    this.isDisabled = false,
    this.squircleRadius = 16.0,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final AppIconButtonShape shape;

  /// Overrides the default background for the variant.
  final Color? backgroundColor;

  /// Overrides the border color for [AppIconButtonVariant.outline].
  final Color? borderColor;

  /// Overall tap target and container size.
  final double size;

  /// Constrains the icon inside. Defaults to size * 0.45.
  final double? iconSize;

  final bool isDisabled;

  /// Corner radius when [shape] is [AppIconButtonShape.squircle].
  final double squircleRadius;

  bool get _effectivelyDisabled => isDisabled || onPressed == null;

  Color get _defaultBackgroundColor => switch (variant) {
    AppIconButtonVariant.filled => AppColors.primary,
    AppIconButtonVariant.outline => Colors.transparent,
    AppIconButtonVariant.ghost => AppColors.callico,
  };

  Border? get _border => switch (variant) {
    AppIconButtonVariant.outline => Border.all(
      color: borderColor ?? AppColors.primary,
      width: 2.5,
    ),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    final effectiveBg = backgroundColor ?? _defaultBackgroundColor;
    final effectiveIconSize = iconSize ?? size * 0.45;

    final decoration = switch (shape) {
      AppIconButtonShape.circle => BoxDecoration(
        color: effectiveBg,
        shape: BoxShape.circle,
        border: _border,
      ),
      AppIconButtonShape.squircle => BoxDecoration(
        color: effectiveBg,
        borderRadius: BorderRadius.circular(squircleRadius),
        border: _border,
      ),
    };

    return AnimatedOpacity(
      opacity: _effectivelyDisabled ? 0.45 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: GestureDetector(
        onTap: _effectivelyDisabled ? null : onPressed,
        child: Container(
          width: size,
          height: size,
          decoration: decoration,
          child: Center(
            child: IconTheme(
              data: IconThemeData(size: effectiveIconSize),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
