import 'dart:io';
import 'package:dio/dio.dart';
import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/user_dto.dart';
import 'package:go_sport/domain/entities/user.dart';
import 'package:go_sport/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepositoryImpl(this._apiClient);

  @override
  Future<User> getUser() async {
    final response = await _apiClient.get(
      '/api/users/me',
      queryParameters: {'populate': '*'},
    );

    return UserDto.fromJson(response.data as Map<String, dynamic>).toDomain();
  }

  @override
  Future<void> updateUser({String? name, String? surname, File? avatar}) async {
    final Map<String, dynamic> data = {
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
    };

    if (avatar != null) {
      data['avatar'] = await MultipartFile.fromFile(
        avatar.path,
        filename: avatar.path.split('/').last,
      );
    }

    final formData = FormData.fromMap(data);

    await _apiClient.put('/api/users/me/update', data: formData);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    final Map<String, dynamic> data = {
      "currentPassword": currentPassword,
      "password": password,
      "passwordConfirmation": passwordConfirmation,
    };

    await _apiClient.post('/api/auth/change-password', data: data);
  }

  @override
  Future<void> deleteUser({required String password}) async {
    await _apiClient.post('/api/users/me/delete', data: {"password": password});
  }

  @override
  Future<void> deleteUserWithGoogle({required String accessToken}) async {
    await _apiClient.post(
      '/api/users/me/delete',
      data: {"access_token": accessToken},
    );
  }

  @override
  Future<void> deleteAvatar() async {
    // Using DELETE method as requested
    await _apiClient.delete('/api/users/me/avatar');
  }
}
