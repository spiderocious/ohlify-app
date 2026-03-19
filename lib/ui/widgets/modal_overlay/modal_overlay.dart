import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/ui/widgets/app_confirmation_modal/app_confirmation_modal.dart';
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

    // Resolve position
    final position = _positionOf(entry);
    final barrierColor = _barrierColorOf(entry) ?? Colors.black54;
    final dismissible = _dismissibleOf(entry);

    void dismiss() => notifier.dismiss(entry.id);

    final modalWidget = _buildModal(entry, dismiss);

    final alignment = switch (position) {
      ModalPosition.top => Alignment.topCenter,
      ModalPosition.bottom => Alignment.bottomCenter,
      ModalPosition.center => Alignment.center,
    };

    return Positioned.fill(
      child: _AnimatedModal(
        key: ValueKey(entry.id),
        position: position,
        child: GestureDetector(
          onTap: dismissible ? dismiss : null,
          behavior: HitTestBehavior.opaque,
          child: Container(
            color: barrierColor,
            alignment: alignment,
            child: GestureDetector(
              // Prevent taps on the modal itself from dismissing
              onTap: () {},
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.viewInsetsOf(context).bottom,
                    ),
                    child: modalWidget,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ModalPosition _positionOf(ModalEntry entry) => switch (entry) {
        final FeedbackModalEntry e => e.options.position,
        final ConfirmationModalEntry e => e.options.position,
        final InputModalEntry e => e.options.position,
        _ => ModalPosition.center,
      };

  Color? _barrierColorOf(ModalEntry entry) => switch (entry) {
        final FeedbackModalEntry e => e.options.barrierColor,
        final ConfirmationModalEntry e => e.options.barrierColor,
        final InputModalEntry e => e.options.barrierColor,
        _ => null,
      };

  bool _dismissibleOf(ModalEntry entry) => switch (entry) {
        final FeedbackModalEntry e => e.options.dismissible,
        final ConfirmationModalEntry e => e.options.dismissible,
        final InputModalEntry e => e.options.dismissible,
        _ => true,
      };

  Widget _buildModal(ModalEntry entry, VoidCallback onDismiss) {
    return switch (entry) {
      final FeedbackModalEntry e =>
        AppFeedbackModal(entry: e, onDismiss: onDismiss),
      final ConfirmationModalEntry e =>
        AppConfirmationModal(entry: e, onDismiss: onDismiss),
      final InputModalEntry e =>
        AppInputModal(entry: e, onDismiss: onDismiss),
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

    // Bottom modals slide up, top slide down, center scale up slightly
    final begin = switch (widget.position) {
      ModalPosition.bottom => const Offset(0, 0.15),
      ModalPosition.top => const Offset(0, -0.15),
      ModalPosition.center => const Offset(0, 0.06),
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
