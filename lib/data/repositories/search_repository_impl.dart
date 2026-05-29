import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/album_dto.dart';
import 'package:go_sport/data/dto/artist_dto.dart';
import 'package:go_sport/data/dto/playlist_dto.dart';
import 'package:go_sport/data/dto/program_dto.dart';
import 'package:go_sport/data/dto/track_dto.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ApiClient _apiClient;

  SearchRepositoryImpl(this._apiClient);

  @override
  Future<({List<Track> items, bool hasMore})> searchTracks({
    required String query,
    int page = 1,
    int pageSize = 25,
  }) async {
    final response = await _apiClient.get(
      '/api/tracks',
      queryParameters: {
        'filters[Name][\$containsi]': query,
        'populate[File][populate]': '*',
        'populate[Album][populate][Cover][populate]': '*',
        'populate[Artists][fields][0]': 'Name',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final items = data
        .map((e) => TrackDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: items, hasMore: page < pageCount);
  }

  @override
  Future<({List<Album> items, bool hasMore})> searchAlbums({
    required String query,
    int page = 1,
    int pageSize = 25,
  }) async {
    final response = await _apiClient.get(
      '/api/albums',
      queryParameters: {
        'filters[Name][\$containsi]': query,
        'populate': '*',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final items = data
        .map((e) => AlbumDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: items, hasMore: page < pageCount);
  }

  @override
  Future<({List<Artist> items, bool hasMore})> searchArtists({
    required String query,
    int page = 1,
    int pageSize = 25,
  }) async {
    final response = await _apiClient.get(
      '/api/artists',
      queryParameters: {
        'filters[Name][\$containsi]': query,
        'populate': '*',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final items = data
        .map((e) => ArtistDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: items, hasMore: page < pageCount);
  }

  @override
  Future<({List<Program> items, bool hasMore})> searchPrograms({
    required String query,
    int page = 1,
    int pageSize = 25,
  }) async {
    final response = await _apiClient.get(
      '/api/programs',
      queryParameters: {
        'filters[Name][\$containsi]': query,
        'populate': '*',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final items = data
        .map((e) => ProgramDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: items, hasMore: page < pageCount);
  }

  @override
  Future<({List<Playlist> items, bool hasMore})> searchPlaylists({
    required String query,
    int page = 1,
    int pageSize = 25,
  }) async {
    final response = await _apiClient.get(
      '/api/playlists',
      queryParameters: {
        'filters[Name][\$containsi]': query,
        'populate': '*',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final items = data
        .map((e) => PlaylistDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: items, hasMore: page < pageCount);
  }
}
