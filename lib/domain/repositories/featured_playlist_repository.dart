import '../entities/playlist.dart';
import '../entities/track.dart';

abstract interface class FeaturedPlaylistRepository {
  Future<List<Playlist>> getFeaturedPlaylists();
  Future<List<Track>> getPlaylistTracks(String playlistId);
  Future<List<Playlist>> getLikedFeaturedPlaylists();
  Future<({List<Track> items, bool hasMore})> getFavoriteTracks({
    int page = 1,
    int pageSize = 20,
  });
  Future<String?> toggleLike(String playlistId, [String? likeId]);
  Future<String?> toggleLikeTrack(String trackId, [String? likeId]);
}
