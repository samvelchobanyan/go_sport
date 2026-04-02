import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'token_storage.dart';

part 'auth_state.freezed.dart';

// === State ===

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.guest() = AuthGuest;
  const factory AuthState.authenticated({
    required String name,
    required String avatarUrl,
  }) = AuthAuthenticated;
}

// === Notifier ===

class AuthNotifier extends Notifier<AuthState> {
  late final TokenStorage _tokenStorage;

  @override
  AuthState build() {
    _tokenStorage = ref.watch(tokenStorageProvider);

    if (_tokenStorage.accessToken != null) {
      return const AuthState.authenticated(name: '', avatarUrl: '');
    }
    return const AuthState.guest();
  }

  void setUser({required String name, required String avatarUrl}) {
    state = AuthState.authenticated(name: name, avatarUrl: avatarUrl);
  }

  void setGuest() {
    state = const AuthState.guest();
  }
}

// === Provider ===

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
