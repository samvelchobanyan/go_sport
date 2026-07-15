import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/album_dto.dart';
import 'package:go_sport/data/dto/artist_dto.dart';
import 'package:go_sport/data/dto/track_dto.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';

class ArtistsRepositoryImpl implements ArtistsRepository {
  final ApiClient _apiClient;

  ArtistsRepositoryImpl(this._apiClient);

  @override
  Future<List<Artist>> getFeaturedArtists() async {
    final response = await _apiClient.get(
      '/api/artists',
      queryParameters: {
        'populate': '*',
        'filters[Featured][\$eq]': true,
        'sort[0]': 'Weight:desc',
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => ArtistDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<({List<Artist> items, bool hasMore})> getFavoriteArtists({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _apiClient.get(
      '/api/user-artists',
      queryParameters: {
        'populate[Artist][populate][Cover][populate]': '*',
        'sort[0]': 'createdAt:desc',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final artistList = data.map((e) {
      final entry = e as Map<String, dynamic>;
      final artistJson = entry['Artist'] as Map<String, dynamic>;
      artistJson['Like'] = {'documentId': entry['documentId']};
      return ArtistDto.fromJson(artistJson).toDomain();
    }).toList();

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: artistList, hasMore: page < pageCount);
  }

  @override
  Future<Artist> getArtist(String artistId) async {
    final response = await _apiClient.get(
      '/api/artists/$artistId',
      queryParameters: {
        'populate[Cover][populate]': '*',
      },
    );

    final data = response.data['data'] as Map<String, dynamic>;
    return ArtistDto.fromJson(data).toDomain();
  }

  @override
  Future<({List<Track> items, bool hasMore})> getArtistTracks(
    String artistId, {
    int page = 1,
    int pageSize = 25,
  }) =>
      _getTracks(artistId, page: page, pageSize: pageSize, onlySingles: false);

  @override
  Future<({List<Track> items, bool hasMore})> getArtistSingles(
    String artistId, {
    int page = 1,
    int pageSize = 25,
  }) =>
      _getTracks(artistId, page: page, pageSize: pageSize, onlySingles: true);

  @override
  Future<({List<Album> items, bool hasMore})> getArtistAlbums(
    String artistId, {
    int page = 1,
    int pageSize = 25,
  }) async {
    final response = await _apiClient.get(
      '/api/albums',
      queryParameters: {
        'filters[Artist][documentId][\$eq]': artistId,
        'sort[0]': 'Year:desc',
        'sort[1]': 'Name:asc',
        'populate[Cover][populate]': '*',
        'populate[Artist][fields][0]': 'Name',
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

  Future<({List<Track> items, bool hasMore})> _getTracks(
    String artistId, {
    required int page,
    required int pageSize,
    required bool onlySingles,
  }) async {
    final response = await _apiClient.get(
      '/api/tracks',
      queryParameters: {
        'filters[Artists][documentId][\$eq]': artistId,
        if (onlySingles) 'filters[Album][\$null]': true,
        'sort[0]': 'Year:desc',
        'sort[1]': 'Name:asc',
        'populate[File][populate]': '*',
        'populate[Cover][populate]': '*',
        if (!onlySingles) 'populate[Album][populate][Cover][populate]': '*',
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
  Future<String?> toggleLike(String artistId, [String? likeId]) async {
    if (likeId != null) {
      await _apiClient.delete('/api/user-artists/$likeId');
      return null;
    }

    final response = await _apiClient.post(
      '/api/user-artists',
      data: {
        'data': {'Artist': artistId},
      },
    );
    return response.data['data']['documentId'] as String;
  }
}
