import 'package:flutter/material.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

enum AppTagVariant {
  /// Filled background + white text (AUDIO / VIDEO style)
  solid,

  /// Transparent bg, border + text (RELATIONSHIP / TECHNOLOGY style)
  outline,

  /// Very light tinted bg, no border, muted text
  subtle,

  /// Greenish surface bg (surface variant)
  surface,
}

enum AppTagRadius {
  /// Fully rounded pill (default)
  full,

  /// 8px rounded corners
  large,

  /// 4px rounded corners
  small,

  /// Square
  none,
}

enum AppTagSize { small, medium, large }

/// A compact label/chip component.
///
/// ```dart
/// // Outline pill (default)
/// AppTag(label: 'RELATIONSHIP')
///
/// // Solid with icon
/// AppTag(
///   label: 'AUDIO',
///   variant: AppTagVariant.solid,
///   color: Color(0xFF8F089B),
///   startIcon: Icon(Icons.videocam, color: Colors.white, size: 14),
/// )
/// ```
class AppTag extends StatelessWidget {
  const AppTag({
    super.key,
    required this.label,
    this.variant = AppTagVariant.outline,
    this.color,
    this.size = AppTagSize.medium,
    this.radius = AppTagRadius.full,
    this.startIcon,
    this.endIcon,
    this.onTap,
    this.disabled = false,
  });

  final String label;
  final AppTagVariant variant;

  /// Overrides the default fill / border / text color depending on variant.
  /// For `solid`: sets background. For `outline`/`subtle`/`surface`: sets
  /// border and text color.
  final Color? color;

  final AppTagSize size;
  final AppTagRadius radius;
  final Widget? startIcon;
  final Widget? endIcon;
  final VoidCallback? onTap;
  final bool disabled;

  // ── Default palette ────────────────────────────────────────────────
  static const _defaultText = Color(0xFF344272);
  static const _defaultBorder = Color(0xFFCED2DD);
  static const _defaultSolid = AppColors.primary;
  static const _defaultSurface = Color(0xFFE8F5E9); // greenish surface bg
  static const _defaultSubtle = Color(0xFFEEEDF9);  // light primary tint

  // ── Geometry ───────────────────────────────────────────────────────
  double get _borderRadius => switch (radius) {
    AppTagRadius.full => 999,
    AppTagRadius.large => 8,
    AppTagRadius.small => 4,
    AppTagRadius.none => 0,
  };

  EdgeInsets get _padding => switch (size) {
    AppTagSize.small => const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    AppTagSize.medium => const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    AppTagSize.large => const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
  };

  double get _fontSize => switch (size) {
    AppTagSize.small => 10,
    AppTagSize.medium => 12,
    AppTagSize.large => 14,
  };

  double get _iconSize => switch (size) {
    AppTagSize.small => 12,
    AppTagSize.medium => 14,
    AppTagSize.large => 16,
  };

  // ── Colors ─────────────────────────────────────────────────────────
  Color get _backgroundColor => switch (variant) {
    AppTagVariant.solid => color ?? _defaultSolid,
    AppTagVariant.outline => Colors.transparent,
    AppTagVariant.subtle => _defaultSubtle,
    AppTagVariant.surface => color ?? _defaultSurface,
  };

  Color get _textColor => switch (variant) {
    AppTagVariant.solid => Colors.white,
    AppTagVariant.outline => color ?? _defaultText,
    AppTagVariant.subtle => color ?? _defaultText,
    AppTagVariant.surface => color ?? const Color(0xFF1F6F15),
  };

  Border? get _border => switch (variant) {
    AppTagVariant.outline => Border.all(color: color ?? _defaultBorder, width: 1),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (startIcon != null) ...[
          _IconSizer(size: _iconSize, child: startIcon!),
          const SizedBox(width: 5),
        ],
        Text(
          label,
          style: TextStyle(
            fontFamily: 'MonaSans',
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
            color: _textColor,
            letterSpacing: 0.4,
          ),
        ),
        if (endIcon != null) ...[
          const SizedBox(width: 5),
          _IconSizer(size: _iconSize, child: endIcon!),
        ],
      ],
    );

    final tag = AnimatedOpacity(
      opacity: disabled ? 0.45 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: Container(
        padding: _padding,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: _border,
        ),
        child: content,
      ),
    );

    if (onTap == null || disabled) return tag;

    return GestureDetector(
      onTap: onTap,
      child: tag,
    );
  }
}

/// Constrains an icon widget to a consistent size box.
class _IconSizer extends StatelessWidget {
  const _IconSizer({required this.child, required this.size});
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: FittedBox(child: child));
  }
}
