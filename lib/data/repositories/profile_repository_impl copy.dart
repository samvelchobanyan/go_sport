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

    await _apiClient.put('/api/users/me', data: formData);
  }

  @override
  Future<void> deleteUser() async {
    await _apiClient.delete('/api/users/me');
  }

  @override
  Future<void> deleteAvatar() async {
    // Using DELETE method as requested
    await _apiClient.delete('/api/users/me/avatar');
  }

  @override
  Future<User> changePassword() async {
    final response = await _apiClient.post('/api/users/change-password');
    return UserDto.fromJson(response.data as Map<String, dynamic>).toDomain();
  }
}
