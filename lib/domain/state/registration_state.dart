import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/data/repositories/device_repository.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    // UI State
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool isConfirmSuccess,
    @Default(false) bool isSkipSuccess,
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
  late final DeviceRepository _deviceRepository;

  @override
  RegistrationState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _deviceRepository = ref.watch(deviceRepositoryProvider);
    return const RegistrationState();
  }

  // --- STEP 1: Email Registration ---
  Future<void> registerEmail(String email) async {
    _prepareAction();
    try {
      final result = await _authRepository.registerEmail(email: email);

      final tokenStorage = ref.watch(tokenStorageProvider);
      tokenStorage.saveRegistrationToken(result.registrationToken);
      state = state.copyWith(isLoading: false, isSuccess: true, email: email);
    } catch (e) {
      _handleError("Failed to send email verification.");
    }
  }

  // --- STEP 2: Verify Email OTP ---
  Future<void> verifyEmailOtp(String otp) async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.verifyEmail(token: token, otp: otp);
      state = state.copyWith(isLoading: false, isConfirmSuccess: true);
    } catch (e) {
      _handleError("Invalid code.");
    }
  }

  // --- STEP 3: Phone Registration (Optional) ---
  Future<void> registerPhone(String phone) async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    try {
      await _authRepository.registerPhone(token: token!, phone: phone);
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        phoneNumber: phone,
      );
    } catch (e) {
      _handleError("Failed to register phone.");
    }
  }

  Future<void> verifyPhoneOtp(String otp) async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.verifyPhone(token: token, otp: otp);
      state = state.copyWith(isLoading: false, isConfirmSuccess: true);
    } catch (e) {
      _handleError("Invalid code.");
    }
  }

  Future<void> skipPhone() async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.skipPhone(token: token);
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        isSkipSuccess: true,
      );
    } catch (e) {
      _handleError("Error on skip phone");
    }
  }

  Future<void> resendPhoneOtp() async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.resendPhoneOtp(token: token);
    } catch (e) {
      _handleError("Error on resend phone OTP");
    }
  }

  Future<void> resendEmailOtp() async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.resendEmailOtp(token: token);
    } catch (e) {
      _handleError("Error on resend email OTP");
    }
  }

  // --- STEP 4: Set Password ---
  Future<void> setPassword(String password) async {
    _prepareAction();
    final tokenStorage = ref.watch(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    if (token == null) return _handleError("Session expired.");

    try {
      await _authRepository.setRegistrationPassword(
        token: token,
        password: password,
      );
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        isConfirmSuccess: false,
        isSkipSuccess: false,
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
    final tokenStorage = ref.watch(tokenStorageProvider);

    final token = tokenStorage.registrationToken;
    try {
      final result = await _authRepository.finalizeProfile(
        token: token!,
        name: name,
        surname: surname,
      );

      // Save REAL tokens - this marks the end of the registration flow
      final tokenStorage = ref.watch(tokenStorageProvider);
      await tokenStorage.saveTokens(accessToken: result.jwt, refreshToken: '');
      ref.invalidate(authProvider);

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        name: name,
        surname: surname,
      );

      await _deviceRepository.registerDevice();
    } catch (e) {
      _handleError("Failed to save profile.");
    }
  }

  // --- Utilities ---

  void _prepareAction() {
    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      isConfirmSuccess: false,
      isSkipSuccess: false,
      error: null,
    );
  }

  void _handleError(String message) {
    state = state.copyWith(
      isLoading: false,
      isSuccess: false,
      isConfirmSuccess: false,
      isSkipSuccess: false,
      error: message,
    );
  }

  void clearFlow() {
    state = const RegistrationState();
    final tokenStorage = ref.watch(tokenStorageProvider);

    tokenStorage.clearRegistrationToken();
  }
}

final registrationControllerProvider =
    NotifierProvider<RegistrationController, RegistrationState>(
      RegistrationController.new,
    );
