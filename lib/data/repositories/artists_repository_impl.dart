import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/album_dto.dart';
import 'package:go_sport/data/dto/artist_dto.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
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
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => ArtistDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<List<Artist>> getFavoriteArtists() async {
    throw UnimplementedError('getFavoriteArtists requires authentication');
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

    return albumsData
        .map((e) => AlbumDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<void> toggleLike(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
