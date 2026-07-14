import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/state/user_state.dart';

import '../../domain/state/like_registry.dart';
import '../di/auth_providers.dart';
import '../di/push_providers.dart';
import '../di/repository_providers.dart';
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
      Future.microtask(() {
        ref.read(likeRegistryProvider.notifier).initSession();
      });
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
    ref.read(likeRegistryProvider.notifier).initSession();
  }

  /// Signs in with Google and establishes the session. Shared by the login and
  /// registration screens — the button lives on both, so the orchestration
  /// belongs to the auth owner, not to a single screen controller.
  /// Returns `true` on success, `false` if the user canceled the Google prompt.
  /// Throws on any real failure — callers wrap with their own loading/error.
  Future<bool> loginWithGoogle() async {
    final accessToken = await ref
        .read(googleAuthServiceProvider)
        .signInAndGetAccessToken();
    if (accessToken == null) return false;

    final result = await ref
        .read(authRepositoryProvider)
        .loginWithGoogle(accessToken: accessToken);
    await login(result.jwt);
    ref.read(pushServiceProvider).register().ignore();
    return true;
  }

  // Future<void> logout() async {
  //   final tokenStorage = ref.read(tokenStorageProvider);
  //   final pushService = ref.read(pushServiceProvider);

  //   // Backend cleanup (device delete) — fire-and-forget, doesn't block logout
  //   pushService.unregister().ignore();

  //   // Clear likes (no API calls — just state reset)
  //   ref.read(likeRegistryProvider.notifier).clear();

  //   // Local logout
  //   await tokenStorage.clearTokens();
  //   state = const AuthState.unauthorized();
  // }

  Future<void> logout() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final pushService = ref.read(pushServiceProvider);

    // 1. Await the backend cleanup safely so it goes out WITH the active token headers
    try {
      await pushService.unregister();
    } catch (e) {
      // Log the error but don't block the user from logging out locally if the network fails
      print('Failed to unregister push device on backend: $e');
    }

    // 2. Clear likes
    ref.read(likeRegistryProvider.notifier).clear();
    ref.read(userStateProvider.notifier).resetUser();
    // 3. Local logout happens only after the delete request has cleared the gate
    await tokenStorage.clearTokens();
    state = const AuthState.unauthorized();
  }
}

// === Provider ===

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
