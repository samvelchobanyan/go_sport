import '../entities/playlist.dart';
import '../entities/track.dart';

abstract interface class PlaylistRepository {
  Future<List<Playlist>> getFeaturedPlaylists();
  Future<List<Track>> getPlaylistTracks(String playlistId);
  Future<List<Track>> getFavoritesPlaylist();
  Future<void> toggleLike(String playlistId);
}
