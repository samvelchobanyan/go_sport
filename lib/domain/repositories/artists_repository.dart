import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';

abstract interface class ArtistsRepository {
  Future<List<Artist>> getFeaturedArtists();
  Future<({List<Artist> items, bool hasMore})> getFavoriteArtists({
    int page = 1,
    int pageSize = 20,
  });
  Future<({Artist artist, List<Album> albums})> getArtistDetails(
    String artistId,
  );

  Future<String?> toggleLike(String artistId, [String? likeId]);
}
