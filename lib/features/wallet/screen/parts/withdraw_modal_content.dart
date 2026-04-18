import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

class WithdrawModalContent extends StatefulWidget {
  const WithdrawModalContent({super.key, required this.onSubmit});

  /// Called with the formatted amount (e.g. `'₦20,000.00'`) when the user
  /// confirms the withdrawal.
  final ValueChanged<String> onSubmit;

  @override
  State<WithdrawModalContent> createState() => _WithdrawModalContentState();
}

class _WithdrawModalContentState extends State<WithdrawModalContent> {
  String _raw = '';

  bool get _isValid => int.tryParse(_raw) != null && int.parse(_raw) > 0;

  String get _formatted {
    final digits = int.tryParse(_raw) ?? 0;
    final withCommas = digits.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '₦$withCommas.00';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText(
          'Adding your bank account will affect where you receive your payouts',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 20),
        AppTextInput(
          label: 'Amount to withdraw',
          value: _raw,
          placeholder: '₦',
          keyboardType: TextInputType.number,
          charSupported: CharSupported.number,
          onChanged: (v) => setState(() => _raw = v),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Proceed',
          expanded: true,
          radius: 100,
          isDisabled: !_isValid,
          onPressed: !_isValid ? null : () => widget.onSubmit(_formatted),
        ),
      ],
    );
  }
}
