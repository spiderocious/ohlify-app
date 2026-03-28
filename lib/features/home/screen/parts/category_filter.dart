import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({
    super.key,
    required this.categories,
    required this.onChanged,
  });

  final List<ProfessionalCategory> categories;
  final ValueChanged<ProfessionalCategory> onChanged;

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.categories.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final cat in widget.categories) ...[
            _FilterChip(
              label: cat.label,
              isSelected: cat.value == _selected,
              onTap: () {
                setState(() => _selected = cat.value);
                widget.onChanged(cat);
              },
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.secondary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: AppText(
          label,
          variant: AppTextVariant.body,
          color: isSelected ? AppColors.textWhite : AppColors.primary,
          weight: FontWeight.w500,
          align: TextAlign.center,
        ),
      ),
    );
  }
}
