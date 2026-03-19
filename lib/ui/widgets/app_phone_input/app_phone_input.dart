import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';

class AppPhoneInput extends StatefulWidget {
  const AppPhoneInput({
    super.key,
    this.value,
    this.onChanged,
    this.placeholder = '000 000 0000',
    this.disabled = false,
    this.bordered = true,
    this.borderColor = AppColors.border,
    this.errorMessage,
    this.canSelectCountryCode = false,
    this.label,
  });

  final String? value;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final bool disabled;
  final bool bordered;
  final Color borderColor;
  final String? errorMessage;
  final bool canSelectCountryCode;
  final String? label;

  @override
  State<AppPhoneInput> createState() => _AppPhoneInputState();
}

class _AppPhoneInputState extends State<AppPhoneInput> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _focused = false;

  // Only NG for now
  static const _dialCode = '+234';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode.addListener(() => setState(() => _focused = _focusNode.hasFocus));
  }

  @override
  void didUpdateWidget(AppPhoneInput old) {
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
          child: Row(
            children: [
              // Country code prefix
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppSvg(AppSvgs.flagNg, size: 22),
                    const SizedBox(width: 6),
                    const Text(
                      _dialCode,
                      style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (widget.canSelectCountryCode) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textSlate),
                    ],
                  ],
                ),
              ),
              // Divider
              Container(
                width: 1,
                height: 24,
                color: AppColors.border,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              // Number field
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: !widget.disabled,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    counterText: '',
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
            ],
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
