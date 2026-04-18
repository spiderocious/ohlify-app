import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_dropdown_input/app_dropdown_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

const _otherValue = '__other__';

const _options = [
  DropdownOption(label: 'Lawyer', value: 'Lawyer'),
  DropdownOption(label: 'Podcaster', value: 'Podcaster'),
  DropdownOption(label: 'Architect', value: 'Architect'),
  DropdownOption(label: 'Finance advisor', value: 'Finance advisor'),
  DropdownOption(label: 'Health coach', value: 'Health coach'),
  DropdownOption(label: 'Career coach', value: 'Career coach'),
  DropdownOption(label: 'Product designer', value: 'Product designer'),
  DropdownOption(label: 'Software engineer', value: 'Software engineer'),
  DropdownOption(label: 'Other', value: _otherValue),
];

class OccupationModalContent extends StatefulWidget {
  const OccupationModalContent({
    super.key,
    required this.initialValue,
    required this.onSave,
  });

  final String? initialValue;
  final ValueChanged<String> onSave;

  @override
  State<OccupationModalContent> createState() => _OccupationModalContentState();
}

class _OccupationModalContentState extends State<OccupationModalContent> {
  late String _selectedOption;
  late String _otherText;

  @override
  void initState() {
    super.initState();
    final existing = widget.initialValue;
    final match = _options.firstWhere(
      (o) => o.value == existing,
      orElse: () => const DropdownOption(label: 'Other', value: _otherValue),
    );
    if (existing == null) {
      _selectedOption = _options.first.value;
      _otherText = '';
    } else if (match.value == _otherValue) {
      _selectedOption = _otherValue;
      _otherText = existing;
    } else {
      _selectedOption = match.value;
      _otherText = '';
    }
  }

  bool get _isOther => _selectedOption == _otherValue;

  String? get _resolvedValue {
    if (_isOther) {
      final trimmed = _otherText.trim();
      return trimmed.isEmpty ? null : trimmed;
    }
    return _selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    final value = _resolvedValue;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText(
          'Select the occupation that describes you best.',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 16),
        AppDropdownInput<String>(
          label: 'Occupation',
          options: _options,
          value: _selectedOption,
          bordered: true,
          onChanged: (v) => setState(() => _selectedOption = v),
        ),
        if (_isOther) ...[
          const SizedBox(height: 14),
          AppTextInput(
            label: 'Tell us what you do',
            value: _otherText,
            placeholder: 'e.g. Voice over artist',
            onChanged: (v) => setState(() => _otherText = v),
          ),
        ],
        const SizedBox(height: 20),
        AppButton(
          label: 'Save',
          expanded: true,
          radius: 100,
          isDisabled: value == null,
          onPressed: value == null ? null : () => widget.onSave(value),
        ),
      ],
    );
  }
}
