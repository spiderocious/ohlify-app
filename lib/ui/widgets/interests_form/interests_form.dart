import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_dropdown_input/app_dropdown_input.dart';
import 'package:ohlify/ui/widgets/app_multi_select_dropdown/app_multi_select_dropdown.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

const _interestOptions = [
  DropdownOption(label: 'Relationship', value: 'Relationship'),
  DropdownOption(label: 'Technology', value: 'Technology'),
  DropdownOption(label: 'Entertainment', value: 'Entertainment'),
  DropdownOption(label: 'Finance', value: 'Finance'),
  DropdownOption(label: 'Health & Wellness', value: 'Health & Wellness'),
  DropdownOption(label: 'Career', value: 'Career'),
  DropdownOption(label: 'Education', value: 'Education'),
  DropdownOption(label: 'Sports', value: 'Sports'),
  DropdownOption(label: 'Lifestyle', value: 'Lifestyle'),
  DropdownOption(label: 'Business', value: 'Business'),
  DropdownOption(label: 'Faith & Spirituality', value: 'Faith & Spirituality'),
  DropdownOption(label: 'Parenting', value: 'Parenting'),
];

class InterestsForm extends StatefulWidget {
  const InterestsForm({
    super.key,
    required this.initialInterests,
    required this.onSave,
    this.description = 'Choose interests that allow us recommend you to people and to recommend people for you.',
    this.submitLabel = 'Save',
  });

  final List<String> initialInterests;
  final ValueChanged<List<String>> onSave;
  final String description;
  final String submitLabel;

  @override
  State<InterestsForm> createState() => _InterestsFormState();
}

class _InterestsFormState extends State<InterestsForm> {
  late List<String> _interests;

  @override
  void initState() {
    super.initState();
    _interests = [...widget.initialInterests];
  }

  @override
  Widget build(BuildContext context) {
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
        AppMultiSelectDropdown(
          label: 'Interests',
          options: _interestOptions,
          selected: _interests,
          allowOther: true,
          placeholder: 'Search and select interests',
          otherPlaceholder: 'Add a custom interest',
          onChanged: (values) => setState(() => _interests = values),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: widget.submitLabel,
          expanded: true,
          radius: 100,
          isDisabled: _interests.isEmpty,
          onPressed: _interests.isEmpty
              ? null
              : () => widget.onSave(List.unmodifiable(_interests)),
        ),
      ],
    );
  }
}
