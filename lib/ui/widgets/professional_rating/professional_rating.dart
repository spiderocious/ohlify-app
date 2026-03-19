import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';

class ProfessionalRating extends StatelessWidget {
  const ProfessionalRating({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.showDivider = false,
  });

  final double rating;
  final int reviewCount;

  /// When true renders a vertical divider between rating and review count
  /// (used in the list tile variant).
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppSvg(AppSvgs.ratingBadge, size: 14),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: const TextStyle(
            fontFamily: 'MonaSans',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textAmber,
          ),
        ),
        if (showDivider) ...[
          const SizedBox(width: 8),
          Container(width: 1, height: 12, color: AppColors.border),
          const SizedBox(width: 8),
          Text(
            '$reviewCount Reviews',
            style: const TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textMuted,
            ),
          ),
        ] else ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount Reviews)',
            style: const TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}
