import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/episode_dto.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';

class EpisodesRepositoryImpl implements EpisodesRepository {
  final ApiClient _apiClient;

  EpisodesRepositoryImpl(this._apiClient);

  @override
  Future<List<Track>> getFeaturedEpisodes() async {
    final response = await _apiClient.get(
      '/api/episodes',
      queryParameters: {
        'populate[File][populate]': '*',
        'populate[Program][populate][Cover][populate]': '*',
        'filters[Featured][\$eq]': true,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => EpisodeDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<List<Track>> getFavoriteEpisodes() async {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleLike(String id) async {
    throw UnimplementedError();
  }
}
