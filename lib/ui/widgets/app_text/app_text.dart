import 'package:flutter/material.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

enum AppTextVariant { title, subtitle, header, subheader, label, medium, bodyTitle, body, bodySmall, bodySmallest, bodyNormal }

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.body,
    this.color,
    this.align,
    this.weight,
    this.width,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? align;
  final FontWeight? weight;
  final double? width;
  final int? maxLines;
  final TextOverflow? overflow;

  static const _fontFamily = 'MonaSans';

  TextStyle get _baseStyle => switch (variant) {
    AppTextVariant.title => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 40 / 24,
        letterSpacing: -0.48, // -2% of 24px
        color: AppColors.textPrimary,
      ),
    AppTextVariant.subtitle => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 24 / 14,
        letterSpacing: 0,
        color: AppColors.textMuted,
      ),
    AppTextVariant.header => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 22,
        height: 30 / 22,
        color: AppColors.textPrimary,
      ),
    AppTextVariant.subheader => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
    AppTextVariant.label => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 21 / 12,
        fontFeatures: [FontFeature.liningFigures(), FontFeature.proportionalFigures()],
        color: AppColors.textMuted,
      ),
    AppTextVariant.medium => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        height: 24 / 18,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      ),
    AppTextVariant.bodyTitle => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20,
        height: 32 / 20,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      ),
    AppTextVariant.body => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: -0.14, // -1% of 14px
        color: AppColors.textPrimary,
      ),
    AppTextVariant.bodyNormal => const TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 20 / 14,
      letterSpacing: -0.14, // -1% of 14px
      color: AppColors.textPrimary,
    ),
    AppTextVariant.bodySmall => const TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 10,
      height: 20 / 14,
      letterSpacing: -0.14, // -1% of 14px
      color: AppColors.textPrimary,
    ),
    AppTextVariant.bodySmallest => const TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 8,
      height: 20 / 14,
      letterSpacing: -0.14, // -1% of 14px
      color: AppColors.textPrimary,
    ),
  };

  TextAlign get _defaultAlign => switch (variant) {
    AppTextVariant.subtitle => TextAlign.center,
    AppTextVariant.medium => TextAlign.center,
    AppTextVariant.body => TextAlign.center,
    _ => TextAlign.start,
  };

  @override
  Widget build(BuildContext context) {
    final style = _baseStyle.copyWith(
      color: color,
      fontWeight: weight,
    );

    final text = Text(
      this.text,
      style: style,
      textAlign: align ?? _defaultAlign,
      maxLines: maxLines,
      overflow: overflow,
    );

    if (width != null) {
      return SizedBox(width: width, child: text);
    }
    return text;
  }
}
