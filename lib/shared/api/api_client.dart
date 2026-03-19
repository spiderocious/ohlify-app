import 'package:dio/dio.dart';

import 'package:ohlify/shared/api/auth_interceptor.dart';
import 'package:ohlify/shared/api/error_interceptor.dart';
import 'package:ohlify/shared/config/env.dart';
import 'package:ohlify/shared/services/token_service.dart';

class ApiClient {
  ApiClient({required this.tokenService}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: Env.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _dio.interceptors.addAll([
      AuthInterceptor(tokenService),
      ErrorInterceptor(),
    ]);
  }

  final TokenService tokenService;
  late final Dio _dio;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    required T Function(dynamic) fromJson,
  }) async {
    final response = await _dio.get<dynamic>(path, queryParameters: queryParams);
    return fromJson(response.data);
  }

  Future<T> post<T>(
    String path,
    Map<String, dynamic> body, {
    required T Function(dynamic) fromJson,
  }) async {
    final response = await _dio.post<dynamic>(path, data: body);
    return fromJson(response.data);
  }

  Future<T> patch<T>(
    String path,
    Map<String, dynamic> body, {
    required T Function(dynamic) fromJson,
  }) async {
    final response = await _dio.patch<dynamic>(path, data: body);
    return fromJson(response.data);
  }

  Future<T> delete<T>(
    String path, {
    required T Function(dynamic) fromJson,
  }) async {
    final response = await _dio.delete<dynamic>(path);
    return fromJson(response.data);
  }
}
