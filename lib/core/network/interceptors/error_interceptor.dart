import 'package:dio/dio.dart';
import 'package:go_sport/core/network/network_error_service.dart';

/// Emits an app-level [NetworkErrorKind] for failed mutations so a single
/// listener can show one SnackBar. Never swallows the error — it always calls
/// `handler.next(err)` so call sites can still react (e.g. optimistic rollback).
///
/// GET requests are skipped: their errors are surfaced by the screen itself
/// (loading → error state → Retry). A request may also opt out explicitly with
/// `extra['silent'] = true` when it handles its own failure.
class ErrorInterceptor extends Interceptor {
  final NetworkErrorService _errorService;

  ErrorInterceptor(this._errorService);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final method = err.requestOptions.method.toUpperCase();
    final silent = err.requestOptions.extra['silent'] == true;

    if (method != 'GET' && !silent) {
      _errorService.emit(_classify(err));
    }

    handler.next(err);
  }

  NetworkErrorKind _classify(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
        return NetworkErrorKind.noConnection;
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkErrorKind.timeout;
      case DioExceptionType.badResponse:
        final status = err.response?.statusCode ?? 0;
        return status >= 500 ? NetworkErrorKind.server : NetworkErrorKind.unknown;
      default:
        return NetworkErrorKind.unknown;
    }
  }
}
