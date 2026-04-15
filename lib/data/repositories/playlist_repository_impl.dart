import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/playlist_dto.dart';
import 'package:go_sport/data/dto/track_dto.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/playlist_repository.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final ApiClient _apiClient;

  PlaylistRepositoryImpl(this._apiClient);

  @override
  Future<List<Playlist>> getFeaturedPlaylists() async {
    final response = await _apiClient.get(
      '/api/playlists',
      queryParameters: {
        'populate': '*',
        'filters[Featured][\$eq]': true,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => PlaylistDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<List<Track>> getPlaylistTracks(String playlistId) async {
    final response = await _apiClient.get(
      '/api/playlists/$playlistId',
      queryParameters: {
        'populate[Tracks][populate][Album][populate]': 'Cover',
        'populate[Tracks][populate][File][populate]': '*',
        'populate[Cover][populate]': '*',
      },
    );

    final data = response.data['data'] as Map<String, dynamic>;
    final tracks = data['Tracks'] as List<dynamic>? ?? [];
    return tracks
        .map((e) => TrackDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<List<Playlist>> getFavoritePlaylists() async {
    throw UnimplementedError('getFavoritePlaylists requires authentication');
  }

  @override
  Future<({List<Track> items, bool hasMore})> getFavoriteTracks({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _apiClient.get(
      '/api/user-tracks',
      queryParameters: {
        'populate[Track][populate][Album][populate]': 'Cover',
        'populate[Track][populate][File][populate]': '*',
        'populate[Track][populate][Artists][fields][0]': 'Name',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final items = data.map((e) {
      final entry = e as Map<String, dynamic>;
      final trackJson = entry['Track'] as Map<String, dynamic>;
      trackJson['Like'] = {'documentId': entry['documentId']};
      return TrackDto.fromJson(trackJson).toDomain();
    }).toList();

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: items, hasMore: page < pageCount);
  }

  @override
  Future<String?> toggleLike(String playlistId, [String? likeId]) async {
    if (likeId != null) {
      await _apiClient.delete('/api/user-playlists/$likeId');
      return null;
    }

    final response = await _apiClient.post(
      '/api/user-playlists',
      data: {
        'data': {'Playlist': playlistId},
      },
    );
    return response.data['data']['documentId'] as String;
  }

  @override
  Future<String?> toggleLikeTrack(String trackId, [String? likeId]) async {
    if (likeId != null) {
      await _apiClient.delete('/api/user-tracks/$likeId');
      return null;
    }

    final response = await _apiClient.post(
      '/api/user-tracks',
      data: {
        'data': {'Track': trackId},
      },
    );
    return response.data['data']['documentId'] as String;
  }
}
