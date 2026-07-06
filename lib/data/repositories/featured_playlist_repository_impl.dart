import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/playlist_dto.dart';
import 'package:go_sport/data/dto/track_dto.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/featured_playlist_repository.dart';

class FeaturedPlaylistRepositoryImpl implements FeaturedPlaylistRepository {
  final ApiClient _apiClient;

  FeaturedPlaylistRepositoryImpl(this._apiClient);

  @override
  Future<List<Playlist>> getFeaturedPlaylists() async {
    final response = await _apiClient.get(
      '/api/playlists',
      queryParameters: {
        'populate': '*',
        'filters[Featured][\$eq]': true,
        'sort[0]': 'Weight:desc',
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
        'populate[Tracks][populate][Artists][fields][0]': 'Name',
        'populate[Cover][populate]': '*',
      },
    );

    final data = response.data['data'] as Map<String, dynamic>;
    final tracksData = data['Tracks'] as List<dynamic>? ?? [];
    return tracksData
        .map((e) => TrackDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<List<Playlist>> getLikedFeaturedPlaylists() async {
    final response = await _apiClient.get(
      '/api/user-playlists',
      queryParameters: {
        'populate[Playlist][populate][Cover][populate]': '*',
        'sort[0]': 'createdAt:desc',
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final playlists = data.map((e) {
      final entry = e as Map<String, dynamic>;
      final playlistJson = entry['Playlist'] as Map<String, dynamic>;
      playlistJson['Like'] = {'documentId': entry['documentId']};
      playlistJson['cnt'] = entry['cnt'];
      return PlaylistDto.fromJson(playlistJson).toDomain();
    }).toList();
    return playlists;
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
        'sort[0]': 'createdAt:desc',
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
