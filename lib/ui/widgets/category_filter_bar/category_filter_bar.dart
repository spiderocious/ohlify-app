import 'package:flutter/material.dart';

import 'package:ohlify/ui/widgets/app_button/app_button.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: categories.map((cat) {
          final isSelected = cat == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AppButton(
              label: cat,
              variant: isSelected ? AppButtonVariant.solid : AppButtonVariant.outline,
              onPressed: () => onSelect(cat),
              radius: 100,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
      ),
    );
  }
}
