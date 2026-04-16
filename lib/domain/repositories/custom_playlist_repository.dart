import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';

abstract interface class CustomPlaylistRepository {
  Future<List<Playlist>> getCustomPlaylists();
  Future<List<Track>> getCustomPlaylistTracks(String id);
  Future<Playlist> createCustomPlaylist(String name);
  Future<Playlist> updateCustomPlaylist({
    required String id,
    required String name,
    required List<String> trackDocIds,
  });
  Future<void> deleteCustomPlaylist(String id);
}
