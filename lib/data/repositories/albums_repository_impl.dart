import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/album_dto.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';

class AlbumsRepositoryImpl implements AlbumsRepository {
  final ApiClient _apiClient;

  AlbumsRepositoryImpl(this._apiClient);
      
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
  Future<List<Album>> getFavoriteAlbums() async {
    throw UnimplementedError('getFavoritePlaylists requires authentication');
  }

  @override
  Future<void> toggleLike(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // В реальном API здесь будет HTTP запрос
    // Состояние обновляется в domain state (optimistic update)
  }
}
