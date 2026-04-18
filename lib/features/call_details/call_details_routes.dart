import 'package:go_router/go_router.dart';

import 'package:ohlify/features/call_details/screen/call_details_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final callDetailsRoutes = [
  GoRoute(
    path: '${AppRoutes.call}/:callId',
    builder: (context, state) => CallDetailsScreen(
      callId: state.pathParameters['callId']!,
    ),
  ),
];
