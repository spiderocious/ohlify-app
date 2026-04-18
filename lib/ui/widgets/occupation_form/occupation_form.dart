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
  DropdownOption(label: 'Marketing consultant', value: 'Marketing consultant'),
  DropdownOption(label: 'Fitness coach', value: 'Fitness coach'),
  DropdownOption(label: 'Nutritionist', value: 'Nutritionist'),
  DropdownOption(label: 'Therapist', value: 'Therapist'),
  DropdownOption(label: 'Other', value: _otherValue),
];

/// Reusable occupation picker — dropdown of curated options with an
/// "Other" free-text fallback. Call-sites wrap it in a modal or screen and
/// provide [initialValue]/[onSave].
class OccupationForm extends StatefulWidget {
  const OccupationForm({
    super.key,
    required this.initialValue,
    required this.onSave,
    this.description = 'Let your community and the public know what you do, so you are easy to find.',
    this.submitLabel = 'Save',
  });

  final String? initialValue;
  final ValueChanged<String> onSave;
  final String description;
  final String submitLabel;

  @override
  State<OccupationForm> createState() => _OccupationFormState();
}

class _OccupationFormState extends State<OccupationForm> {
  String? _selectedOption;
  String _otherText = '';

  @override
  void initState() {
    super.initState();
    final existing = widget.initialValue;
    if (existing == null) {
      _selectedOption = null;
      return;
    }
    final match = _options
        .where((o) => o.value != _otherValue && o.value == existing)
        .toList();
    if (match.isNotEmpty) {
      _selectedOption = match.first.value;
    } else {
      _selectedOption = _otherValue;
      _otherText = existing;
    }
  }

  bool get _isOther => _selectedOption == _otherValue;

  String? get _resolvedValue {
    final selected = _selectedOption;
    if (selected == null) return null;
    if (_isOther) {
      final trimmed = _otherText.trim();
      return trimmed.isEmpty ? null : trimmed;
    }
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    final value = _resolvedValue;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          widget.description,
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 16),
        AppDropdownInput<String>(
          label: 'Occupation',
          options: _options,
          value: _selectedOption,
          placeholder: 'Select',
          bordered: true,
          searchable: true,
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
          label: widget.submitLabel,
          expanded: true,
          radius: 100,
          isDisabled: value == null,
          onPressed: value == null ? null : () => widget.onSave(value),
        ),
      ],
    );
  }
}
