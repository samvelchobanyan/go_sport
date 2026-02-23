import '../entities/album.dart';
import '../entities/track.dart';

abstract interface class AlbumRepository {
  Future<List<Album>> getAlbums();
  Future<List<Track>> getAlbumTracks(String albumId);
  Future<void> toggleLike(String albumId);
}
