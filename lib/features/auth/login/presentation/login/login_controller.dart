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

class LoginController extends AutoDisposeNotifier<LoginState> {
  late final AuthRepository _authRepository;

  @override
  LoginState build() {
    // Initialize repositories from providers
    _authRepository = ref.watch(authRepositoryProvider);
    return const LoginState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    // try {
    //   // Logic for API call
    //   await _authRepository.signIn(email, password);

    //   state = state.copyWith(isLoading: false, isAuthenticated: true);
    // } catch (e) {
    //   state = state.copyWith(
    //     isLoading: false,
    //     error: e.toString(),
    //     isAuthenticated: false,
    //   );
    // }
  }
}

final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(
      LoginController.new,
    );
