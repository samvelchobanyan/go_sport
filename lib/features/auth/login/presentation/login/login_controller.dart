import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/auth/google_auth_service.dart';
import 'package:go_sport/core/di/auth_providers.dart';
import 'package:go_sport/core/di/push_providers.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/core/push/push_service.dart';
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

class LoginController extends AutoDisposeNotifier<LoginState> {
  late final AuthRepository _authRepository;
  late final PushService _pushService;
  late final GoogleAuthService _googleAuthService;

  @override
  LoginState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _pushService = ref.watch(pushServiceProvider);
    _googleAuthService = ref.watch(googleAuthServiceProvider);
    return const LoginState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _authRepository.login(
        identifier: email,
        password: password,
      );

      await ref.read(authProvider.notifier).login(result.jwt);

      state = state.copyWith(isLoading: false, isAuthenticated: true);

      _pushService.register().ignore();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Invalid credentials or server error",
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final accessToken = await _googleAuthService.signInAndGetAccessToken();
      if (accessToken == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final result = await _authRepository.loginWithGoogle(
        accessToken: accessToken,
      );

      await ref.read(authProvider.notifier).login(result.jwt);

      state = state.copyWith(isLoading: false, isAuthenticated: true);

      _pushService.register().ignore();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Google sign-in failed",
      );
    }
  }
}


final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(
      LoginController.new,
    );
