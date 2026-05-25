import 'package:dio/dio.dart';
import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/user_dto.dart';
import 'package:go_sport/domain/entities/user.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl(this._apiClient);
  @override
  Future<({String jwt, User user})> login({
    required String identifier,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/api/auth/local',
      data: {'identifier': identifier, 'password': password},
      options: Options(extra: {'public': true}),
    );

    final jwt = response.data['jwt'] as String;
    final user = UserDto.fromJson(
      response.data['user'] as Map<String, dynamic>,
    ).toDomain();

    return (jwt: jwt, user: user);
  }

  @override
  Future<({String registrationToken})> registerEmail({
    required String email,
  }) async {
    final response = await _apiClient.post(
      '/api/register/email',
      data: {'email': email},
      options: Options(extra: {'public': true}),
    );
    return (registrationToken: response.data['registrationToken'] as String);
  }

  @override
  Future<void> verifyEmail({required String token, required String otp}) async {
    await _apiClient.post(
      '/api/register/email/verify',
      data: {'token': token, 'otp': otp},
      options: Options(extra: {'public': true}),
    );
  }

  @override
  Future<void> resendEmailOtp({required String token}) async {
    await _apiClient.post(
      '/api/register/email/resend',
      data: {'token': token},
      options: Options(extra: {'public': true}),
    );
  }

  @override
  Future<void> registerPhone({
    required String token,
    required String phone,
  }) async {
    await _apiClient.post(
      '/api/register/phone',
      data: {'token': token, 'phone': phone},
      options: Options(extra: {'public': true}),
    );
  }

  @override
  Future<void> verifyPhone({required String token, required String otp}) async {
    await _apiClient.post(
      '/api/register/phone/verify',
      data: {'token': token, 'otp': otp},
      options: Options(extra: {'public': true}),
    );
  }

  @override
  Future<void> resendPhoneOtp({required String token}) async {
    await _apiClient.post(
      '/api/register/phone/resend',
      data: {'token': token},
      options: Options(extra: {'public': true}),
    );
  }

  @override
  Future<void> skipPhone({required String token}) async {
    await _apiClient.post(
      '/api/register/phone/skip',
      data: {'token': token},
      options: Options(extra: {'public': true}),
    );
  }

  @override
  Future<void> setRegistrationPassword({
    required String token,
    required String password,
  }) async {
    await _apiClient.post(
      '/api/register/password',
      data: {'token': token, 'password': password},
      options: Options(extra: {'public': true}),
    );
  }

  @override
  Future<({String jwt, User user})> finalizeProfile({
    required String token,
    required String name,
    required String surname,
  }) async {
    final response = await _apiClient.post(
      '/api/register/profile',
      data: {'token': token, 'name': name, 'surname': surname},
      options: Options(extra: {'public': true}),
    );

    final jwt = response.data['jwt'] as String;
    final user = UserDto.fromJson(
      response.data['user'] as Map<String, dynamic>,
    ).toDomain();

    return (jwt: jwt, user: user);
  }

  @override
  Future<({String resetToken})> forgotPasswordOtp({
    required String email,
  }) async {
    final response = await _apiClient.post(
      '/api/auth/forgot-password-otp',
      data: {'email': email},
      options: Options(extra: {'public': true}),
    );

    // We return a record containing the resetToken from the API response
    return (resetToken: response.data['resetToken'] as String);
  }

  @override
  Future<void> verifyResetOtp({
    required String token,
    required String otp,
  }) async {
    await _apiClient.post(
      '/api/auth/verify-reset-otp',
      data: {'resetToken': token, 'otp': otp},
      options: Options(extra: {'public': true}),
    );
  }

  @override
  Future<void> resetPasswordOtp({
    required String token,
    required String otp,
    required String password,
  }) async {
    await _apiClient.post(
      '/api/auth/reset-password-otp',
      data: {'resetToken': token, 'otp': otp, 'password': password},
      options: Options(extra: {'public': true}),
    );
  }
}
