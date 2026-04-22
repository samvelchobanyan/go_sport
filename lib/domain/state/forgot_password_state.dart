import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool isConfirmSuccess,
    String? error,
    String? email,
    String? newPassword,
    String? resetOtp,
  }) = _ForgotPasswordState;
}

class ForgotPasswordController extends Notifier<ForgotPasswordState> {
  late final AuthRepository _authRepository;

  @override
  ForgotPasswordState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return const ForgotPasswordState();
  }

  Future<void> forgotPasswordOtp(String email) async {
    _prepareAction();
    try {
      final result = await _authRepository.forgotPasswordOtp(email: email);
      final tokenStorage = ref.watch(tokenStorageProvider);

      tokenStorage.saveResetToken(result.resetToken);
      state = state.copyWith(isLoading: false, isSuccess: true, email: email);
    } catch (e) {
      _handleError('Failed to send reset code.');
    }
  }

  Future<void> verifyResetOtp(String otp) async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final resetToken = tokenStorage.resetToken;
    if (resetToken == null) return _handleError('Session expired.');

    try {
      await _authRepository.verifyResetOtp(token: resetToken, otp: otp);
      state = state.copyWith(
        isLoading: false,
        isConfirmSuccess: true,
        resetOtp: otp,
      );
    } catch (e) {
      _handleError('Invalid code.');
    }
  }

  Future<void> resetPasswordOtp(String newPassword) async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final resetToken = tokenStorage.resetToken;
    final savedOtp = state.resetOtp;

    if (resetToken == null || savedOtp == null) {
      return _handleError('Session expired or OTP missing.');
    }

    try {
      await _authRepository.resetPasswordOtp(
        token: resetToken,
        otp: savedOtp,
        password: newPassword,
      );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        isConfirmSuccess: false,
        newPassword: newPassword,
      );

      final tokenStorage = ref.watch(tokenStorageProvider);

      tokenStorage.clearResetToken();
    } catch (e) {
      _handleError('Failed to reset password.');
    }
  }

  void _prepareAction() {
    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      isConfirmSuccess: false,
      error: null,
    );
  }

  void _handleError(String message) {
    state = state.copyWith(
      isLoading: false,
      isSuccess: false,
      isConfirmSuccess: false,
      error: message,
    );
  }

  void clearFlow() {
    state = const ForgotPasswordState();
    final tokenStorage = ref.watch(tokenStorageProvider);

    tokenStorage.clearResetToken();
  }
}

final forgotPasswordControllerProvider =
    NotifierProvider<ForgotPasswordController, ForgotPasswordState>(
      ForgotPasswordController.new,
    );
