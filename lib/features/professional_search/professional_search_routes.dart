import 'package:go_router/go_router.dart';

import 'package:ohlify/features/professional_search/screen/professional_search_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final professionalSearchRoutes = [
  GoRoute(
    path: AppRoutes.professionals,
    builder: (context, state) => ProfessionalSearchScreen(
      autofocus: state.uri.queryParameters['focus'] == '1',
    ),
  ),
];
