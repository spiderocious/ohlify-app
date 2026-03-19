import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

enum CharSupported { all, number, text, textWithEmoji }

/// Shared text input. Handles border, focus, error, icons, char filtering.
class AppTextInput extends StatefulWidget {
  const AppTextInput({
    super.key,
    this.value,
    this.onChanged,
    this.placeholder,
    this.disabled = false,
    this.bordered = true,
    this.borderColor = AppColors.border,
    this.errorMessage,
    this.startIcon,
    this.endIcon,
    this.maxLength,
    this.minLength,
    this.charSupported = CharSupported.all,
    this.regex,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.controller,
    this.label,
    this.autofocus = false,
  });

  final String? value;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final bool disabled;
  final bool bordered;
  final Color borderColor;
  final String? errorMessage;
  final Widget? startIcon;
  final Widget? endIcon;
  final int? maxLength;
  final int? minLength;
  final CharSupported charSupported;
  final RegExp? regex;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? label;
  final bool autofocus;

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _focused = false;
  bool _ownsController = false;
  bool _ownsFocus = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.value);
      _ownsController = true;
    } else {
      _controller = widget.controller!;
    }
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownsFocus = true;
    } else {
      _focusNode = widget.focusNode!;
    }
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(AppTextInput old) {
    super.didUpdateWidget(old);
    if (widget.value != null && widget.value != _controller.text) {
      _controller.text = widget.value!;
    }
  }

  void _onFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  List<TextInputFormatter> get _formatters {
    return switch (widget.charSupported) {
      CharSupported.number => [FilteringTextInputFormatter.digitsOnly],
      CharSupported.text => [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
      CharSupported.textWithEmoji => [],
      CharSupported.all => [],
    };
  }

  Color get _borderColor {
    if (widget.errorMessage != null) return AppColors.error;
    if (_focused) return AppColors.primary;
    return widget.bordered ? widget.borderColor : Colors.transparent;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_ownsController) _controller.dispose();
    if (_ownsFocus) _focusNode.dispose();
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
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            autofocus: widget.autofocus,
            maxLength: widget.maxLength,
            inputFormatters: _formatters,
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
                height: 24 / 16,
              ),
              prefixIcon: widget.startIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 14, right: 8),
                      child: widget.startIcon,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: widget.endIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 14, left: 8),
                      child: widget.endIcon,
                    )
                  : null,
              suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              counterText: '',
            ),
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
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
