import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

  @override
  LoginState build() {
    _authRepository = ref.watch(authRepositoryProvider);
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

      // TODO: Save result.jwt to secure storage if needed

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
