import 'package:go_router/go_router.dart';

import 'package:ohlify/features/role_selection/screen/role_selection_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final roleSelectionRoutes = [
  GoRoute(
    path: AppRoutes.roleSelection,
    builder: (context, state) => const RoleSelectionScreen(),
  ),
];
