import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/business_service_dto.dart';
import 'package:go_sport/domain/entities/business_service.dart';
import 'package:go_sport/domain/repositories/business_service_repository.dart';

class BusinessServiceRepositoryImpl implements BusinessServiceRepository {
  final ApiClient _apiClient;

  BusinessServiceRepositoryImpl(this._apiClient);

  @override
  Future<List<BusinessService>> getServices() async {
    final response = await _apiClient.get(
      '/api/services',
      queryParameters: {'populate': '*'},
    );
    final responseData = response.data as Map<String, dynamic>;
    final services = responseData['data'] as List<dynamic>? ?? const [];

    return services
        .whereType<Map<String, dynamic>>()
        .map((json) => BusinessServiceDto.fromJson(json).toDomain())
        .toList(growable: false);
  }
}
