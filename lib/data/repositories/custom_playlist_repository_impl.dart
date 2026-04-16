import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/track_dto.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/custom_playlist_repository.dart';

const _customPlaylistCover = 'assets/images/custom_playlist_cover.png';

class CustomPlaylistRepositoryImpl implements CustomPlaylistRepository {
  final ApiClient _apiClient;

  CustomPlaylistRepositoryImpl(this._apiClient);

  @override
  Future<List<Playlist>> getCustomPlaylists() async {
    final response = await _apiClient.get(
      '/api/custom-playlists',
      queryParameters: {
        'populate[Tracks][fields][0]': 'documentId',
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data.map((e) {
      final entry = e as Map<String, dynamic>;
      final tracks = entry['Tracks'] as List<dynamic>? ?? [];
      return Playlist(
        id: entry['documentId'] as String,
        title: entry['Name'] as String,
        imageUrl: _customPlaylistCover,
        trackCount: tracks.length,
        type: PlaylistType.custom,
      );
    }).toList();
  }

  @override
  Future<List<Track>> getCustomPlaylistTracks(String id) async {
    final response = await _apiClient.get(
      '/api/custom-playlists/$id',
      queryParameters: {
        'populate[Tracks][populate][Album][populate]': 'Cover',
        'populate[Tracks][populate][File][populate]': '*',
        'populate[Tracks][populate][Artists][fields][0]': 'Name',
      },
    );

    final data = response.data['data'] as Map<String, dynamic>;
    final tracks = data['Tracks'] as List<dynamic>? ?? [];
    return tracks
        .map((e) => TrackDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<Playlist> createCustomPlaylist(String name) async {
    final response = await _apiClient.post(
      '/api/custom-playlists',
      data: {
        'data': {'Name': name},
      },
    );

    final entry = response.data['data'] as Map<String, dynamic>;
    return Playlist(
      id: entry['documentId'] as String,
      title: entry['Name'] as String,
      imageUrl: _customPlaylistCover,
      trackCount: 0,
      type: PlaylistType.custom,
    );
  }

  @override
  Future<Playlist> updateCustomPlaylist({
    required String id,
    required String name,
    required List<String> trackDocIds,
  }) async {
    final response = await _apiClient.put(
      '/api/custom-playlists/$id',
      data: {
        'data': {
          'Name': name,
          'Tracks': trackDocIds,
        },
      },
    );

    final entry = response.data['data'] as Map<String, dynamic>;
    return Playlist(
      id: entry['documentId'] as String,
      title: entry['Name'] as String,
      imageUrl: _customPlaylistCover,
      trackCount: trackDocIds.length,
      type: PlaylistType.custom,
    );
  }

  @override
  Future<void> deleteCustomPlaylist(String id) async {
    await _apiClient.delete('/api/custom-playlists/$id');
  }
}
