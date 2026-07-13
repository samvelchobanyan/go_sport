import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/banner_dto.dart';
import 'package:go_sport/domain/entities/banner.dart';
import 'package:go_sport/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final ApiClient _apiClient;

  BannerRepositoryImpl(this._apiClient);

  @override
  Future<HeroBanner> getPodcastBanner() async {
    final response = await _apiClient.get(
      '/api/banner',
      queryParameters: {'populate': '*'},
    );

    final data = response.data as Map<String, dynamic>;

    // 1. Parse the raw JSON map directly into the Data Layer DTO
    final bannerDto = BannerDto.fromJson(data);

    // 2. Convert and return it as your pure Domain Entity
    return bannerDto.toDomain();
  }
}
