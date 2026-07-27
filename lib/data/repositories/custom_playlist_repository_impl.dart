import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/track_dto.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/custom_playlist_repository.dart';

class CustomPlaylistRepositoryImpl implements CustomPlaylistRepository {
  final ApiClient _apiClient;

  CustomPlaylistRepositoryImpl(this._apiClient);

  @override
  Future<List<Playlist>> getCustomPlaylists() async {
    final response = await _apiClient.get(
      '/api/custom-playlists',
      queryParameters: {
        'populate[Tracks][fields][0]': 'documentId',
        'populate[Tracks][populate][Cover][populate]': '*',
        'populate[Tracks][populate][Album][populate]': 'Cover',
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data.map((e) {
      final entry = e as Map<String, dynamic>;
      final tracks = entry['Tracks'] as List<dynamic>? ?? [];
      final trackDocIds = tracks.map((t) => t['documentId'] as String).toList();
      return Playlist(
        id: entry['documentId'] as String,
        title: entry['Name'] as String,
        imageUrl: _firstTrackCover(tracks),
        trackCount: tracks.length,
        trackDocIds: trackDocIds,
        type: PlaylistType.custom,
        createdAt: _parseCreatedAt(entry['createdAt']),
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
        'populate[Tracks][populate][Artists][populate][Cover][populate]': '*',
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
    print('!!res  $response');

    final entry = response.data['data'] as Map<String, dynamic>;
    return Playlist(
      id: entry['documentId'] as String,
      title: entry['Name'] as String,
      imageUrl: '',
      trackCount: 0,
      type: PlaylistType.custom,
      createdAt: _parseCreatedAt(entry['createdAt']),
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
        'data': {'Name': name, 'Tracks': trackDocIds},
      },
      queryParameters: {
        'populate[Tracks][fields][0]': 'documentId',
        'populate[Tracks][populate][Cover][populate]': '*',
        'populate[Tracks][populate][Album][populate]': 'Cover',
      },
    );

    final entry = response.data['data'] as Map<String, dynamic>;
    final tracks = entry['Tracks'] as List<dynamic>? ?? [];
    return Playlist(
      id: entry['documentId'] as String,
      title: entry['Name'] as String,
      imageUrl: _firstTrackCover(tracks),
      trackCount: trackDocIds.length,
      trackDocIds: trackDocIds,
      type: PlaylistType.custom,
      createdAt: _parseCreatedAt(entry['createdAt']),
    );
  }

  @override
  Future<void> deleteCustomPlaylist(String id) async {
    await _apiClient.delete('/api/custom-playlists/$id');
  }

  /// Парсит Strapi-шный `createdAt` (ISO-строка) в DateTime; null при отсутствии.
  DateTime? _parseCreatedAt(dynamic raw) =>
      raw is String ? DateTime.tryParse(raw) : null;

  /// Обложка кастомного плейлиста = обложка первого трека (или его альбома).
  /// Пусто, если треков нет — вызывающий UI покажет брендовый фолбэк.
  String _firstTrackCover(List<dynamic> tracks) {
    if (tracks.isEmpty) return '';
    final first = tracks.first as Map<String, dynamic>;
    final cover = first['Cover'] as Map<String, dynamic>?;
    final album = first['Album'] as Map<String, dynamic>?;
    final albumCover = album?['Cover'] as Map<String, dynamic>?;
    return (cover?['url'] as String?) ?? (albumCover?['url'] as String?) ?? '';
  }
}
