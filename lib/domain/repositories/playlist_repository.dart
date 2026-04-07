import '../entities/playlist.dart';
import '../entities/track.dart';

abstract interface class PlaylistRepository {
  Future<List<Playlist>> getFeaturedPlaylists();
  Future<List<Track>> getPlaylistTracks(String playlistId);
  Future<List<Playlist>> getFavoritePlaylists();
  Future<List<Track>> getFavoriteTracks();
  Future<String?> toggleLike(String playlistId, [String? likeId]);
}
