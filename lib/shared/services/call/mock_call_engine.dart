import 'dart:async';

import 'package:ohlify/shared/services/call/call_engine.dart';

/// In-memory stand-in for a real RTC engine. Emits `joined` ~200ms after
/// [join] and `remoteJoined` ~600ms after. Toggles are no-ops. Replaced by
/// `AgoraCallEngine` when the SDK is integrated.
class MockCallEngine implements CallEngine {
  MockCallEngine();

  final _controller = StreamController<CallEngineEvent>.broadcast();
  Timer? _joinedTimer;
  Timer? _remoteTimer;
  bool _disposed = false;

  @override
  Stream<CallEngineEvent> get events => _controller.stream;

  @override
  Future<void> join(CallJoinRequest request) async {
    if (_disposed) return;
    _joinedTimer?.cancel();
    _remoteTimer?.cancel();

    _joinedTimer = Timer(const Duration(milliseconds: 200), () {
      if (!_controller.isClosed) _controller.add(const CallEngineJoined());
    });

    _remoteTimer = Timer(const Duration(milliseconds: 600), () {
      if (!_controller.isClosed) {
        _controller.add(
          CallEngineRemoteJoined(remoteUid: request.remoteUid),
        );
      }
    });
  }

  @override
  Future<void> leave() async {
    _joinedTimer?.cancel();
    _remoteTimer?.cancel();
    if (!_controller.isClosed) {
      _controller.add(const CallEngineRemoteLeft());
    }
  }

  @override
  Future<void> toggleMute(bool muted) async {}

  @override
  Future<void> toggleSpeaker(bool speakerOn) async {}

  @override
  Future<void> toggleCamera(bool enabled) async {}

  @override
  Future<void> switchCamera() async {}

  @override
  Future<void> dispose() async {
    _disposed = true;
    _joinedTimer?.cancel();
    _remoteTimer?.cancel();
    await _controller.close();
  }
}
