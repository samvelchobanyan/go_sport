import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../di/push_providers.dart';
import 'token_storage.dart';

part 'auth_state.freezed.dart';

// === State ===

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.unauthorized() = AuthUnauthorized;
  const factory AuthState.guest() = AuthGuest;
  const factory AuthState.authenticated() = AuthAuthenticated;
}

// === Notifier ===

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    final tokenStorage = ref.watch(tokenStorageProvider);
    if (tokenStorage.accessToken != null) {
      return const AuthState.authenticated();
    }
    if (tokenStorage.choseGuest) {
      return const AuthState.guest();
    }
    return const AuthState.unauthorized();
  }

  void continueAsGuest() {
    final tokenStorage = ref.read(tokenStorageProvider);
    tokenStorage.setChoseGuest();
    state = const AuthState.guest();
  }

  Future<void> login(String jwt) async {
    final tokenStorage = ref.read(tokenStorageProvider);
    await tokenStorage.saveTokens(accessToken: jwt, refreshToken: '');
    state = const AuthState.authenticated();
  }

  Future<void> logout() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final pushService = ref.read(pushServiceProvider);

    // Backend cleanup (device delete) — fire-and-forget, doesn't block logout
    pushService.unregister().ignore();

    // Local logout
    await tokenStorage.clearTokens();
    state = const AuthState.unauthorized();
  }
}

// === Provider ===

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
