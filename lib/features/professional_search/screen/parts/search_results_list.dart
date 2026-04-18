import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/professional_list_tile/professional_list_tile.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({
    super.key,
    required this.professionals,
    required this.onTap,
    required this.onSchedule,
  });

  final List<Professional> professionals;
  final ValueChanged<Professional> onTap;
  final ValueChanged<Professional> onSchedule;

  @override
  Widget build(BuildContext context) {
    if (professionals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: AppText(
          'No professionals match your search.',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
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
          onTap: () => onTap(pro),
        );
      },
    );
  }
}
