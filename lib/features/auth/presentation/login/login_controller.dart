import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/auth/auth_state.dart';
import '../../../../core/auth/token_storage.dart';
import '../../../../core/di/repository_providers.dart';
import '../../../../domain/repositories/auth_repository.dart';

part 'login_controller.freezed.dart';

// === State ===

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.idle() = _LoginIdle;
  const factory LoginState.loading() = _LoginLoading;
  const factory LoginState.success() = _LoginSuccess;
  const factory LoginState.error({required String message}) = _LoginError;
}

// === Controller ===

class LoginController extends AutoDisposeNotifier<LoginState> {
  late final AuthRepository _authRepository;
  late final TokenStorage _tokenStorage;

  @override
  LoginState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _tokenStorage = ref.watch(tokenStorageProvider);
    return const LoginState.idle();
  }

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    state = const LoginState.loading();

    try {
      final result = await _authRepository.login(
        identifier: identifier,
        password: password,
      );

      await _tokenStorage.saveTokens(
        accessToken: result.jwt,
        refreshToken: '',
      );

      ref.read(authProvider.notifier).setUser(
            name: result.user.name,
            avatarUrl: '',
            userId: result.user.id,
          );

      state = const LoginState.success();
    } catch (e) {
      state = LoginState.error(message: e.toString());
    }
  }
}

// === Provider ===

final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(
  LoginController.new,
);
