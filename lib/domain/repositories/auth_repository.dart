import 'package:go_sport/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<({String jwt, User user})> login({
    required String identifier,
    required String password,
  });

  Future<({String registrationToken})> registerEmail({required String email});

  Future<void> verifyEmail({required String token, required String otp});

  Future<void> resendEmailOtp({required String token});

  Future<void> registerPhone({required String token, required String phone});

  Future<void> verifyPhone({required String token, required String otp});

  Future<void> resendPhoneOtp({required String token});

  Future<void> skipPhone({required String token});

  Future<void> setRegistrationPassword({
    required String token,
    required String password,
  });

  Future<({String jwt, User user})> finalizeProfile({
    required String token,
    required String name,
    required String surname,
  });

  Future<({String resetToken})> forgotPasswordOtp({required String email});

  Future<void> verifyResetOtp({required String token, required String otp});

  Future<void> resetPasswordOtp({
    required String token,
    required String otp,
    required String password,
  });

  Future<void> logout();
}
