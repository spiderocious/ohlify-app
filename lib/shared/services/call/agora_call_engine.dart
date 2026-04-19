// Agora-backed [CallEngine] — stub only.
//
// When integrating `agora_rtc_engine`:
//   1. Add `agora_rtc_engine: ^6.x.x` to pubspec.yaml.
//   2. Implement the methods below using `RtcEngine`:
//        - createAgoraRtcEngine()
//        - engine.initialize(RtcEngineContext(appId: ...))
//        - engine.joinChannel(token, channelName, uid, options)
//        - engine.leaveChannel()
//        - engine.muteLocalAudioStream(muted)
//        - engine.setEnableSpeakerphone(enabled)
//        - engine.enableLocalVideo(enabled) + enableVideo()/disableVideo()
//        - engine.switchCamera()
//   3. Register onJoinChannelSuccess / onUserJoined / onUserOffline / onError
//      and map each to the matching [CallEngineEvent] via the controller.
//   4. Swap [MockCallEngine] for this class in [CallSessionProvider].
//
// Until then, callers should use [MockCallEngine].

import 'dart:async';

import 'package:ohlify/shared/services/call/call_engine.dart';

class AgoraCallEngine implements CallEngine {
  AgoraCallEngine({required this.appId});

  final String appId;
  final _controller = StreamController<CallEngineEvent>.broadcast();

  @override
  Stream<CallEngineEvent> get events => _controller.stream;

  @override
  Future<void> join(CallJoinRequest request) async {
    throw UnimplementedError('AgoraCallEngine not wired up yet');
  }

  @override
  Future<void> leave() async {
    throw UnimplementedError('AgoraCallEngine not wired up yet');
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
    await _controller.close();
  }
}
