import 'package:go_router/go_router.dart';

import 'package:ohlify/features/professional_details/screen/professional_details_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final professionalDetailsRoutes = [
  GoRoute(
    path: '${AppRoutes.professional}/:professionalId',
    builder: (context, state) => ProfessionalDetailsScreen(
      professionalId: state.pathParameters['professionalId']!,
    ),
  ),
];
