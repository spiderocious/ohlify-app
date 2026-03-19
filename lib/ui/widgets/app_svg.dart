import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders any SVG asset from [AppSvgs].
///
/// Usage:
/// ```dart
/// AppSvg(AppSvgs.flagNg)
/// AppSvg(AppSvgs.flagNg, size: 24)
/// AppSvg(AppSvgs.someIcon, size: 20, color: AppColors.primary)
/// ```
class AppSvg extends StatelessWidget {
  const AppSvg(
    this.assetPath, {
    super.key,
    this.size,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  final String assetPath;

  /// Sets both width and height. Overridden by [width]/[height] if provided.
  final double? size;
  final double? width;
  final double? height;

  /// Applies a color filter (tints the SVG).
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width ?? size,
      height: height ?? size,
      fit: fit,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
