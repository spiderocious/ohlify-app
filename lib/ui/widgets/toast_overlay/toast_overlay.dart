import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/ui/widgets/app_toast/app_toast.dart';

/// Wraps [child] and renders any active toasts on top, stacked vertically.
/// Place this high in the widget tree (e.g. inside [MaterialApp.builder]).
class ToastOverlay extends StatelessWidget {
  const ToastOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        _ToastStack(),
      ],
    );
  }
}

class _ToastStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ToastNotifier>();
    final toasts = notifier.toasts;

    if (toasts.isEmpty) return const SizedBox.shrink();

    // Split by position and fullWidth
    final topNormal = toasts
        .where((t) => t.options.position == ToastPosition.top && !t.options.fullWidth)
        .toList();
    final bottomNormal = toasts
        .where((t) => t.options.position == ToastPosition.bottom && !t.options.fullWidth)
        .toList();
    final topFull = toasts
        .where((t) => t.options.position == ToastPosition.top && t.options.fullWidth)
        .toList();
    final bottomFull = toasts
        .where((t) => t.options.position == ToastPosition.bottom && t.options.fullWidth)
        .toList();

    final padding = MediaQuery.paddingOf(context);

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: false,
        child: Stack(
          children: [
            // Top normal — slide in from above
            if (topNormal.isNotEmpty)
              Positioned(
                top: padding.top + 12,
                left: 16,
                right: 16,
                child: _ToastColumn(
                  toasts: topNormal,
                  notifier: notifier,
                  isBottom: false,
                ),
              ),

            // Bottom normal — slide in from below
            if (bottomNormal.isNotEmpty)
              Positioned(
                bottom: padding.bottom + 12,
                left: 16,
                right: 16,
                child: _ToastColumn(
                  toasts: bottomNormal,
                  notifier: notifier,
                  reverse: true,
                  isBottom: true,
                ),
              ),

            // Top full-width — flush to top edge, slide in from above
            if (topFull.isNotEmpty)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _ToastColumn(
                  toasts: topFull,
                  notifier: notifier,
                  isBottom: false,
                ),
              ),

            // Bottom full-width — flush to bottom edge, slide in from below
            if (bottomFull.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _ToastColumn(
                  toasts: bottomFull,
                  notifier: notifier,
                  reverse: true,
                  isBottom: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ToastColumn extends StatelessWidget {
  const _ToastColumn({
    required this.toasts,
    required this.notifier,
    required this.isBottom,
    this.reverse = false,
  });

  final List<ToastEntry> toasts;
  final ToastNotifier notifier;
  final bool reverse;
  final bool isBottom;

  @override
  Widget build(BuildContext context) {
    final items = reverse ? toasts.reversed.toList() : toasts;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          _AnimatedToast(
            key: ValueKey(items[i].id),
            entry: items[i],
            isBottom: isBottom,
            onDismiss: () => notifier.dismiss(items[i].id),
          ),
          if (i < items.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _AnimatedToast extends StatefulWidget {
  const _AnimatedToast({
    super.key,
    required this.entry,
    required this.onDismiss,
    required this.isBottom,
  });

  final ToastEntry entry;
  final VoidCallback onDismiss;
  final bool isBottom;

  @override
  State<_AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<_AnimatedToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    // Top toasts slide down from above (negative y), bottom toasts slide up from below (positive y)
    _slide = Tween<Offset>(
      begin: Offset(0, widget.isBottom ? 0.3 : -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

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
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: AppToast(
          entry: widget.entry,
          onDismiss: widget.onDismiss,
        ),
      ),
    );
  }
}
