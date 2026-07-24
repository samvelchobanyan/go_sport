import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final ApiClient _apiClient;

  DeviceRepositoryImpl(this._apiClient);

  @override
  Future<String?> findByToken(String token) async {
    final response = await _apiClient.get(
      '/api/devices',
      queryParameters: {'filters[Token]': token},
    );

    final data = response.data['data'] as List<dynamic>?;
    if (data == null || data.isEmpty) return null;

    return data.first['documentId'] as String;
  }

  @override
  Future<String> register({
    required String token,
    required String platform,
  }) async {
    final response = await _apiClient.post(
      '/api/devices',
      data: {
        'data': {'Token': token, 'Platform': platform},
      },
    );
    return response.data['data']['documentId'] as String;
  }

  @override
  Future<void> delete(String documentId) async {
    await _apiClient.delete('/api/devices/$documentId');
  }
}
