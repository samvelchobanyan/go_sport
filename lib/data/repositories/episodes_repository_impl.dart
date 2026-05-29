import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/episode_dto.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';
import 'package:go_sport/domain/state/like_registry.dart';

class EpisodesRepositoryImpl implements EpisodesRepository {
  final ApiClient _apiClient;
  final LikeRegistry _registry;

  EpisodesRepositoryImpl(this._apiClient, this._registry);

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
    final episodes = data
        .map((e) => EpisodeDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
    _registry.syncEpisodesLikes(episodes);
    return episodes;
  }

  @override
  Future<({List<Track> items, bool hasMore})> getFavoriteEpisodes({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _apiClient.get(
      '/api/user-episodes',
      queryParameters: {
        'populate[Episode][populate][File][populate]': '*',
        'populate[Episode][populate][Program][populate][Cover][populate]': '*',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final items = data.map((e) {
      final entry = e as Map<String, dynamic>;
      final episodeJson = entry['Episode'] as Map<String, dynamic>;
      episodeJson['Like'] = {'documentId': entry['documentId']};
      return EpisodeDto.fromJson(episodeJson).toDomain();
    }).toList();
    _registry.syncEpisodesLikes(items);

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: items, hasMore: page < pageCount);
  }

  @override
  Future<String?> toggleLikeEpisode(String episodeId, [String? likeId]) async {
    if (likeId != null) {
      await _apiClient.delete('/api/user-episodes/$likeId');
      _registry.markEpisodeUnliked(episodeId);
      return null;
    }

    final response = await _apiClient.post(
      '/api/user-episodes',
      data: {
        'data': {'Episode': episodeId},
      },
    );
    final newLikeId = response.data['data']['documentId'] as String;
    _registry.markEpisodeLiked(episodeId, newLikeId);
    return newLikeId;
  }
}
