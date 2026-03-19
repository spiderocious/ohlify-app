import 'package:dio/dio.dart';

import 'package:ohlify/app_router.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/services/token_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenService);
  final TokenService _tokenService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenService.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _tokenService.clear();
      appRouter.go(AppRoutes.root);
      return;
    }
    handler.next(err);
  }
}
