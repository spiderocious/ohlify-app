import 'package:ohlify/shared/types/scheduled_call_item.dart';

/// Payload delivered to [CallEngine.join]. Mirrors the shape Agora uses so
/// swapping in `AgoraCallEngine` later is a drop-in replacement.
class CallJoinRequest {
  const CallJoinRequest({
    required this.channelName,
    required this.token,
    required this.uid,
    required this.kind,
    required this.remoteUid,
  });

  final String channelName;
  final String token;
  final int uid;
  final int remoteUid;
  final CallType kind;
}

sealed class CallEngineEvent {
  const CallEngineEvent();
}

final class CallEngineJoined extends CallEngineEvent {
  const CallEngineJoined();
}

final class CallEngineRemoteJoined extends CallEngineEvent {
  const CallEngineRemoteJoined({required this.remoteUid});
  final int remoteUid;
}

final class CallEngineRemoteLeft extends CallEngineEvent {
  const CallEngineRemoteLeft();
}

final class CallEngineError extends CallEngineEvent {
  const CallEngineError({required this.message});
  final String message;
}

/// Provider-facing interface. [CallSessionNotifier] talks to this only —
/// never directly to Agora or any other RTC SDK.
abstract class CallEngine {
  Stream<CallEngineEvent> get events;

  Future<void> join(CallJoinRequest request);
  Future<void> leave();

  Future<void> toggleMute(bool muted);
  Future<void> toggleSpeaker(bool speakerOn);

  /// Video-only. No-op for audio calls.
  Future<void> toggleCamera(bool enabled);
  Future<void> switchCamera();

  Future<void> dispose();
}
