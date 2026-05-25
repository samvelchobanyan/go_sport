import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
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

  @override
  LoginState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _pushService = ref.watch(pushServiceProvider);
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
}


final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(
      LoginController.new,
    );
