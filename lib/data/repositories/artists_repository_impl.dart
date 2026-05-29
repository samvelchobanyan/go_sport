import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/album_dto.dart';
import 'package:go_sport/data/dto/artist_dto.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';
import 'package:go_sport/domain/state/like_registry.dart';

class ArtistsRepositoryImpl implements ArtistsRepository {
  final ApiClient _apiClient;
  final LikeRegistry _registry;

  ArtistsRepositoryImpl(this._apiClient, this._registry);

  @override
  Future<List<Artist>> getFeaturedArtists() async {
    final response = await _apiClient.get(
      '/api/artists',
      queryParameters: {
        'populate': '*',
        'filters[Featured][\$eq]': true,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final artists = data
        .map((e) => ArtistDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
    _registry.syncArtistsLikes(artists);
    return artists;
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
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final artistList = data.map((e) {
      final entry = e as Map<String, dynamic>;
      final artistJson = entry['Artist'] as Map<String, dynamic>;
      return ArtistDto.fromJson(artistJson).toDomain();
    }).toList();
    _registry.syncArtistsLikes(artistList);

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: artistList, hasMore: page < pageCount);
  }

  @override
  Future<List<Album>> getArtistAlbums(String artistId) async {
    final response = await _apiClient.get(
      '/api/artists/$artistId',
      queryParameters: {
        'populate[Albums][populate]': '*',
      },
    );

    final data = response.data['data'] as Map<String, dynamic>;
    final albumsData = data['Albums'] as List<dynamic>? ?? [];

    final albums = albumsData
        .map((e) => AlbumDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
    _registry.syncAlbumsLikes(albums);
    return albums;
  }

  @override
  Future<String?> toggleLike(String artistId, [String? likeId]) async {
    if (likeId != null) {
      await _apiClient.delete('/api/user-artists/$likeId');
      _registry.markArtistUnliked(artistId);
      return null;
    }

    final response = await _apiClient.post(
      '/api/user-artists',
      data: {
        'data': {'Artist': artistId},
      },
    );
    final newLikeId = response.data['data']['documentId'] as String;
    _registry.markArtistLiked(artistId, newLikeId);
    return newLikeId;
  }
}
