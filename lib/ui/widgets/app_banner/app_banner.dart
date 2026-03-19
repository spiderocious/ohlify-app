import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';

enum AppBannerVariant { primary, success, warning, error, info, neutral }

class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    required this.child,
    this.variant = AppBannerVariant.primary,
    this.rounded = true,
    this.onTap,
    this.padding,
    this.backgroundColor,
  });

  final Widget child;
  final AppBannerVariant variant;

  /// When true renders with BorderRadius.circular(16), otherwise square.
  final bool rounded;

  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  /// Overrides the variant background color.
  final Color? backgroundColor;

  static const _variantColors = {
    AppBannerVariant.primary: Color(0xFFEAE8FC),
    AppBannerVariant.success: Color(0xFFDCFCE7),
    AppBannerVariant.warning: Color(0xFFFFF7ED),
    AppBannerVariant.error: Color(0xFFFEE2E2),
    AppBannerVariant.info: Color(0xFFEFF6FF),
    AppBannerVariant.neutral: AppColors.surface,
  };

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? _variantColors[variant]!;
    final radius = rounded ? BorderRadius.circular(16) : BorderRadius.zero;

    final container = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: radius,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}
