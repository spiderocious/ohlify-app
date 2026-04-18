import 'package:go_router/go_router.dart';

import 'package:ohlify/features/schedule_call/screen/schedule_call_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final scheduleCallRoutes = [
  GoRoute(
    path: '${AppRoutes.scheduleCall}/:professionalId',
    builder: (context, state) => ScheduleCallScreen(
      professionalId: state.pathParameters['professionalId']!,
    ),
  ),
];
