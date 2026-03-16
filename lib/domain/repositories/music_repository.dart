import 'package:go_sport/domain/entities/album.dart';

abstract class MusicRepository {
  Future<int> getFavoritesCount();
  Future<int> getPlaylistsCount();
  Future<int> getAlbumsCount();
  Future<int> getArtistsCount();
  Future<int> getEpisodesCount();
  Future<int> getProgramsCount();
  Future<List<Album>> getFeaturedAlbums();
}
