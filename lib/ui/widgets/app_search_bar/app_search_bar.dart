import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.placeholder = 'Search for professional',
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  final String placeholder;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  /// When true the field is not editable — tapping fires [onTap] instead.
  /// Useful for navigating to a dedicated search screen.
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readOnly ? onTap : null,
      child: AbsorbPointer(
        absorbing: readOnly,
        child: AppTextInput(
          placeholder: placeholder,
          keyboardType: TextInputType.text,
          startIcon: const Icon(
            AppIcons.search,
            size: 18,
            color: AppColors.textMuted,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
