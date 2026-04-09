import 'package:go_sport/domain/entities/album.dart';

abstract interface class AlbumsRepository {

  Future<List<Album>> getFeaturedAlbums();
  Future<List<Album>> getFavoriteAlbums();

  Future<void> toggleLike(String id);


}
