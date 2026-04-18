import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/bank_details.dart';
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

class BankAccountForm extends StatefulWidget {
  const BankAccountForm({
    super.key,
    required this.initial,
    required this.onSave,
    this.description = 'Adding your bank account will affect where you receive your payouts.',
    this.submitLabel = 'Save',
    this.resolvedAccountName,
  });

  final BankDetails? initial;
  final ValueChanged<BankDetails> onSave;
  final String description;
  final String submitLabel;

  /// When provided, the resolved account name is shown under the bank
  /// dropdown as a read-only preview.
  final String? resolvedAccountName;

  @override
  State<BankAccountForm> createState() => _BankAccountFormState();
}

class _BankAccountFormState extends State<BankAccountForm> {
  late String _accountNumber;
  String? _bankName;

  @override
  void initState() {
    super.initState();
    _accountNumber = widget.initial?.accountNumber ?? '';
    _bankName = widget.initial?.bankName;
  }

  bool get _isValid =>
      _accountNumber.length == 10 &&
      _bankName != null &&
      _bankName!.isNotEmpty;

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
          placeholder: 'Select bank',
          bordered: true,
          searchable: true,
          onChanged: (v) => setState(() => _bankName = v),
        ),
        if (widget.resolvedAccountName != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AppText(
              widget.resolvedAccountName!,
              variant: AppTextVariant.body,
              color: AppColors.textSlate,
              align: TextAlign.start,
            ),
          ),
        ],
        const SizedBox(height: 20),
        AppButton(
          label: widget.submitLabel,
          expanded: true,
          radius: 100,
          isDisabled: !_isValid,
          onPressed: !_isValid
              ? null
              : () => widget.onSave(
                    BankDetails(
                      accountNumber: _accountNumber,
                      bankName: _bankName!,
                      accountName: widget.resolvedAccountName ??
                          widget.initial?.accountName,
                    ),
                  ),
        ),
      ],
    );
  }
}
