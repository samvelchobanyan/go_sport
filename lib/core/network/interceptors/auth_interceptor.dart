import 'package:dio/dio.dart';
import 'package:go_sport/core/auth/token_storage.dart';

class AuthInterceptor extends Interceptor{
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if(options.extra['public'] != true){
      final accessToken = _tokenStorage.accessToken;
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    
    handler.next(options);
  }

}