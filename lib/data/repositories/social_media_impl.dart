import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/social_links_dto.dart';
import 'package:go_sport/domain/entities/social_media.dart';
import 'package:go_sport/domain/repositories/social_media_repository.dart';

class SocialLinksRepositoryImpl implements SocialLinksRepository {
  final ApiClient _apiClient;

  SocialLinksRepositoryImpl(this._apiClient);

  @override
  Future<SocialLinks> getSocialLinks() async {
    final response = await _apiClient.get(
      '/api/social',
      queryParameters: {'populate': '*'},
    );

    final data = response.data as Map<String, dynamic>;
    print('!!!!!!!!!!data $data');
    // 1. Parse the raw JSON map directly into the Data Layer DTO
    final socialLinksDto = SocialLinksDto.fromJson(data);

    // 2. Convert and return it as your pure Domain Entity
    return socialLinksDto.toDomain();
  }
}
