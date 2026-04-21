import 'package:go_sport/core/network/api_client.dart';
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

    return response.data as User;
  }

  @override
  Future<User> updateUser({
    String? name,
    String? surname,
    String? avatar,
  }) async {
    final response = await _apiClient.put(
      '/api/users/me',
      data: {
        if (name != null) 'name': name,
        if (surname != null) 'surname': surname,
        if (avatar != null) 'avatar': avatar,
      },
    );

    return response.data as User;
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
    return response.data as User;
  }
}
