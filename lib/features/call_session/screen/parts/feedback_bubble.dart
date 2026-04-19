import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Post-call emoji feedback bubble — shown after the call ends.
class EmojiFeedbackBubble extends StatefulWidget {
  const EmojiFeedbackBubble({
    super.key,
    required this.onSubmit,
    required this.onAddFeedback,
    required this.onSkip,
  });

  final ValueChanged<int> onSubmit;
  final ValueChanged<int> onAddFeedback;
  final VoidCallback onSkip;

  @override
  State<EmojiFeedbackBubble> createState() => _EmojiFeedbackBubbleState();
}

class _EmojiFeedbackBubbleState extends State<EmojiFeedbackBubble> {
  int? _selected;

  static const _options = ['😖', '😒', '😐', '🙂', '😍'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Bubble(
          child: AppText(
            'Please rate your experience so far',
            variant: AppTextVariant.body,
            color: AppColors.textJet,
            align: TextAlign.start,
          ),
        ),
        const SizedBox(height: 10),
        _Bubble(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < _options.length; i++)
                _EmojiOption(
                  emoji: _options[i],
                  selected: _selected == i,
                  onTap: () => setState(() => _selected = i),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppButton(
          label: 'Submit',
          expanded: true,
          radius: 100,
          isDisabled: _selected == null,
          onPressed: _selected == null ? null : () => widget.onSubmit(_selected!),
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Add feedback',
          variant: AppButtonVariant.subtle,
          expanded: true,
          radius: 100,
          onPressed: () => widget.onAddFeedback(_selected ?? 2),
        ),
        const SizedBox(height: 6),
        Center(
          child: GestureDetector(
            onTap: widget.onSkip,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: AppText(
                'Skip',
                variant: AppTextVariant.body,
                color: Colors.white,
                weight: FontWeight.w600,
                align: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Free-text feedback bubble shown after the emoji step when the user taps
/// "Add feedback".
class DescriptionFeedbackBubble extends StatefulWidget {
  const DescriptionFeedbackBubble({
    super.key,
    required this.onSubmit,
    required this.onSkip,
  });

  final ValueChanged<String> onSubmit;
  final VoidCallback onSkip;

  @override
  State<DescriptionFeedbackBubble> createState() =>
      _DescriptionFeedbackBubbleState();
}

class _DescriptionFeedbackBubbleState extends State<DescriptionFeedbackBubble> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Bubble(
          child: AppText(
            'Add feedback',
            variant: AppTextVariant.body,
            color: AppColors.textJet,
            align: TextAlign.start,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                'Description*',
                variant: AppTextVariant.body,
                color: AppColors.textNavy,
                weight: FontWeight.w700,
                align: TextAlign.start,
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 5,
                onChanged: (v) => setState(() => _value = v),
                decoration: const InputDecoration(
                  hintText: 'Provide a detailed response',
                  hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.textSlate,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppButton(
          label: 'Submit',
          expanded: true,
          radius: 100,
          isDisabled: _value.trim().isEmpty,
          onPressed: _value.trim().isEmpty
              ? null
              : () => widget.onSubmit(_value.trim()),
        ),
        const SizedBox(height: 6),
        Center(
          child: GestureDetector(
            onTap: widget.onSkip,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: AppText(
                'Skip',
                variant: AppTextVariant.body,
                color: Colors.white,
                weight: FontWeight.w600,
                align: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: child,
      ),
    );
  }
}

class _EmojiOption extends StatelessWidget {
  const _EmojiOption({
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Text(emoji, style: const TextStyle(fontSize: 28)),
      ),
    );
  }
}
