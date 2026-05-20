import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/data/repositories/device_repository.dart';
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
  late final DeviceRepository _deviceRepository;

  // do not initialize token storage here,
  //as it causes problem after logout and login again,
  //because late variables can be initialized only once per instance,
  //and after logout the same instance is used for login again,
  //so it tries to initialize token storage again and throws error

  @override
  LoginState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _deviceRepository = ref.watch(deviceRepositoryProvider);
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

      final tokenStorage = ref.watch(tokenStorageProvider);
      await tokenStorage.saveTokens(accessToken: result.jwt, refreshToken: '');
      ref.invalidate(authProvider);


      state = state.copyWith(isLoading: false, isAuthenticated: true);

      await _deviceRepository.registerDevice();
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
