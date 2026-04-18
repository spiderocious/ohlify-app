import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/call_rate.dart';
import 'package:ohlify/shared/types/scheduled_call_item.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_dropdown_input/app_dropdown_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

const _callTypeOptions = [
  DropdownOption(label: 'Audio call', value: CallType.audio),
  DropdownOption(label: 'Video call', value: CallType.video),
];

const _durationOptions = [
  DropdownOption(label: '10 minutes', value: 10),
  DropdownOption(label: '25 minutes', value: 25),
  DropdownOption(label: '45 minutes', value: 45),
  DropdownOption(label: '60 minutes', value: 60),
];

class AddRateForm extends StatefulWidget {
  const AddRateForm({
    super.key,
    required this.onSave,
    this.description = 'Add your rate and set duration for every call type, so you can get paid for your time.',
    this.submitLabel = 'Save',
  });

  final ValueChanged<CallRate> onSave;
  final String description;
  final String submitLabel;

  @override
  State<AddRateForm> createState() => _AddRateFormState();
}

class _AddRateFormState extends State<AddRateForm> {
  CallType? _callType;
  int? _duration;
  String _amount = '';

  bool get _isValid =>
      _callType != null && _duration != null && _amount.trim().isNotEmpty;

  String _formatPrice(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return '';
    final withCommas = digits.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '₦ $withCommas';
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
        AppDropdownInput<CallType>(
          label: 'Call type',
          options: _callTypeOptions,
          value: _callType,
          placeholder: 'Select',
          bordered: true,
          onChanged: (v) => setState(() => _callType = v),
        ),
        const SizedBox(height: 14),
        AppDropdownInput<int>(
          label: 'Duration',
          options: _durationOptions,
          value: _duration,
          placeholder: 'Select',
          bordered: true,
          onChanged: (v) => setState(() => _duration = v),
        ),
        const SizedBox(height: 14),
        AppTextInput(
          label: 'Price',
          value: _amount,
          placeholder: 'Enter amount',
          keyboardType: TextInputType.number,
          charSupported: CharSupported.number,
          onChanged: (v) => setState(() => _amount = v),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: widget.submitLabel,
          expanded: true,
          radius: 100,
          isDisabled: !_isValid,
          onPressed: !_isValid
              ? null
              : () => widget.onSave(
                    CallRate(
                      id: '',
                      callType: _callType!,
                      durationMinutes: _duration!,
                      price: _formatPrice(_amount),
                    ),
                  ),
        ),
      ],
    );
  }
}
