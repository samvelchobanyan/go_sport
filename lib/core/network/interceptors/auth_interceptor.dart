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

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final isPublic = err.requestOptions.extra['public'] == true;
    final isUnauthorized = err.response?.statusCode == 401;

    // A 401 on an authenticated request means the token is expired/invalid.
    // Drop the tokens; TokenStorage notifies the router, which redirects to
    // login. Public/auth-flow requests (e.g. login itself) are excluded so a
    // wrong-password 401 doesn't wipe an existing session.
    if (isUnauthorized && !isPublic && _tokenStorage.accessToken != null) {
      _tokenStorage.clearTokens();
    }

    handler.next(err);
  }
}