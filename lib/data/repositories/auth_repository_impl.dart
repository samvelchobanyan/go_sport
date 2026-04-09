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
      data: {
        'identifier': identifier,
        'password': password,
      },
      options: Options(extra: {'public': true}),
    );

    final jwt = response.data['jwt'] as String;
    final user = UserDto.fromJson(response.data['user'] as Map<String, dynamic>).toDomain();

    return (jwt: jwt, user: user);
  }
}