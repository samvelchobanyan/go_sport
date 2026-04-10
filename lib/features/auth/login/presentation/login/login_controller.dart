import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/di/repository_providers.dart';
// Assuming you have an AuthRepository
import 'package:go_sport/domain/repositories/auth_repository.dart';

part 'login_controller.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isAuthenticated,
  }) = _LoginState;
}
// login_controller.dart

class LoginController extends AutoDisposeNotifier<LoginState> {
  late final AuthRepository _authRepository;
  late final TokenStorage _tokenStorage;

  @override
  LoginState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _tokenStorage = ref.watch(tokenStorageProvider);
    return const LoginState();
  }

  Future<void> login(String email, String password) async {
    // Start loading
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _authRepository.login(
        identifier: email,
        password: password,
      );

      await _tokenStorage.saveTokens(accessToken: result.jwt, refreshToken: '');

      state = state.copyWith(isLoading: false, isAuthenticated: true);
    } catch (e) {
      // Dio errors or parsing errors caught here
      state = state.copyWith(
        isLoading: false,
        error: "Invalid credentials or server error",
      );
    }
  }
}

final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(
      LoginController.new,
    );
