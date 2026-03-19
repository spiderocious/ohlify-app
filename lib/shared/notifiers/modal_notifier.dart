import 'dart:async';

import 'package:flutter/widgets.dart';

// ── Shared enums ──────────────────────────────────────────────────────────────

enum ModalType { feedback, confirmation, input }

enum ModalFeedbackKind { success, error, warning, info }

enum ModalConfirmationKind { neutral, success, error, warning, info }

enum ModalPosition { center, top, bottom, fullscreen }

// ── Options ───────────────────────────────────────────────────────────────────

class FeedbackModalOptions {
  const FeedbackModalOptions({
    this.kind = ModalFeedbackKind.success,
    this.position = ModalPosition.center,
    this.dismissible = true,
    this.showCloseButton = true,
    this.autoDismiss = false,
    this.autoDismissDuration = const Duration(seconds: 4),
    this.icon,
    this.actionLabel,
    this.onAction,
    this.confirmButtonText = 'Done',
    this.barrierColor,
  });

  final ModalFeedbackKind kind;
  final ModalPosition position;
  final bool dismissible;
  final bool showCloseButton;

  /// Auto-dismiss after [autoDismissDuration] when true.
  final bool autoDismiss;
  final Duration autoDismissDuration;

  /// Custom icon widget — overrides the default circle icon.
  final Widget? icon;

  /// Optional secondary action button label below the primary button.
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Primary button label. Defaults to 'Done'.
  final String confirmButtonText;

  /// Scrim / barrier color. Defaults to semi-transparent black.
  final Color? barrierColor;
}

class ConfirmationModalOptions {
  const ConfirmationModalOptions({
    this.kind = ModalConfirmationKind.neutral,
    this.confirmButtonText = 'Confirm',
    this.cancelButtonText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.position = ModalPosition.center,
    this.dismissible = true,
    this.showCloseButton = true,
    this.showCancelButton = true,
    this.showIcon = true,
    this.icon,
    this.destructive = false,
    this.barrierColor,
    this.isLoading = false,
  });

  /// Determines the default icon shown above the title.
  /// Ignored when [icon] is provided or [showIcon] is false.
  final ModalConfirmationKind kind;

  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final ModalPosition position;
  final bool dismissible;
  final bool showCloseButton;
  final bool showCancelButton;

  /// Set to false to hide the icon entirely.
  final bool showIcon;

  /// Custom icon widget — overrides the default kind icon.
  final Widget? icon;

  /// When true, confirm button uses danger styling.
  final bool destructive;

  final Color? barrierColor;

  /// Show loading spinner on confirm button.
  final bool isLoading;
}

class InputModalOptions {
  const InputModalOptions({
    this.placeholder,
    this.confirmButtonText = 'Save and proceed',
    this.cancelButtonText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.inputType = InputModalInputType.text,
    this.regex,
    this.errorMessage,
    this.maxLength,
    this.defaultValue,
    this.multiline = false,
    this.position = ModalPosition.center,
    this.dismissible = true,
    this.showCloseButton = true,
    this.showCancelButton = true,
    this.stepLabel,
    this.barrierColor,
    this.startIcon,
    this.endIcon,
  });

  final String? placeholder;
  final String confirmButtonText;
  final String cancelButtonText;
  final ValueChanged<String>? onConfirm;
  final VoidCallback? onCancel;
  final InputModalInputType inputType;

  /// Validates input — shows [errorMessage] when no match.
  final RegExp? regex;
  final String? errorMessage;
  final int? maxLength;
  final String? defaultValue;

  /// When true uses a multiline textarea-style input.
  final bool multiline;

  final ModalPosition position;
  final bool dismissible;
  final bool showCloseButton;
  final bool showCancelButton;

  /// E.g. '1/4' shown above the title.
  final String? stepLabel;

  final Color? barrierColor;

  /// Leading / trailing icon widgets forwarded to [AppTextInput].
  /// Ignored when [multiline] is true.
  final Widget? startIcon;
  final Widget? endIcon;
}

enum InputModalInputType { text, number, email, password }

// ── Entry & Notifier ──────────────────────────────────────────────────────────

abstract class ModalEntry {
  ModalEntry({required this.id, required this.type});
  final String id;
  final ModalType type;
}

class FeedbackModalEntry extends ModalEntry {
  FeedbackModalEntry({
    required super.id,
    required this.title,
    required this.message,
    required this.options,
  }) : super(type: ModalType.feedback);

  String title;
  String message;
  FeedbackModalOptions options;
}

class ConfirmationModalEntry extends ModalEntry {
  ConfirmationModalEntry({
    required super.id,
    required this.title,
    required this.message,
    required this.options,
  }) : super(type: ModalType.confirmation);

  String title;
  String message;
  ConfirmationModalOptions options;
}

class InputModalEntry extends ModalEntry {
  InputModalEntry({
    required super.id,
    required this.title,
    required this.message,
    required this.options,
  }) : super(type: ModalType.input);

  String title;
  String message;
  InputModalOptions options;
}

// ── Completer wrapper ─────────────────────────────────────────────────────────

class ModalCompleter {
  ModalCompleter(this.entry) : _completer = Completer<void>();

  final ModalEntry entry;
  final Completer<void> _completer;

  void dismiss() {
    if (!_completer.isCompleted) _completer.complete();
  }

  Future<void> get dismissed => _completer.future;
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class ModalNotifier extends ChangeNotifier {
  final List<ModalEntry> _stack = [];
  final Map<String, ModalCompleter> _completers = {};
  int _nextId = 0;

  /// The topmost visible modal (null when none active).
  ModalEntry? get current => _stack.isEmpty ? null : _stack.last;

  ModalCompleter _push(ModalEntry entry) {
    final completer = ModalCompleter(entry);
    _stack.add(entry);
    _completers[entry.id] = completer;
    notifyListeners();
    completer.dismissed.whenComplete(() => _remove(entry.id));
    return completer;
  }

  void _remove(String id) {
    final idx = _stack.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    _stack.removeAt(idx);
    final c = _completers.remove(id);
    if (c != null && !c._completer.isCompleted) c._completer.complete();
    notifyListeners();
  }

  void dismiss(String id) => _remove(id);

  String _newId() => 'modal_${_nextId++}';

  ModalCompleter addFeedback(
    String title,
    String message,
    FeedbackModalOptions options,
  ) {
    final entry = FeedbackModalEntry(
      id: _newId(),
      title: title,
      message: message,
      options: options,
    );
    final c = _push(entry);
    if (options.autoDismiss) {
      Future.delayed(options.autoDismissDuration, () => _remove(entry.id));
    }
    return c;
  }

  ModalCompleter addConfirmation(
    String title,
    String message,
    ConfirmationModalOptions options,
  ) {
    return _push(ConfirmationModalEntry(
      id: _newId(),
      title: title,
      message: message,
      options: options,
    ));
  }

  ModalCompleter addInput(
    String title,
    String message,
    InputModalOptions options,
  ) {
    return _push(InputModalEntry(
      id: _newId(),
      title: title,
      message: message,
      options: options,
    ));
  }
}
