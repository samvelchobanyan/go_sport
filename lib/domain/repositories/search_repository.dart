import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/playlist.dart';
import '../entities/program.dart';
import '../entities/track.dart';

abstract interface class SearchRepository {
  Future<({List<Track> items, bool hasMore})> searchTracks({
    required String query,
    int page = 1,
    int pageSize = 25,
  });

  Future<({List<Album> items, bool hasMore})> searchAlbums({
    required String query,
    int page = 1,
    int pageSize = 25,
  });

  Future<({List<Artist> items, bool hasMore})> searchArtists({
    required String query,
    int page = 1,
    int pageSize = 25,
  });

  Future<({List<Program> items, bool hasMore})> searchPrograms({
    required String query,
    int page = 1,
    int pageSize = 25,
  });

  Future<({List<Playlist> items, bool hasMore})> searchPlaylists({
    required String query,
    int page = 1,
    int pageSize = 25,
  });
}
