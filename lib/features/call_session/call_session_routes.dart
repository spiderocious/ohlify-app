import 'package:go_router/go_router.dart';

import 'package:ohlify/features/call_session/screen/call_rating_screen.dart';
import 'package:ohlify/features/call_session/screen/call_session_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/types.dart';

final callSessionRoutes = [
  GoRoute(
    // /call/session/:role/:kind/:selfId/:peerId/:sessionId
    path: '${AppRoutes.callSessionBase}/:role/:kind/:selfId/:peerId/:sessionId',
    builder: (context, state) {
      final params = state.pathParameters;
      final role = _roleFromString(params['role']);
      final kind = _kindFromString(params['kind']);
      final sessionId = params['sessionId']!;
      final selfId = params['selfId']!;
      final peerId = params['peerId']!;

      final peer = _lookupPeer(peerId);

      return CallSessionScreen(
        config: CallSessionConfig(
          sessionId: sessionId,
          kind: kind,
          role: role,
          selfId: selfId,
          peerId: peerId,
          peerName: state.uri.queryParameters['name'] ?? peer?.name ?? 'Caller',
          peerRole: peer?.role ?? 'Professional',
          peerAvatarUrl:
              state.uri.queryParameters['avatar'] ?? peer?.avatarUrl,
        ),
      );
    },
  ),
  GoRoute(
    path: '${AppRoutes.callSessionBase}/rating',
    builder: (context, state) {
      final q = state.uri.queryParameters;
      return CallRatingScreen(
        peerName: q['name'] ?? 'Professional',
        peerAvatarUrl: q['avatar'],
      );
    },
  ),
];

CallRole _roleFromString(String? raw) => switch (raw) {
      'caller' => CallRole.caller,
      'callee' => CallRole.callee,
      _ => CallRole.caller,
    };

CallType _kindFromString(String? raw) => switch (raw) {
      'video' => CallType.video,
      _ => CallType.audio,
    };

/// Best-effort profile lookup so deep-links carry a nice name + avatar even
/// when the caller didn't pass query params.
Professional? _lookupPeer(String id) {
  for (final p in MockService.getProfessionals()) {
    if (p.id == id) return p;
  }
  for (final c in MockService.getUpcomingCalls()) {
    if (c.id == id) {
      return Professional(
        id: c.id,
        name: c.name,
        role: c.role,
        rating: c.rating,
        reviewCount: c.reviewCount,
        avatarUrl: c.avatarUrl,
      );
    }
  }
  return null;
}
