import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class UpcomingCallsList extends StatelessWidget {
  const UpcomingCallsList({
    super.key,
    required this.calls,
    required this.onViewAll,
    required this.onTap,
  });

  final List<UpcomingCall> calls;
  final VoidCallback onViewAll;
  final ValueChanged<UpcomingCall> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(onViewAll: onViewAll),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < calls.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  _UpcomingCallCard(
                    call: calls[i],
                    onTap: () => onTap(calls[i]),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.onViewAll});

  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppText(
          'Upcoming calls',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        GestureDetector(
          onTap: onViewAll,
          child: const AppText(
            'View all',
            variant: AppTextVariant.body,
            color: AppColors.textBlack,
            weight: FontWeight.w500,
            align: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

class _UpcomingCallCard extends StatelessWidget {
  const _UpcomingCallCard({required this.call, required this.onTap});

  final UpcomingCall call;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Avatar(avatarUrl: call.avatarUrl),
            const SizedBox(height: 16),
            AppText(
              call.name,
              variant: AppTextVariant.body,
              color: AppColors.textNavy,
              align: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            AppText(
              call.role,
              variant: AppTextVariant.bodyNormal,
              color: AppColors.textMuted,
              align: TextAlign.center,
              weight: FontWeight.w500,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            _RatingRow(rating: call.rating, reviewCount: call.reviewCount),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: avatarUrl != null
          ? Image.network(
              avatarUrl!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
          : Container(
              width: 100,
              height: 100,
              color: AppColors.border,
              child: const Icon(
                Icons.person,
                size: 48,
                color: AppColors.textMuted,
              ),
            ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.rating, required this.reviewCount});

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppSvg(AppSvgs.ratingBadge, size: 18),
        const SizedBox(width: 4),
        AppText(
          '$rating',
          variant: AppTextVariant.body,
          color: AppColors.textAmber,
          weight: FontWeight.w500,
          align: TextAlign.start,
        ),
        const SizedBox(width: 4),
        AppText(
          '($reviewCount Reviews)',
          variant: AppTextVariant.bodyNormal,
          color: AppColors.textMuted,
          align: TextAlign.start,
          weight: FontWeight.w400,
        ),
      ],
    );
  }
}
