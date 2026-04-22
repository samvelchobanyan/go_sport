import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'token_storage.dart';

part 'auth_state.freezed.dart';

// === State ===

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.unauthorized() = AuthUnauthorized;
  const factory AuthState.guest() = AuthGuest;
  const factory AuthState.authenticated({
    required String name,
    required String avatarUrl,
    required int userId,
  }) = AuthAuthenticated;
}

// === Notifier ===

class AuthNotifier extends Notifier<AuthState> {

  @override
  AuthState build() {
    final tokenStorage = ref.watch(tokenStorageProvider);

    if (tokenStorage.accessToken != null) {
      return const AuthState.authenticated(name: '', avatarUrl: '', userId: 0);
    }
    if (tokenStorage.choseGuest) {
      return const AuthState.guest();
    }
    return const AuthState.unauthorized();
  }

  void setUser({
    required String name,
    required String avatarUrl,
    required int userId,
  }) {
    state = AuthState.authenticated(
      name: name,
      avatarUrl: avatarUrl,
      userId: userId,
    );
  }

  void continueAsGuest() {
    final tokenStorage = ref.watch(tokenStorageProvider);
    tokenStorage.setChoseGuest();
    state = const AuthState.guest();
  }

  Future<void> logout() async {
    final tokenStorage = ref.watch(tokenStorageProvider);
    await tokenStorage.clearTokens();
    state = const AuthState.unauthorized();
    ref.invalidateSelf();
  }
}

// === Provider ===

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
