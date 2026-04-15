import '../entities/playlist.dart';
import '../entities/track.dart';

abstract interface class PlaylistRepository {
  Future<List<Playlist>> getFeaturedPlaylists();
  Future<List<Track>> getPlaylistTracks(String playlistId);
  Future<List<Playlist>> getFavoritePlaylists();
  Future<({List<Track> items, bool hasMore})> getFavoriteTracks({
    int page = 1,
    int pageSize = 20,
  });
  Future<String?> toggleLike(String playlistId, [String? likeId]);
  Future<String?> toggleLikeTrack(String trackId, [String? likeId]);
}
