import 'package:dio/dio.dart';
import 'package:go_sport/core/config/app_config.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(AppConfig config, List<Interceptor> interceptors)
      : _dio = Dio(
        BaseOptions(
          baseUrl: config.apiBaseUrl,
          connectTimeout: config.connectTimeout,
          receiveTimeout: config.receiveTimeout,
        )
       ) {
          _dio.interceptors.addAll(interceptors); // чище

          if (config.enableLogging) {
            _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
          }
      }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.post(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.put(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
  }
}