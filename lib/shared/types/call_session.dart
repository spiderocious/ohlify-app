import 'package:ohlify/shared/types/scheduled_call_item.dart';

enum CallRole { caller, callee }

enum CallEndReason { hangup, declined, missed, error }

/// Discrete phases of a live call. Drives UI branching and valid
/// [CallSessionNotifier] transitions.
sealed class CallPhase {
  const CallPhase();
}

/// Caller is dialing, no media yet.
final class CallPhaseDialing extends CallPhase {
  const CallPhaseDialing();
}

/// Callee is being rung, with Accept / Decline affordances.
final class CallPhaseIncoming extends CallPhase {
  const CallPhaseIncoming();
}

/// Accepted, tearing up the media link.
final class CallPhaseConnecting extends CallPhase {
  const CallPhaseConnecting();
}

/// Media is live.
final class CallPhaseActive extends CallPhase {
  const CallPhaseActive({required this.connectedAt});
  final DateTime connectedAt;
}

/// Terminal state.
final class CallPhaseEnded extends CallPhase {
  const CallPhaseEnded({required this.reason, this.connectedAt, this.endedAt});
  final CallEndReason reason;
  final DateTime? connectedAt;
  final DateTime? endedAt;

  Duration? get duration =>
      connectedAt != null && endedAt != null
          ? endedAt!.difference(connectedAt!)
          : null;
}

/// Everything needed to render + drive a call session.
class CallSessionConfig {
  const CallSessionConfig({
    required this.sessionId,
    required this.kind,
    required this.role,
    required this.selfId,
    required this.peerId,
    required this.peerName,
    required this.peerRole,
    this.peerAvatarUrl,
    this.selfAvatarUrl,
  });

  final String sessionId;
  final CallType kind;
  final CallRole role;
  final String selfId;
  final String peerId;
  final String peerName;
  final String peerRole;
  final String? peerAvatarUrl;
  final String? selfAvatarUrl;

  bool get isVideo => kind == CallType.video;
}
