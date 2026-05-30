import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/album_dto.dart';
import 'package:go_sport/data/dto/track_dto.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';
import 'package:go_sport/domain/state/like_registry.dart';

class AlbumsRepositoryImpl implements AlbumsRepository {
  final ApiClient _apiClient;
  final LikeRegistry _registry;

  AlbumsRepositoryImpl(this._apiClient, this._registry);

  @override
  Future<List<Album>> getFeaturedAlbums() async {
    final response = await _apiClient.get(
      '/api/albums',
      queryParameters: {
        'populate': '*',
        'filters[Featured][\$eq]': true,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => AlbumDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<List<Track>> getAlbumTracks(String albumId) async {
    final response = await _apiClient.get(
      '/api/albums/$albumId',
      queryParameters: {
        'populate[Tracks][populate][File][populate]': '*',
      },
    );

    final albumData = response.data['data'] as Map<String, dynamic>;
    final tracksData = albumData['Tracks'] as List<dynamic>? ?? [];

    return tracksData
        .map((e) => TrackDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<({List<Album> items, bool hasMore})> getFavoriteAlbums({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _apiClient.get(
      '/api/user-albums',
      queryParameters: {
        'populate[Album][populate][Cover][populate]': '*',
        'populate[Album][populate][Artist][fields][0]': 'Name',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final albumList = data.map((e) {
      final entry = e as Map<String, dynamic>;
      final albumJson = entry['Album'] as Map<String, dynamic>;

      albumJson['Like'] = {'documentId': entry['documentId']};

      return AlbumDto.fromJson(albumJson).toDomain();
    }).toList();
    _registry.syncAlbumsLikes(albumList);

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: albumList, hasMore: page < pageCount);
  }

  @override
  Future<String?> toggleLike(String albumId, [String? likeId]) async {
    if (likeId != null) {
      await _apiClient.delete('/api/user-albums/$likeId');
      return null;
    }

    final response = await _apiClient.post(
      '/api/user-albums',
      data: {
        'data': {'Album': albumId},
      },
    );
    return response.data['data']['documentId'] as String;
  }
}
