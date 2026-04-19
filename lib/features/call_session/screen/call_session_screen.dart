import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/call_session/providers/call_session_notifier.dart';
import 'package:ohlify/features/call_session/screen/parts/active_audio_body.dart';
import 'package:ohlify/features/call_session/screen/parts/active_video_body.dart';
import 'package:ohlify/features/call_session/screen/parts/call_blurred_backdrop.dart';
import 'package:ohlify/features/call_session/screen/parts/dialing_body.dart';
import 'package:ohlify/features/call_session/screen/parts/feedback_bubble.dart';
import 'package:ohlify/features/call_session/screen/parts/incoming_body.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/services/call/call_engine.dart';
import 'package:ohlify/shared/services/call/mock_call_engine.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/types.dart';

/// Wraps the live-call UI and feedback flow. Owns its own
/// [CallSessionNotifier] + [CallEngine]; both are disposed when the route
/// is popped.
class CallSessionScreen extends StatefulWidget {
  const CallSessionScreen({super.key, required this.config});

  final CallSessionConfig config;

  @override
  State<CallSessionScreen> createState() => _CallSessionScreenState();
}

enum _FeedbackStep { none, emoji, description }

class _CallSessionScreenState extends State<CallSessionScreen> {
  late final CallEngine _engine;
  late final CallSessionNotifier _notifier;

  _FeedbackStep _feedbackStep = _FeedbackStep.none;
  bool _ratingRoutePushed = false;

  @override
  void initState() {
    super.initState();
    _engine = MockCallEngine();
    _notifier = CallSessionNotifier(config: widget.config, engine: _engine)
      ..addListener(_onNotifierChanged);
  }

  void _onNotifierChanged() {
    final phase = _notifier.phase;
    if (phase is! CallPhaseEnded) return;
    if (_feedbackStep != _FeedbackStep.none) return;

    // No connection ever happened → user declined, cancelled dialing, or the
    // call was missed. Skip feedback + rating entirely and leave.
    if (phase.connectedAt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.go(AppRoutes.home);
      });
      return;
    }

    setState(() => _feedbackStep = _FeedbackStep.emoji);
  }

  @override
  void dispose() {
    _notifier.removeListener(_onNotifierChanged);
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Block the system back gesture while the call is live so users don't
      // accidentally drop a call — they must use the end-call button.
      canPop: _notifier.phase is CallPhaseEnded,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _notifier.phase is! CallPhaseEnded) {
          // Silent — we just absorb the pop. Hang up via the end button.
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedBuilder(
          animation: _notifier,
          builder: (context, _) {
            return Stack(
              fit: StackFit.expand,
              children: [
                _buildBody(),
                if (_feedbackStep != _FeedbackStep.none) _buildFeedbackOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    final phase = _notifier.phase;
    return switch (phase) {
      CallPhaseDialing() => DialingBody(notifier: _notifier),
      CallPhaseIncoming() => IncomingBody(notifier: _notifier),
      CallPhaseConnecting() || CallPhaseActive() => widget.config.isVideo
          ? ActiveVideoBody(notifier: _notifier)
          : ActiveAudioBody(notifier: _notifier),
      // Once ended we keep the last visual behind the feedback bubbles.
      CallPhaseEnded() => _EndedBackdrop(config: widget.config),
    };
  }

  Widget _buildFeedbackOverlay() {
    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.55),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              reverse: true,
              child: _feedbackStep == _FeedbackStep.emoji
                  ? EmojiFeedbackBubble(
                      onSubmit: (_) => _submitEmojiFeedback(),
                      onAddFeedback: (_) => setState(
                        () => _feedbackStep = _FeedbackStep.description,
                      ),
                      onSkip: _goToRating,
                    )
                  : DescriptionFeedbackBubble(
                      onSubmit: (_) => _submitEmojiFeedback(),
                      onSkip: _goToRating,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitEmojiFeedback() {
    // Show the "Feedback submitted" center modal, then when it fully
    // dismisses (Done tapped), push the rating screen.
    var confirmed = false;
    final handle = DrawerService.instance.showFeedbackModal(
      'Feedback submitted',
      'Thank you for sharing how you feel with us, we take all feedbacks seriously and will now review.',
      options: FeedbackModalOptions(
        kind: ModalFeedbackKind.success,
        showCloseButton: false,
        onConfirm: () => confirmed = true,
      ),
    );
    handle.onDismissed.then((_) {
      if (confirmed) _goToRating();
    });
  }

  void _goToRating() {
    if (_ratingRoutePushed || !mounted) return;
    _ratingRoutePushed = true;
    context.pushReplacement(
      '${AppRoutes.callSessionBase}/rating'
      '?name=${Uri.encodeComponent(widget.config.peerName)}'
      '${widget.config.peerAvatarUrl != null ? '&avatar=${Uri.encodeComponent(widget.config.peerAvatarUrl!)}' : ''}',
    );
  }
}

class _EndedBackdrop extends StatelessWidget {
  const _EndedBackdrop({required this.config});

  final CallSessionConfig config;

  @override
  Widget build(BuildContext context) {
    return CallBlurredBackdrop(url: config.peerAvatarUrl);
  }
}
