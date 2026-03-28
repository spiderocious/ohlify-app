import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/professional_list_tile/professional_list_tile.dart';

class PopularProfessionalsList extends StatelessWidget {
  const PopularProfessionalsList({
    super.key,
    required this.professionals,
    required this.onViewAll,
    required this.onSchedule,
  });

  final List<Professional> professionals;
  final VoidCallback onViewAll;
  final ValueChanged<Professional> onSchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText(
              'Popular professional',
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
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: professionals.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final pro = professionals[index];
            return ProfessionalListTile(
              name: pro.name,
              role: pro.role,
              rating: pro.rating,
              reviewCount: pro.reviewCount,
              imageUrl: pro.avatarUrl,
              onSchedule: () => onSchedule(pro),
            );
          },
        ),
      ],
    );
  }
}
