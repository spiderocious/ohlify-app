import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/professional_rating/professional_rating.dart';

class ProfessionalListTile extends StatelessWidget {
  const ProfessionalListTile({
    super.key,
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    this.onSchedule,
    this.onTap,
  });

  final String name;
  final String role;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  final VoidCallback? onSchedule;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, _) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            const SizedBox(width: 14),

            // Name + role + rating
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    name,
                    variant: AppTextVariant.body,
                    color: AppColors.textBlack,
                    align: TextAlign.start,
                    weight: FontWeight.w500,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    role,
                    variant: AppTextVariant.bodyNormal,
                    color: AppColors.textMuted,
                    align: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  ProfessionalRating(
                    rating: rating,
                    reviewCount: reviewCount,
                    showDivider: true,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Schedule call button
            AppButton(
              label: 'Schedule call',
              onPressed: onSchedule,
              radius: 100,
              width: 100,
              height: 32,
              textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 80,
      height: 80,
      color: AppColors.surface,
      child: const Icon(Icons.person, size: 36, color: AppColors.textMuted),
    );
  }
}
