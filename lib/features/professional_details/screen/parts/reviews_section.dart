import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key, required this.reviews});

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'Reviews',
          variant: AppTextVariant.header,
          color: AppColors.textJet,
          weight: FontWeight.w700,
          align: TextAlign.start,
        ),
        const SizedBox(height: 10),
        if (reviews.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const AppText(
              'No reviews yet.',
              variant: AppTextVariant.body,
              color: AppColors.textMuted,
              align: TextAlign.center,
            ),
          )
        else
          Column(
            children: [
              for (int i = 0; i < reviews.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _ReviewCard(review: reviews[i]),
              ],
            ],
          ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Avatar(url: review.authorAvatarUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      review.authorName,
                      variant: AppTextVariant.body,
                      color: AppColors.textJet,
                      weight: FontWeight.w600,
                      align: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    AppText(
                      review.timeAgo,
                      variant: AppTextVariant.bodyNormal,
                      color: AppColors.textMuted,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
              _RatingPill(rating: review.rating),
            ],
          ),
          const SizedBox(height: 12),
          AppText(
            review.comment,
            variant: AppTextVariant.body,
            color: AppColors.textJet,
            align: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        width: 40,
        height: 40,
        child: url != null
            ? Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.surface,
      child: const Icon(Icons.person, size: 20, color: AppColors.textMuted),
    );
  }
}

class _RatingPill extends StatelessWidget {
  const _RatingPill({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppSvg(AppSvgs.ratingBadge, size: 12),
          const SizedBox(width: 4),
          AppText(
            rating.toString(),
            variant: AppTextVariant.bodyNormal,
            color: AppColors.textAmber,
            weight: FontWeight.w700,
            align: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
