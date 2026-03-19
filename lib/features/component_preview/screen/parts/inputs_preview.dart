import 'package:flutter/material.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_date_input/app_date_input.dart';
import 'package:ohlify/ui/widgets/app_dropdown_input/app_dropdown_input.dart';
import 'package:ohlify/ui/widgets/app_otp_input/app_otp_input.dart';
import 'package:ohlify/ui/widgets/app_phone_input/app_phone_input.dart';
import 'package:ohlify/ui/widgets/app_text_area_input/app_text_area_input.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

class InputsPreview extends StatefulWidget {
  const InputsPreview({super.key});

  @override
  State<InputsPreview> createState() => _InputsPreviewState();
}

class _InputsPreviewState extends State<InputsPreview> {
  String _text = '';
  String _phone = '';
  String _otp = '';
  String? _dropdownVal;
  DateTime? _date;

  static const _dropdownOptions = [
    DropdownOption(label: 'Savings Account', value: 'savings'),
    DropdownOption(label: 'Current Account', value: 'current'),
    DropdownOption(label: 'Domiciliary Account', value: 'dom'),
    DropdownOption(label: 'Fixed Deposit', value: 'fixed'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('TextInput'),
        const SizedBox(height: 12),
        AppTextInput(
          label: 'Full Name',
          placeholder: 'Enter your full name',
          value: _text,
          onChanged: (v) => setState(() => _text = v),
          bordered: true,
        ),
        const SizedBox(height: 10),
        AppTextInput(
          placeholder: 'With start icon',
          startIcon: const Icon(AppIcons.search, size: 18, color: AppColors.textSlate),
          onChanged: (_) {},
        ),
        const SizedBox(height: 10),
        AppTextInput(
          placeholder: 'With end icon (eye)',
          obscureText: true,
          endIcon: const Icon(AppIcons.eye, size: 18, color: AppColors.textSlate),
          onChanged: (_) {},
        ),
        const SizedBox(height: 10),
        AppTextInput(
          placeholder: 'With error state',
          errorMessage: 'This field is required',
          onChanged: (_) {},
        ),
        const SizedBox(height: 10),
        AppTextInput(
          placeholder: 'Disabled input',
          disabled: true,
          onChanged: (_) {},
        ),
        const SizedBox(height: 24),

        _sectionLabel('TextAreaInput'),
        const SizedBox(height: 12),
        AppTextAreaInput(
          label: 'Description',
          placeholder: 'Write something...',
          onChanged: (_) {},
        ),
        const SizedBox(height: 10),
        AppTextAreaInput(
          placeholder: 'With error',
          errorMessage: 'Description is too short',
          onChanged: (_) {},
        ),
        const SizedBox(height: 24),

        _sectionLabel('PhoneInput'),
        const SizedBox(height: 12),
        AppPhoneInput(
          label: 'Phone number',
          placeholder: '800 000 0000',
          value: _phone,
          onChanged: (v) => setState(() => _phone = v),
        ),
        const SizedBox(height: 10),
        AppPhoneInput(
          placeholder: 'With error',
          errorMessage: 'Enter a valid Nigerian phone number',
          onChanged: (_) {},
        ),
        const SizedBox(height: 24),

        _sectionLabel('OTPInput (length 6)'),
        const SizedBox(height: 12),
        AppOtpInput(
          length: 6,
          autoFocus: false,
          onComplete: (v) => setState(() => _otp = v),
          onChanged: (v) => setState(() => _otp = v),
        ),
        if (_otp.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Value: $_otp', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          ),
        const SizedBox(height: 10),
        AppOtpInput(
          length: 4,
          autoFocus: false,
          errorMessage: 'Incorrect OTP, please try again',
          onComplete: (_) {},
        ),
        const SizedBox(height: 24),

        _sectionLabel('DropdownInput'),
        const SizedBox(height: 12),
        AppDropdownInput<String>(
          label: 'Account type',
          placeholder: 'Select account type',
          options: _dropdownOptions,
          value: _dropdownVal,
          onChanged: (v) => setState(() => _dropdownVal = v),
          bordered: true,
        ),
        const SizedBox(height: 10),
        AppDropdownInput<String>(
          placeholder: 'Searchable dropdown',
          options: _dropdownOptions,
          searchable: true,
          bordered: true,
          onChanged: (_) {},
        ),
        const SizedBox(height: 10),
        AppDropdownInput<String>(
          placeholder: 'Disabled dropdown',
          options: _dropdownOptions,
          disabled: true,
          bordered: true,
          onChanged: (_) {},
        ),
        const SizedBox(height: 24),

        _sectionLabel('DateInput'),
        const SizedBox(height: 12),
        AppDateInput(
          label: 'Select appointment date',
          value: _date,
          onChanged: (d) => setState(() => _date = d),
          bordered: true,
          defaultDate: DateTime.now(),
        ),
        const SizedBox(height: 10),
        AppDateInput(
          placeholder: 'Weekends disabled',
          weekendDisabled: true,
          bordered: true,
          onChanged: (_) {},
        ),
        const SizedBox(height: 10),
        AppDateInput(
          placeholder: 'With error',
          errorMessage: 'Please select a date',
          bordered: true,
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
        letterSpacing: 0.6,
      ),
    );
  }
}
