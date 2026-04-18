import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';

enum AppButtonVariant { solid, outline, plain, subtle }

/// A flexible branded button with three visual variants.
///
/// Usage:
/// ```dart
/// // Solid (primary bg, white text)
/// AppButton(label: 'Proceed', onPressed: () {});
///
/// // Outline (transparent bg, primary border + text)
/// AppButton(label: 'Cancel', variant: AppButtonVariant.outline, onPressed: () {});
///
/// // Plain (secondary bg, primary text, no border)
/// AppButton(label: 'Skip', variant: AppButtonVariant.plain, onPressed: () {});
///
/// // Subtle (white bg, primary text, no border by default)
/// AppButton(label: 'Later', variant: AppButtonVariant.subtle, onPressed: () {});
///
/// // Subtle with border (uses borderColor, default AppColors.border)
/// AppButton(label: 'Later', variant: AppButtonVariant.subtle, bordered: true, onPressed: () {});
///
/// // Any variant with a custom border color
/// AppButton(label: 'Go', bordered: true, borderColor: AppColors.danger, onPressed: () {});
///
/// // Outline without border
/// AppButton(label: 'Cancel', variant: AppButtonVariant.outline, bordered: false, onPressed: () {});
///
/// // With icons
/// AppButton(
///   label: 'Continue',
///   endIcon: CircleArrow(),
///   onPressed: () {},
/// );
///
/// // Wrap arbitrary child
/// AppButton(
///   variant: AppButtonVariant.plain,
///   onPressed: () {},
///   child: Row(children: [Icon(...), Text('4.9 View reviews')]),
/// );
/// ```
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.label,
    this.child,
    this.onPressed,
    this.variant = AppButtonVariant.solid,
    this.startIcon,
    this.endIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.radius = 12.0,
    this.width,
    this.height = 52.0,
    this.expanded = false,
    this.padding,
    this.textStyle,
    this.bordered,
    this.borderColor = AppColors.border,
  }) : assert(
         label != null || child != null,
         'Provide either label or child',
       );

  final String? label;

  /// Replaces the default label+icon layout entirely.
  final Widget? child;

  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? startIcon;
  final Widget? endIcon;
  final bool isLoading;
  final bool isDisabled;
  final double radius;
  final double? width;
  final double height;

  /// Stretch to fill available horizontal space.
  final bool expanded;

  final EdgeInsetsGeometry? padding;

  /// Override default text style (color will follow variant unless overridden).
  final TextStyle? textStyle;

  /// Whether to show a border. Defaults to true for [AppButtonVariant.outline],
  /// false for all other variants. Pass explicitly to override.
  final bool? bordered;

  /// Border color when bordered is true. Defaults to [AppColors.border].
  /// [AppButtonVariant.outline] uses [AppColors.primary] unless overridden.
  final Color borderColor;

  bool get _effectivelyDisabled => isDisabled || isLoading || onPressed == null;

  Color get _backgroundColor => switch (variant) {
    AppButtonVariant.solid => AppColors.primary,
    AppButtonVariant.outline => Colors.transparent,
    AppButtonVariant.plain => AppColors.secondary,
    AppButtonVariant.subtle => Colors.white,
  };

  Color get _foregroundColor => switch (variant) {
    AppButtonVariant.solid => Colors.white,
    AppButtonVariant.outline => AppColors.primary,
    AppButtonVariant.plain => AppColors.primary,
    AppButtonVariant.subtle => AppColors.primary,
  };

  bool get _isBordered => bordered ?? variant == AppButtonVariant.outline;

  Color get _effectiveBorderColor =>
      variant == AppButtonVariant.outline && bordered == null
          ? AppColors.primary
          : borderColor;

  Border? get _border =>
      _isBordered ? Border.all(color: _effectiveBorderColor, width: 1.5) : null;

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: expanded ? double.infinity : width,
      height: height,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: _border,
      ),
      child: child != null ? _wrapChild(child!) : _buildLabelContent(),
    );

    // When no explicit width/expanded is set, wrap in IntrinsicWidth so the
    // container sizes to its (padded) label rather than collapsing or
    // expanding to fill the parent's unbounded width in a Row.
    if (!expanded && width == null) {
      container = IntrinsicWidth(child: container);
    }

    return AnimatedOpacity(
      opacity: _effectivelyDisabled ? 0.45 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: GestureDetector(
        onTap: _effectivelyDisabled ? null : onPressed,
        child: container,
      ),
    );
  }

  Widget _wrapChild(Widget inner) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Center(child: inner),
    );
  }

  Widget _buildLabelContent() {
    final effectiveStyle = (textStyle ?? const TextStyle()).copyWith(
      color: textStyle?.color ?? _foregroundColor,
      fontSize: textStyle?.fontSize ?? 16,
      fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
    );

    final loadingIndicator = SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(_foregroundColor),
      ),
    );

    // No icons — centered label with horizontal padding so the button
    // has breathing room around the text (critical when sized intrinsically).
    if (startIcon == null && endIcon == null) {
      return Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          widthFactor: 1,
          child: isLoading
              ? loadingIndicator
              : Text(label!, style: effectiveStyle),
        ),
      );
    }

    // With icons — row layout; label left-aligns when endIcon present
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (startIcon != null) ...[
            startIcon!,
            const SizedBox(width: 8),
          ],
          isLoading
              ? loadingIndicator
              : Text(label!, style: effectiveStyle),
          if (endIcon != null) ...[
            const Spacer(),
            endIcon!,
          ],
        ],
      ),
    );
  }
}
