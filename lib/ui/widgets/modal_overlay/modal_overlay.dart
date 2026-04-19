import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/ui/widgets/app_confirmation_modal/app_confirmation_modal.dart';
import 'package:ohlify/ui/widgets/app_custom_modal/app_custom_modal.dart';
import 'package:ohlify/ui/widgets/app_feedback_modal/app_feedback_modal.dart';
import 'package:ohlify/ui/widgets/app_input_modal/app_input_modal.dart';

/// Wraps [child] and renders the active modal (if any) on top with a scrim.
/// Place this high in the widget tree, above [ToastOverlay].
class ModalOverlay extends StatelessWidget {
  const ModalOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        _ModalStack(),
      ],
    );
  }
}

class _ModalStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ModalNotifier>();
    final entry = notifier.current;
    if (entry == null) return const SizedBox.shrink();

    final position = _positionOf(entry);
    final barrierColor = _barrierColorOf(entry) ?? Colors.black54;
    final dismissible = _dismissibleOf(entry);
    final isFullscreen = position == ModalPosition.fullscreen;

    void dismiss() => notifier.dismiss(entry.id);

    final modalWidget = _buildModal(entry, dismiss, isFullscreen: isFullscreen);

    Widget body;

    if (isFullscreen) {
      // Fullscreen: modal fills the whole screen, no scrim tap-to-dismiss
      body = _AnimatedModal(
        key: ValueKey(entry.id),
        position: position,
        child: Material(
          color: Colors.transparent,
          child: modalWidget,
        ),
      );
    } else {
      final alignment = switch (position) {
        ModalPosition.top => Alignment.topCenter,
        ModalPosition.bottom => Alignment.bottomCenter,
        ModalPosition.center => Alignment.center,
        ModalPosition.fullscreen => Alignment.center,
      };

      final viewInsets = MediaQuery.viewInsetsOf(context);
      // Reserve space at the bottom equal to the keyboard height so the
      // modal lives above the keyboard regardless of its anchor. A small
      // gap is added for bottom-anchored modals so they don't sit flush to
      // the keyboard top edge.
      final bottomPadding = viewInsets.bottom +
          (position == ModalPosition.bottom && viewInsets.bottom > 0 ? 8.0 : 0.0);

      body = _AnimatedModal(
        key: ValueKey(entry.id),
        position: position,
        child: GestureDetector(
          onTap: dismissible ? dismiss : null,
          behavior: HitTestBehavior.opaque,
          child: Container(
            color: barrierColor,
            // The padding shrinks the alignment viewport from the bottom so
            // the modal is laid out inside the *visible* area (above the
            // keyboard), not behind it.
            padding: EdgeInsets.only(bottom: bottomPadding),
            alignment: alignment,
            child: GestureDetector(
              // Prevent taps on the modal itself from dismissing.
              onTap: () {},
              child: SafeArea(
                // The SafeArea should not add extra bottom inset when the
                // keyboard is up — we've already reserved that space above.
                bottom: viewInsets.bottom == 0,
                child: SingleChildScrollView(
                  child: Material(
                    color: Colors.transparent,
                    child: modalWidget,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // We wrap the body in a nested [Overlay] so descendant widgets that
    // need one (e.g. dropdown popups, text-field magnifier) can still find
    // `Overlay.of(context)` from inside a modal.
    //
    // Trick: keyed by the entry id so each new modal gets a *fresh* Overlay
    // instance. Overlay only consumes `initialEntries` on first mount, so
    // without the key it would hold onto the first modal forever and swallow
    // every subsequent push (chained modals like "edit email → OTP" never
    // appeared before this fix).
    return Positioned.fill(
      child: Overlay(
        key: ValueKey('modal-overlay-${entry.id}'),
        initialEntries: [
          OverlayEntry(builder: (_) => body),
        ],
      ),
    );
  }

  ModalPosition _positionOf(ModalEntry entry) => switch (entry) {
        final FeedbackModalEntry e => e.options.position,
        final ConfirmationModalEntry e => e.options.position,
        final InputModalEntry e => e.options.position,
        final CustomModalEntry e => e.options.position,
        _ => ModalPosition.center,
      };

  Color? _barrierColorOf(ModalEntry entry) => switch (entry) {
        final FeedbackModalEntry e => e.options.barrierColor,
        final ConfirmationModalEntry e => e.options.barrierColor,
        final InputModalEntry e => e.options.barrierColor,
        final CustomModalEntry e => e.options.barrierColor,
        _ => null,
      };

  bool _dismissibleOf(ModalEntry entry) => switch (entry) {
        final FeedbackModalEntry e => e.options.dismissible,
        final ConfirmationModalEntry e => e.options.dismissible,
        final InputModalEntry e => e.options.dismissible,
        final CustomModalEntry e => e.options.dismissible,
        _ => true,
      };

  Widget _buildModal(
    ModalEntry entry,
    VoidCallback onDismiss, {
    required bool isFullscreen,
  }) {
    return switch (entry) {
      final FeedbackModalEntry e =>
        AppFeedbackModal(entry: e, onDismiss: onDismiss, isFullscreen: isFullscreen),
      final ConfirmationModalEntry e =>
        AppConfirmationModal(entry: e, onDismiss: onDismiss, isFullscreen: isFullscreen),
      final InputModalEntry e =>
        AppInputModal(entry: e, onDismiss: onDismiss, isFullscreen: isFullscreen),
      final CustomModalEntry e =>
        AppCustomModal(entry: e, onDismiss: onDismiss, isFullscreen: isFullscreen),
      _ => const SizedBox.shrink(),
    };
  }
}

// ── Slide+fade entrance animation ─────────────────────────────────────────────

class _AnimatedModal extends StatefulWidget {
  const _AnimatedModal({
    super.key,
    required this.child,
    required this.position,
  });

  final Widget child;
  final ModalPosition position;

  @override
  State<_AnimatedModal> createState() => _AnimatedModalState();
}

class _AnimatedModalState extends State<_AnimatedModal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    // Fullscreen slides up from bottom like a sheet
    final begin = switch (widget.position) {
      ModalPosition.bottom => const Offset(0, 0.15),
      ModalPosition.top => const Offset(0, -0.15),
      ModalPosition.center => const Offset(0, 0.06),
      ModalPosition.fullscreen => const Offset(0, 1.0),
    };

    _slide = Tween<Offset>(begin: begin, end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
