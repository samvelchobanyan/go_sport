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
  Future<List<Track>> getFavoriteTracks() async {
    throw UnimplementedError('getFavoriteTracks requires authentication');
  }

  @override
  Future<void> toggleLike(String playlistId) async {
    throw UnimplementedError('toggleLike requires authentication');
  }
}
