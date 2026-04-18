import 'package:flutter/material.dart';

import 'package:ohlify/features/professional_kyc/types/identity_details.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_dropdown_input/app_dropdown_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

const _typeOptions = [
  DropdownOption(label: 'NIN', value: IdentityType.nin),
  DropdownOption(label: 'BVN', value: IdentityType.bvn),
  DropdownOption(label: 'International Passport', value: IdentityType.passport),
  DropdownOption(label: 'Driver\'s License', value: IdentityType.driversLicense),
];

class IdentityModalContent extends StatefulWidget {
  const IdentityModalContent({
    super.key,
    required this.initial,
    required this.onSave,
  });

  final IdentityDetails? initial;
  final ValueChanged<IdentityDetails> onSave;

  @override
  State<IdentityModalContent> createState() => _IdentityModalContentState();
}

class _IdentityModalContentState extends State<IdentityModalContent> {
  late IdentityType _type;
  late String _number;
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _type = widget.initial?.type ?? IdentityType.nin;
    _number = widget.initial?.number ?? '';
    _fileName = widget.initial?.fileName;
  }

  bool get _isValid => _number.trim().isNotEmpty && _fileName != null;

  void _pickFile() {
    // Stubbed until a file-picker dependency is wired up. This still lets us
    // prove out the flow end-to-end.
    setState(() => _fileName = 'id_document.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText(
          'Upload a government-issued ID so we can verify your identity.',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 16),
        AppDropdownInput<IdentityType>(
          label: 'ID type',
          options: _typeOptions,
          value: _type,
          bordered: true,
          onChanged: (v) => setState(() => _type = v),
        ),
        const SizedBox(height: 14),
        AppTextInput(
          label: 'ID number',
          value: _number,
          placeholder: 'Enter the ID number',
          onChanged: (v) => setState(() => _number = v),
        ),
        const SizedBox(height: 14),
        _FilePickerField(fileName: _fileName, onPick: _pickFile),
        const SizedBox(height: 20),
        AppButton(
          label: 'Save',
          expanded: true,
          radius: 100,
          isDisabled: !_isValid,
          onPressed: !_isValid
              ? null
              : () => widget.onSave(
                    IdentityDetails(
                      type: _type,
                      number: _number.trim(),
                      fileName: _fileName!,
                    ),
                  ),
        ),
      ],
    );
  }
}

class _FilePickerField extends StatelessWidget {
  const _FilePickerField({required this.fileName, required this.onPick});

  final String? fileName;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ID document',
          style: TextStyle(
            fontFamily: 'MonaSans',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onPick,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasFile ? AppColors.primary : AppColors.border,
                width: hasFile ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  hasFile
                      ? Icons.insert_drive_file_outlined
                      : Icons.upload_file_rounded,
                  size: 20,
                  color: hasFile ? AppColors.primary : AppColors.textMuted,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppText(
                    hasFile ? fileName! : 'Tap to select a file',
                    variant: AppTextVariant.body,
                    color: hasFile ? AppColors.textPrimary : AppColors.textSlate,
                    align: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (hasFile)
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: AppColors.success,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
