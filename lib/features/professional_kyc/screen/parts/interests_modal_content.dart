import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_tag/app_tag.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

class InterestsModalContent extends StatefulWidget {
  const InterestsModalContent({
    super.key,
    required this.initialInterests,
    required this.onSave,
  });

  final List<String> initialInterests;
  final ValueChanged<List<String>> onSave;

  @override
  State<InterestsModalContent> createState() => _InterestsModalContentState();
}

class _InterestsModalContentState extends State<InterestsModalContent> {
  late final TextEditingController _controller;
  late List<String> _interests;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _interests = [...widget.initialInterests];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addFromInput(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return;
    if (_interests.any((i) => i.toLowerCase() == trimmed.toLowerCase())) {
      _controller.clear();
      return;
    }
    setState(() {
      _interests.add(trimmed);
      _controller.clear();
    });
  }

  void _remove(String value) {
    setState(() => _interests.remove(value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText(
          'Choose interests so we can recommend you to the right people.',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 16),
        AppTextInput(
          label: 'Interests',
          controller: _controller,
          placeholder: 'Type interests and use enter to add',
          textInputAction: TextInputAction.done,
          onSubmitted: _addFromInput,
        ),
        const SizedBox(height: 14),
        if (_interests.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final interest in _interests)
                AppTag(
                  label: interest.toUpperCase(),
                  variant: AppTagVariant.outline,
                  size: AppTagSize.medium,
                  endIcon: const Icon(Icons.close_rounded, size: 14),
                  onTap: () => _remove(interest),
                ),
            ],
          )
        else
          const AppText(
            'Add at least one interest to continue.',
            variant: AppTextVariant.bodyNormal,
            color: AppColors.textMuted,
            align: TextAlign.start,
          ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Save',
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
