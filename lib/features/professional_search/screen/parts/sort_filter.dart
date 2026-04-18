import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

enum SortKey { rating, price, name }

enum SortDirection { asc, desc }

class SortOption {
  const SortOption({required this.key, required this.direction});
  final SortKey key;
  final SortDirection direction;

  SortOption copyWith({SortKey? key, SortDirection? direction}) {
    return SortOption(
      key: key ?? this.key,
      direction: direction ?? this.direction,
    );
  }
}

class SortFilter extends StatelessWidget {
  const SortFilter({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final SortOption value;
  final ValueChanged<SortOption> onChanged;

  // Default direction when a key is first selected.
  static SortDirection _defaultFor(SortKey key) => switch (key) {
    SortKey.rating => SortDirection.desc,
    SortKey.price => SortDirection.asc,
    SortKey.name => SortDirection.asc,
  };

  void _onTap(SortKey key) {
    if (value.key == key) {
      final flipped = value.direction == SortDirection.asc
          ? SortDirection.desc
          : SortDirection.asc;
      onChanged(value.copyWith(direction: flipped));
    } else {
      onChanged(SortOption(key: key, direction: _defaultFor(key)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final key in SortKey.values) ...[
            _Chip(
              label: _labelFor(key),
              isSelected: value.key == key,
              direction: value.key == key ? value.direction : null,
              onTap: () => _onTap(key),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  static String _labelFor(SortKey key) => switch (key) {
    SortKey.rating => 'Rating',
    SortKey.price => 'Price',
    SortKey.name => 'Name',
  };
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.direction,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final SortDirection? direction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.secondary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              label,
              variant: AppTextVariant.body,
              color: isSelected ? AppColors.textWhite : AppColors.primary,
              weight: FontWeight.w500,
              align: TextAlign.center,
            ),
            if (isSelected && direction != null) ...[
              const SizedBox(width: 6),
              Icon(
                direction == SortDirection.asc
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                size: 14,
                color: AppColors.textWhite,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
