import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/track.dart';

abstract interface class AlbumsRepository {

  Future<List<Album>> getFeaturedAlbums();
  Future<({List<Album> items, bool hasMore})> getFavoriteAlbums({
    int page = 1,
    int pageSize = 20,
  });
  Future<({Album album, List<Track> tracks})> getAlbumDetails(String albumId);

  Future<String?> toggleLike(String albumId, [String? likeId]);

}
