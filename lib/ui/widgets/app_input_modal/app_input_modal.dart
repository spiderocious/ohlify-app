import 'package:flutter/material.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';
import 'package:ohlify/ui/widgets/app_text_area_input/app_text_area_input.dart';

class AppInputModal extends StatefulWidget {
  const AppInputModal({
    super.key,
    required this.entry,
    required this.onDismiss,
    this.isFullscreen = false,
  });

  final InputModalEntry entry;
  final VoidCallback onDismiss;
  final bool isFullscreen;

  @override
  State<AppInputModal> createState() => _AppInputModalState();
}

class _AppInputModalState extends State<AppInputModal> {
  late String _value;
  String? _validationError;

  @override
  void initState() {
    super.initState();
    _value = widget.entry.options.defaultValue ?? '';
  }

  InputModalOptions get _opts => widget.entry.options;

  bool get _isObscure => _opts.inputType == InputModalInputType.password;

  TextInputType get _keyboardType => switch (_opts.inputType) {
        InputModalInputType.number => TextInputType.number,
        InputModalInputType.email => TextInputType.emailAddress,
        InputModalInputType.password => TextInputType.visiblePassword,
        InputModalInputType.text => TextInputType.text,
      };

  void _handleConfirm() {
    if (_opts.regex != null && !_opts.regex!.hasMatch(_value)) {
      setState(() => _validationError =
          _opts.errorMessage ?? 'Invalid input. Please try again.');
      return;
    }
    _opts.onConfirm?.call(_value);
    widget.onDismiss();
  }

  Widget _buildInputField() {
    final opts = _opts;
    if (opts.multiline) {
      return AppTextAreaInput(
        value: _value,
        placeholder: opts.placeholder,
        maxLength: opts.maxLength,
        errorMessage: _validationError,
        onChanged: (v) => setState(() {
          _value = v;
          _validationError = null;
        }),
      );
    }
    return AppTextInput(
      value: _value,
      placeholder: opts.placeholder,
      maxLength: opts.maxLength,
      obscureText: _isObscure,
      keyboardType: _keyboardType,
      errorMessage: _validationError,
      startIcon: opts.startIcon,
      endIcon: opts.endIcon,
      autofocus: true,
      onChanged: (v) => setState(() {
        _value = v;
        _validationError = null;
      }),
      onSubmitted: (_) => _handleConfirm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final opts = _opts;

    if (widget.isFullscreen) {
      return _buildFullscreen(opts);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: step label (left) + close button (right)
          Row(
            children: [
              if (opts.stepLabel != null)
                AppText(
                  opts.stepLabel!,
                  variant: AppTextVariant.label,
                  color: AppColors.textMuted,
                  align: TextAlign.start,
                )
              else
                const Spacer(),
              if (opts.stepLabel != null) const Spacer(),
              if (opts.showCloseButton)
                GestureDetector(
                  onTap: () {
                    opts.onCancel?.call();
                    widget.onDismiss();
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    size: 22,
                    color: AppColors.textMuted,
                  ),
                ),
            ],
          ),

          if (opts.showCloseButton || opts.stepLabel != null)
            const SizedBox(height: 16),

          // Title
          AppText(
            widget.entry.title,
            variant: AppTextVariant.bodyTitle,
            align: TextAlign.start,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 6),

          // Message / subtitle
          AppText(
            widget.entry.message,
            variant: AppTextVariant.body,
            color: AppColors.textMuted,
            align: TextAlign.start,
          ),
          const SizedBox(height: 20),

          _buildInputField(),

          const SizedBox(height: 24),

          // Confirm button
          AppButton(
            label: opts.confirmButtonText,
            expanded: true,
            radius: 100,
            onPressed: _value.isNotEmpty ? _handleConfirm : null,
          ),

          // Cancel button
          if (opts.showCancelButton) ...[
            const SizedBox(height: 10),
            AppButton(
              label: opts.cancelButtonText,
              variant: AppButtonVariant.outline,
              expanded: true,
              radius: 100,
              onPressed: () {
                opts.onCancel?.call();
                widget.onDismiss();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFullscreen(InputModalOptions opts) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.background,
      child: SafeArea(
        child: Stack(
          children: [
            // Close button — pinned top-right
            if (opts.showCloseButton)
              Positioned(
                top: 16,
                right: 24,
                child: GestureDetector(
                  onTap: () {
                    opts.onCancel?.call();
                    widget.onDismiss();
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    size: 24,
                    color: AppColors.textMuted,
                  ),
                ),
              ),

            // Centered content: step label, title, message, input
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom + 100,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.sizeOf(context).height * 0.5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (opts.stepLabel != null) ...[
                        AppText(
                          opts.stepLabel!,
                          variant: AppTextVariant.label,
                          color: AppColors.textMuted,
                          align: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: AppText(
                          widget.entry.title,
                          variant: AppTextVariant.bodyTitle,
                          align: TextAlign.center,
                          weight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: AppText(
                          widget.entry.message,
                          variant: AppTextVariant.body,
                          color: AppColors.textMuted,
                          align: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _buildInputField(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Buttons pinned to bottom
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    label: opts.confirmButtonText,
                    expanded: true,
                    radius: 100,
                    onPressed: _value.isNotEmpty ? _handleConfirm : null,
                  ),
                  if (opts.showCancelButton) ...[
                    const SizedBox(height: 10),
                    AppButton(
                      label: opts.cancelButtonText,
                      variant: AppButtonVariant.outline,
                      expanded: true,
                      radius: 100,
                      onPressed: () {
                        opts.onCancel?.call();
                        widget.onDismiss();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
