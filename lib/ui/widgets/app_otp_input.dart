import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

class AppOtpInput extends StatefulWidget {
  const AppOtpInput({
    super.key,
    this.length = 6,
    this.autoFocus = true,
    this.onComplete,
    this.onChanged,
    this.disabled = false,
    this.errorMessage,
    this.bordered = true,
    this.borderColor = AppColors.border,
  });

  final int length;
  final bool autoFocus;
  final ValueChanged<String>? onComplete;
  final ValueChanged<String>? onChanged;
  final bool disabled;
  final String? errorMessage;
  final bool bordered;
  final Color borderColor;

  @override
  State<AppOtpInput> createState() => _AppOtpInputState();
}

class _AppOtpInputState extends State<AppOtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focusNodes.first.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  String get _currentValue =>
      _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.isEmpty) {
      // Backspace — move back
      if (index > 0) _focusNodes[index - 1].requestFocus();
    } else {
      _controllers[index].text = value[value.length - 1];
      _controllers[index].selection = const TextSelection.collapsed(offset: 1);
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    final full = _currentValue;
    widget.onChanged?.call(full);
    if (full.length == widget.length) widget.onComplete?.call(full);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (i) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i < widget.length - 1 ? 10 : 0),
                child: _OtpCell(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  disabled: widget.disabled,
                  hasError: widget.errorMessage != null,
                  bordered: widget.bordered,
                  borderColor: widget.borderColor,
                  onChanged: (v) => _onDigitChanged(i, v),
                ),
              ),
            );
          }),
        ),
        if (widget.errorMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorMessage!,
            textAlign: TextAlign.center,
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

class _OtpCell extends StatefulWidget {
  const _OtpCell({
    required this.controller,
    required this.focusNode,
    required this.disabled,
    required this.hasError,
    required this.bordered,
    required this.borderColor,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool disabled;
  final bool hasError;
  final bool bordered;
  final Color borderColor;
  final ValueChanged<String> onChanged;

  @override
  State<_OtpCell> createState() => _OtpCellState();
}

class _OtpCellState extends State<_OtpCell> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocus);
  }

  void _onFocus() => setState(() => _focused = widget.focusNode.hasFocus);

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocus);
    super.dispose();
  }

  Color get _borderColor {
    if (widget.hasError) return AppColors.error;
    if (_focused) return AppColors.primary;
    return widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 56,
      decoration: BoxDecoration(
        color: widget.disabled ? AppColors.surface : AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _borderColor,
          width: _focused ? 1.5 : 1,
        ),
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: !widget.disabled,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 2, // allow 2 so we can detect the new char
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            fontFamily: 'MonaSans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            counterText: '',
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
