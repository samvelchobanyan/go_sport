import '../entities/playlist.dart';

abstract interface class PlaylistRepository {
  Future<List<Playlist>> getFeaturedPlaylists();
}
