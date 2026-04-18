import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';
import 'package:ohlify/ui/widgets/app_tag/app_tag.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ProfessionalHeader extends StatelessWidget {
  const ProfessionalHeader({
    super.key,
    required this.professional,
    this.height = 300,
    this.onReviewsTap,
  });

  final Professional professional;
  final double height;
  final VoidCallback? onReviewsTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _HeroImage(url: professional.avatarUrl),
          const _Scrim(),
          Positioned(
            top: 12,
            left: 16,
            child: AppIconButton(
              icon: const Icon(AppIcons.back, color: AppColors.textJet),
              variant: AppIconButtonVariant.ghost,
              backgroundColor: AppColors.background,
              size: 44,
              onPressed: () => context.pop(),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _InfoRow(
              professional: professional,
              onReviewsTap: onReviewsTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return Image.network(url!, fit: BoxFit.cover);
    }
    return Container(
      color: AppColors.textNavy,
      child: const Icon(AppIcons.person, size: 96, color: AppColors.border),
    );
  }
}

class _Scrim extends StatelessWidget {
  const _Scrim();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.45),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.professional, this.onReviewsTap});

  final Professional professional;
  final VoidCallback? onReviewsTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTag(
          label: 'AVAILABLE',
          variant: AppTagVariant.solid,
          color: AppColors.success,
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    professional.name,
                    variant: AppTextVariant.title,
                    color: AppColors.textWhite,
                    weight: FontWeight.w800,
                    align: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppText(
                    professional.role,
                    variant: AppTextVariant.body,
                    color: AppColors.textWhite,
                    align: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _ReviewsBadge(rating: professional.rating, onTap: onReviewsTap),
          ],
        ),
      ],
    );
  }
}

class _ReviewsBadge extends StatelessWidget {
  const _ReviewsBadge({required this.rating, this.onTap});

  final double rating;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppSvg(AppSvgs.ratingBadge, size: 14),
            const SizedBox(width: 6),
            AppText(
              '$rating',
              variant: AppTextVariant.body,
              color: AppColors.textAmber,
              weight: FontWeight.w700,
              align: TextAlign.start,
            ),
            const SizedBox(width: 6),
            const AppText(
              'View reviews',
              variant: AppTextVariant.body,
              color: AppColors.textAmber,
              weight: FontWeight.w600,
              align: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
