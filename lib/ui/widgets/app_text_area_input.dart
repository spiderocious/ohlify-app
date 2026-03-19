import 'package:flutter/material.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

class AppTextAreaInput extends StatefulWidget {
  const AppTextAreaInput({
    super.key,
    this.value,
    this.onChanged,
    this.placeholder,
    this.disabled = false,
    this.bordered = true,
    this.borderColor = AppColors.border,
    this.errorMessage,
    this.maxLength,
    this.minLength,
    this.minLines = 3,
    this.maxLines = 6,
    this.label,
  });

  final String? value;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final bool disabled;
  final bool bordered;
  final Color borderColor;
  final String? errorMessage;
  final int? maxLength;
  final int? minLength;
  final int minLines;
  final int maxLines;
  final String? label;

  @override
  State<AppTextAreaInput> createState() => _AppTextAreaInputState();
}

class _AppTextAreaInputState extends State<AppTextAreaInput> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode.addListener(() => setState(() => _focused = _focusNode.hasFocus));
  }

  @override
  void didUpdateWidget(AppTextAreaInput old) {
    super.didUpdateWidget(old);
    if (widget.value != null && widget.value != _controller.text) {
      _controller.text = widget.value!;
    }
  }

  Color get _borderColor {
    if (widget.errorMessage != null) return AppColors.error;
    if (_focused) return AppColors.primary;
    return widget.bordered ? widget.borderColor : Colors.transparent;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: widget.disabled ? AppColors.surface : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: widget.bordered || widget.errorMessage != null || _focused
                ? Border.all(color: _borderColor, width: _focused ? 1.5 : 1)
                : null,
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: !widget.disabled,
            maxLength: widget.maxLength,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textSlate,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              counterText: '',
            ),
            onChanged: widget.onChanged,
          ),
        ),
        if (widget.errorMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorMessage!,
            style: const TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 12,
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
