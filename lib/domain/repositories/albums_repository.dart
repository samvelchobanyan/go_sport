import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/track.dart';

abstract interface class AlbumsRepository {

  Future<List<Album>> getFeaturedAlbums();
  Future<List<Album>> getFavoriteAlbums();
  Future<List<Track>> getAlbumTracks(String albumId);

  Future<String?> toggleLike(String albumId, [String? likeId]);

}
