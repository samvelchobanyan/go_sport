import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/di/push_providers.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/core/push/push_service.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    // UI State
    @Default(false) bool isLoading,
    // @Default(false) bool isSuccess,
    // @Default(false) bool isConfirmSuccess,
    // @Default(false) bool isSkipSuccess,
    @Default(false) bool isEmailSuccess, // Distinct
    @Default(false) bool isEmailVerifySuccess, // Distinct
    @Default(false) bool isPhoneSuccess, // Distinct
    @Default(false) bool isPhoneVerifySuccess, // Distinct
    @Default(false) bool isSkipSuccess,
    @Default(false) bool isNameSuccess, // Distinct
    @Default(false) bool isPasswordSuccess, // Distinct
    String? error,

    // Data gathered during the multi-step process
    String? email,
    String? phoneNumber,
    String? name,
    String? surname,
  }) = _RegistrationState;
}

class RegistrationController extends Notifier<RegistrationState> {
  late final AuthRepository _authRepository;
  late final PushService _pushService;

  @override
  RegistrationState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _pushService = ref.watch(pushServiceProvider);
    return const RegistrationState();
  }

  // --- STEP 1: Email Registration ---
  Future<void> registerEmail(String email) async {
    _prepareAction();
    try {
      final result = await _authRepository.registerEmail(email: email);

      final tokenStorage = ref.read(tokenStorageProvider);
      tokenStorage.saveRegistrationToken(result.registrationToken);
      state = state.copyWith(
        isLoading: false,
        //  isSuccess: true,
        isEmailSuccess: true,
        email: email,
      );
    } catch (e) {
      _handleError("Failed to send email verification.");
    }
  }

  // --- STEP 2: Verify Email OTP ---
  Future<void> verifyEmailOtp(String otp) async {
    _prepareAction();
    final tokenStorage = ref.read(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.verifyEmail(token: token, otp: otp);
      state = state.copyWith(
        isLoading: false,
        isEmailVerifySuccess: true,
        // isConfirmSuccess: true
      );
    } catch (e) {
      _handleError("Invalid code.");
    }
  }

  // --- STEP 3: Phone Registration (Optional) ---
  Future<void> registerPhone(String phone) async {
    _prepareAction();
    final tokenStorage = ref.read(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    try {
      await _authRepository.registerPhone(token: token!, phone: phone);
      state = state.copyWith(
        isLoading: false,
        isPhoneSuccess: true,
        // isSuccess: true,
        phoneNumber: phone,
      );
    } catch (e) {
      _handleError("Failed to register phone.");
    }
  }

  Future<void> verifyPhoneOtp(String otp) async {
    _prepareAction();
    final tokenStorage = ref.read(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.verifyPhone(token: token, otp: otp);
      state = state.copyWith(
        isLoading: false,
        // isConfirmSuccess: true
        isPhoneVerifySuccess: true,
      );
    } catch (e) {
      // TEMP DEBUG: реальный ответ сервера на verifyPhone (убрать после отладки)
      if (e is DioException) {
        log(
          'verifyPhone FAILED\n'
          'request body: ${e.requestOptions.data}\n'
          'status: ${e.response?.statusCode}\n'
          'response body: ${e.response?.data}',
          name: 'verifyPhoneOtp',
        );
      } else {
        log('verifyPhone FAILED (non-Dio): $e', name: 'verifyPhoneOtp');
      }
      _handleError("Invalid code.");
    }
  }

  Future<void> skipPhone() async {
    _prepareAction();
    final tokenStorage = ref.read(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.skipPhone(token: token);
      state = state.copyWith(
        isLoading: false,
        // isSuccess: false,
        isSkipSuccess: true,
      );
    } catch (e) {
      _handleError("Error on skip phone");
    }
  }

  Future<void> resendPhoneOtp() async {
    _prepareAction();
    final tokenStorage = ref.read(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.resendPhoneOtp(token: token);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      _handleError("Error on resend phone OTP");
    }
  }

  Future<void> resendEmailOtp() async {
    _prepareAction();
    final tokenStorage = ref.read(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.resendEmailOtp(token: token);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      _handleError("Error on resend email OTP");
    }
  }

  // --- STEP 4: Set Password ---
  Future<void> setPassword(String password) async {
    _prepareAction();
    final tokenStorage = ref.read(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.setRegistrationPassword(
        token: token,
        password: password,
      );
      state = state.copyWith(
        isLoading: false,
        isPasswordSuccess: true,
        // isSuccess: true,
        // isConfirmSuccess: false,
        // isSkipSuccess: false,
      );
    } catch (e) {
      _handleError("Could not set password.");
    }
  }

  // --- STEP 5: Finalize Profile (Name & Surname) ---
  Future<void> finalizeProfile({
    required String name,
    required String surname,
  }) async {
    _prepareAction();
    final tokenStorage = ref.read(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    try {
      final result = await _authRepository.finalizeProfile(
        token: token!,
        name: name,
        surname: surname,
      );

      await ref.read(authProvider.notifier).login(result.jwt);
      _pushService.register().ignore();

      state = state.copyWith(
        isLoading: false,
        isNameSuccess: true,
        // isSuccess: true,
        name: name,
        surname: surname,
      );

    } catch (e) {
      _handleError("Failed to save profile.");
    }
  }

  // --- Google sign-in (shared orchestration lives in AuthNotifier) ---
  Future<void> loginWithGoogle() async {
    _prepareAction();
    try {
      await ref.read(authProvider.notifier).loginWithGoogle();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      _handleError("Google sign-in failed");
    }
  }

  // --- Utilities ---

  void _prepareAction() {
    state = state.copyWith(
      isLoading: true,

      isEmailSuccess: false,
      isEmailVerifySuccess: false,
      isPhoneSuccess: false,
      isPhoneVerifySuccess: false,
      isSkipSuccess: false,
      isNameSuccess: false,
      isPasswordSuccess: false,
      error: null,
    );
  }

  void _handleError(String message) {
    state = state.copyWith(
      isLoading: false,
      isEmailSuccess: false,
      isEmailVerifySuccess: false,
      isPhoneSuccess: false,
      isPhoneVerifySuccess: false,
      isSkipSuccess: false,
      isNameSuccess: false,
      isPasswordSuccess: false,
      error: message,
    );
  }

  void clearFlow() {
    state = const RegistrationState();
    final tokenStorage = ref.read(tokenStorageProvider);

    tokenStorage.clearRegistrationToken();
  }
}

final registrationControllerProvider =
    NotifierProvider<RegistrationController, RegistrationState>(
      RegistrationController.new,
    );
