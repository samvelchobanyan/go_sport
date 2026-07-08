import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides a simple boolean online/offline state.
/// Watch `connectivityProvider` and show a replacement UI when it is false.
final initialConnectivityProvider = Provider<bool>((ref) => true);

final connectivityProvider = NotifierProvider<ConnectivityNotifier, bool>(
  ConnectivityNotifier.new,
);

class ConnectivityNotifier extends Notifier<bool> {
  late final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _sub;

  @override
  bool build() {
    _connectivity = Connectivity();
    // Use an initial hint (overridable from main) to avoid a race where
    // networked screens build before the first async check completes.
    final initial = ref.read(initialConnectivityProvider);
    state = initial;
    _init();
    return state;
  }

  Future<void> _init() async {
    try {
      final result = await _connectivity.checkConnectivity();
      state = result != ConnectivityResult.none;
    } catch (_) {
      state = true;
    }

    _sub = _connectivity.onConnectivityChanged.listen((result) {
      state = result != ConnectivityResult.none;
    });

    ref.onDispose(() {
      _sub?.cancel();
    });
  }
}
