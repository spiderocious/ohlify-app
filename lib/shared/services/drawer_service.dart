import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';

/// A handle returned by every DrawerService call.
class DrawerHandle {
  DrawerHandle._({
    required void Function() onDismiss,
    required Future<void> dismissed,
  })  : _onDismiss = onDismiss,
        _dismissed = dismissed;

  final void Function() _onDismiss;
  final Future<void> _dismissed;

  void dismiss() => _onDismiss();
  Future<void> get onDismissed => _dismissed;
}

/// Central service for showing toasts and modals.
/// Obtain via [DrawerService.instance].
class DrawerService {
  DrawerService._();
  static final instance = DrawerService._();

  ToastNotifier? _toastNotifier;
  ModalNotifier? _modalNotifier;

  void init(ToastNotifier notifier) => _toastNotifier = notifier;
  void initModal(ModalNotifier notifier) => _modalNotifier = notifier;

  // ── Toast ──────────────────────────────────────────────────────────────────

  DrawerHandle toast(
    String message, {
    ToastOptions options = const ToastOptions(),
  }) {
    assert(_toastNotifier != null,
        'DrawerService not initialised — call init() first.');
    final c = _toastNotifier!.add(message, options);
    return DrawerHandle._(onDismiss: c.dismiss, dismissed: c.dismissed);
  }

  // ── Feedback modal ─────────────────────────────────────────────────────────

  DrawerHandle showFeedbackModal(
    String title,
    String message, {
    FeedbackModalOptions options = const FeedbackModalOptions(),
  }) {
    assert(_modalNotifier != null,
        'DrawerService not initialised — call initModal() first.');
    final c = _modalNotifier!.addFeedback(title, message, options);
    return DrawerHandle._(onDismiss: c.dismiss, dismissed: c.dismissed);
  }

  // ── Confirmation modal ─────────────────────────────────────────────────────

  DrawerHandle showConfirmationModal(
    String title,
    String message, {
    ConfirmationModalOptions options = const ConfirmationModalOptions(),
  }) {
    assert(_modalNotifier != null,
        'DrawerService not initialised — call initModal() first.');
    final c = _modalNotifier!.addConfirmation(title, message, options);
    return DrawerHandle._(onDismiss: c.dismiss, dismissed: c.dismissed);
  }

  // ── Input modal ────────────────────────────────────────────────────────────

  DrawerHandle showInputModal(
    String title,
    String message, {
    InputModalOptions options = const InputModalOptions(),
  }) {
    assert(_modalNotifier != null,
        'DrawerService not initialised — call initModal() first.');
    final c = _modalNotifier!.addInput(title, message, options);
    return DrawerHandle._(onDismiss: c.dismiss, dismissed: c.dismissed);
  }
}
