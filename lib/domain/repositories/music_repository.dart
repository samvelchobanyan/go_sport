abstract class MusicRepository {
  Future<int> getFavoritesCount();
  Future<int> getPlaylistsCount();
  Future<int> getAlbumsCount();
  Future<int> getArtistsCount();
  Future<int> getEpisodesCount();
  Future<int> getProgramsCount();
}
