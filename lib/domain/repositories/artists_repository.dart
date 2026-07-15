import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/entities/track.dart';

abstract interface class ArtistsRepository {
  Future<List<Artist>> getFeaturedArtists();
  Future<({List<Artist> items, bool hasMore})> getFavoriteArtists({
    int page = 1,
    int pageSize = 20,
  });

  /// Hero data only (name + cover). Needed just for id-only opens (player).
  Future<Artist> getArtist(String artistId);

  Future<({List<Track> items, bool hasMore})> getArtistTracks(
    String artistId, {
    int page = 1,
    int pageSize = 25,
  });

  Future<({List<Album> items, bool hasMore})> getArtistAlbums(
    String artistId, {
    int page = 1,
    int pageSize = 25,
  });

  /// Tracks without an album, rendered as one-track pseudo-albums by the UI.
  Future<({List<Track> items, bool hasMore})> getArtistSingles(
    String artistId, {
    int page = 1,
    int pageSize = 25,
  });

  Future<String?> toggleLike(String artistId, [String? likeId]);
}
