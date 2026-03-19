import 'package:go_router/go_router.dart';

import 'package:ohlify/features/component_preview/screen/component_preview_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final componentPreviewRoutes = [
  GoRoute(
    path: AppRoutes.componentPreview,
    builder: (context, state) => const ComponentPreviewScreen(),
  ),
];
