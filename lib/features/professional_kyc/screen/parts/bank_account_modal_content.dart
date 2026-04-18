import 'package:flutter/material.dart';

import 'package:ohlify/features/professional_kyc/types/bank_details.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_dropdown_input/app_dropdown_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

const _banks = [
  DropdownOption(label: 'Moniepoint MFB', value: 'Moniepoint MFB'),
  DropdownOption(label: 'Access Bank', value: 'Access Bank'),
  DropdownOption(label: 'GTBank', value: 'GTBank'),
  DropdownOption(label: 'UBA', value: 'UBA'),
  DropdownOption(label: 'Zenith Bank', value: 'Zenith Bank'),
  DropdownOption(label: 'Kuda MFB', value: 'Kuda MFB'),
  DropdownOption(label: 'Opay', value: 'Opay'),
  DropdownOption(label: 'First Bank', value: 'First Bank'),
];

class BankAccountModalContent extends StatefulWidget {
  const BankAccountModalContent({
    super.key,
    required this.initial,
    required this.onSave,
  });

  final BankDetails? initial;
  final ValueChanged<BankDetails> onSave;

  @override
  State<BankAccountModalContent> createState() =>
      _BankAccountModalContentState();
}

class _BankAccountModalContentState extends State<BankAccountModalContent> {
  late String _accountNumber;
  late String _bankName;

  @override
  void initState() {
    super.initState();
    _accountNumber = widget.initial?.accountNumber ?? '';
    _bankName = widget.initial?.bankName ?? _banks.first.value;
  }

  bool get _isValid =>
      _accountNumber.length == 10 && _bankName.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText(
          'Adding your bank account will affect where you receive your payouts.',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 16),
        AppTextInput(
          label: 'Account number',
          value: _accountNumber,
          placeholder: 'Enter new account number',
          keyboardType: TextInputType.number,
          charSupported: CharSupported.number,
          maxLength: 10,
          onChanged: (v) => setState(() => _accountNumber = v),
        ),
        const SizedBox(height: 14),
        AppDropdownInput<String>(
          label: 'Bank name',
          options: _banks,
          value: _bankName,
          bordered: true,
          searchable: true,
          onChanged: (v) => setState(() => _bankName = v),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Save',
          expanded: true,
          radius: 100,
          isDisabled: !_isValid,
          onPressed: !_isValid
              ? null
              : () => widget.onSave(
                    BankDetails(
                      accountNumber: _accountNumber,
                      bankName: _bankName,
                    ),
                  ),
        ),
      ],
    );
  }
}
