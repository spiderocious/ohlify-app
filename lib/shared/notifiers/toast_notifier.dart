import 'dart:async';

import 'package:flutter/foundation.dart';

// ── Types ─────────────────────────────────────────────────────────────────────

enum ToastType { success, error, warning, info }

enum ToastPosition { top, bottom }

class ToastOptions {
  const ToastOptions({
    this.type = ToastType.success,
    this.position = ToastPosition.top,
    this.duration = const Duration(seconds: 4),
    this.dismissible = true,
    this.icon,
    this.showIcon = true,
    this.sticky = false,
    this.fullWidth = false,
  });

  final ToastType type;
  final ToastPosition position;

  /// How long before auto-dismiss. Ignored when [sticky] is true.
  final Duration duration;

  /// Whether a "Dismiss" button is shown.
  final bool dismissible;

  /// Optional custom leading icon widget. When null the default type icon is used.
  /// Ignored when [showIcon] is false.
  final Object? icon; // Widget — typed as Object to avoid circular imports

  /// Set to false to suppress the leading icon entirely.
  final bool showIcon;

  /// When true the toast stays until manually dismissed.
  final bool sticky;

  /// When true the toast spans the full screen width with no horizontal
  /// margins, no border radius, and touches the top/bottom edge.
  final bool fullWidth;
}

// ── Internal model ─────────────────────────────────────────────────────────────

class ToastCompleter {
  ToastCompleter(this.entry) : _completer = Completer<void>();

  final ToastEntry entry;
  final Completer<void> _completer;

  void dismiss() {
    if (!_completer.isCompleted) _completer.complete();
  }

  Future<void> get dismissed => _completer.future;
}

class ToastEntry {
  ToastEntry({
    required this.id,
    required this.message,
    required this.options,
  });

  final String id;
  final String message;
  final ToastOptions options;
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class ToastNotifier extends ChangeNotifier {
  final List<ToastEntry> _toasts = [];
  final Map<String, ToastCompleter> _completers = {};
  int _nextId = 0;

  List<ToastEntry> get toasts => List.unmodifiable(_toasts);

  /// Add a toast and return a completer for the DrawerHandle.
  ToastCompleter add(String message, ToastOptions options) {
    final id = 'toast_${_nextId++}';
    final entry = ToastEntry(id: id, message: message, options: options);
    final completer = ToastCompleter(entry);

    _toasts.add(entry);
    _completers[id] = completer;
    notifyListeners();

    // Auto-dismiss after duration unless sticky
    if (!options.sticky) {
      Future.delayed(options.duration, () => _dismiss(id));
    }

    // When the handle's dismiss() is called, remove from stack
    completer.dismissed.whenComplete(() => _dismiss(id));

    return completer;
  }

  void _dismiss(String id) {
    final removed = _toasts.indexWhere((t) => t.id == id);
    if (removed == -1) return;
    _toasts.removeAt(removed);
    final completer = _completers.remove(id);
    if (completer != null && !completer._completer.isCompleted) {
      completer._completer.complete();
    }
    notifyListeners();
  }

  /// Called from the widget layer when the user taps Dismiss.
  void dismiss(String id) => _dismiss(id);

  /// Dismiss every active toast.
  void dismissAll() {
    if (_toasts.isEmpty) return;
    final ids = _toasts.map((t) => t.id).toList();
    for (final id in ids) {
      _dismiss(id);
    }
  }
}
