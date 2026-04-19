import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:ohlify/shared/services/call/call_engine.dart';
import 'package:ohlify/shared/types/types.dart';

class CallSessionNotifier extends ChangeNotifier {
  CallSessionNotifier({
    required this.config,
    required this.engine,
    this.mockAutoAcceptAfter = const Duration(seconds: 3),
  }) {
    _phase = config.role == CallRole.caller
        ? const CallPhaseDialing()
        : const CallPhaseIncoming();
    _engineSub = engine.events.listen(_onEngineEvent);
    _start();
  }

  final CallSessionConfig config;
  final CallEngine engine;

  /// Mock convenience: in dialing mode we auto-flip to `connecting` after
  /// this delay so a single device can walk through the whole flow. Pass
  /// [Duration.zero] to disable.
  final Duration mockAutoAcceptAfter;

  late CallPhase _phase;
  CallPhase get phase => _phase;

  bool _muted = false;
  bool _speakerOn = false;
  bool _cameraEnabled = true;
  int _remoteUid = 0;

  bool get muted => _muted;
  bool get speakerOn => _speakerOn;
  bool get cameraEnabled => _cameraEnabled;
  int get remoteUid => _remoteUid;

  Timer? _autoAcceptTimer;
  Timer? _elapsedTicker;
  StreamSubscription<CallEngineEvent>? _engineSub;

  // ── Entry-point per role ───────────────────────────────────────────────────

  void _start() {
    if (config.role == CallRole.caller && mockAutoAcceptAfter > Duration.zero) {
      _autoAcceptTimer = Timer(mockAutoAcceptAfter, () {
        // Simulate the callee hitting "Accept".
        if (_phase is CallPhaseDialing) _connect();
      });
    }
  }

  // ── Public actions ─────────────────────────────────────────────────────────

  /// Callee taps Accept.
  void accept() {
    if (_phase is! CallPhaseIncoming) return;
    _connect();
  }

  /// Caller or callee taps Decline / End.
  void hangup() {
    _end(
      _phase is CallPhaseIncoming
          ? CallEndReason.declined
          : CallEndReason.hangup,
    );
  }

  Future<void> toggleMute() async {
    _muted = !_muted;
    notifyListeners();
    await engine.toggleMute(_muted);
  }

  Future<void> toggleSpeaker() async {
    _speakerOn = !_speakerOn;
    notifyListeners();
    await engine.toggleSpeaker(_speakerOn);
  }

  Future<void> toggleCamera() async {
    if (!config.isVideo) return;
    _cameraEnabled = !_cameraEnabled;
    notifyListeners();
    await engine.toggleCamera(_cameraEnabled);
  }

  Future<void> switchCamera() async {
    if (!config.isVideo) return;
    await engine.switchCamera();
  }

  // ── Internal transitions ───────────────────────────────────────────────────

  void _connect() {
    _autoAcceptTimer?.cancel();
    _phase = const CallPhaseConnecting();
    notifyListeners();

    engine.join(
      CallJoinRequest(
        channelName: config.sessionId,
        // Token + uids come from the backend in prod. Mock values here.
        token: 'mock-token',
        uid: config.selfId.hashCode,
        remoteUid: config.peerId.hashCode,
        kind: config.kind,
      ),
    );
  }

  void _onEngineEvent(CallEngineEvent event) {
    switch (event) {
      case CallEngineJoined():
        // Local join OK. Still waiting for the remote peer.
        break;
      case CallEngineRemoteJoined(:final remoteUid):
        _remoteUid = remoteUid;
        if (_phase is CallPhaseConnecting) {
          _phase = CallPhaseActive(connectedAt: DateTime.now());
          _startElapsedTicker();
          notifyListeners();
        }
      case CallEngineRemoteLeft():
        if (_phase is CallPhaseActive) {
          _end(CallEndReason.hangup);
        }
      case CallEngineError(:final message):
        debugPrint('[CallSession] engine error: $message');
        _end(CallEndReason.error);
    }
  }

  void _startElapsedTicker() {
    _elapsedTicker?.cancel();
    // The ticker only exists so listeners rebuild each second to refresh
    // the duration label — the duration itself is computed from
    // `connectedAt` on demand.
    _elapsedTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_phase is CallPhaseActive) notifyListeners();
    });
  }

  void _end(CallEndReason reason) {
    _autoAcceptTimer?.cancel();
    _elapsedTicker?.cancel();
    final connectedAt = switch (_phase) {
      CallPhaseActive(:final connectedAt) => connectedAt,
      _ => null,
    };
    _phase = CallPhaseEnded(
      reason: reason,
      connectedAt: connectedAt,
      endedAt: DateTime.now(),
    );
    notifyListeners();
    engine.leave();
  }

  // ── Helpers for the UI ─────────────────────────────────────────────────────

  Duration get elapsed {
    return switch (_phase) {
      CallPhaseActive(:final connectedAt) =>
        DateTime.now().difference(connectedAt),
      CallPhaseEnded(:final duration) => duration ?? Duration.zero,
      _ => Duration.zero,
    };
  }

  String get elapsedLabel {
    final d = elapsed;
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hh = d.inHours;
    return hh > 0 ? '${hh.toString().padLeft(2, '0')}:$mm:$ss' : '$mm:$ss';
  }

  @override
  void dispose() {
    _autoAcceptTimer?.cancel();
    _elapsedTicker?.cancel();
    _engineSub?.cancel();
    engine.dispose();
    super.dispose();
  }
}
