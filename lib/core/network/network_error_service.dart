import 'dart:async';

/// App-level classification of a failed network request.
///
/// Mapped from `DioException` at the interceptor boundary so nothing above
/// the data layer ever sees Dio types. The user-facing text for each kind is
/// decided at display time (in `MainApp`), not here.
enum NetworkErrorKind { noConnection, timeout, server, unknown }

/// Broadcasts network failures as discrete events (not state).
///
/// A single interceptor pushes into [emit]; a single listener in `MainApp`
/// consumes [onError] and shows one SnackBar — regardless of which screen
/// triggered the request. Modelled as an event stream (not a state field) to
/// avoid the same-value-dedup and manual-reset pitfalls of error-in-state.
class NetworkErrorService {
  final StreamController<dynamic> _controller =
      StreamController<dynamic>.broadcast();

  Stream<dynamic> get onError => _controller.stream;

  void emit(NetworkErrorKind kind) => _controller.add(kind);

  void emitCustomMessage(String message) {
    _controller.add(message);
  }

  void dispose() => _controller.close();
}
