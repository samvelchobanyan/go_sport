import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';

abstract interface class ArtistsRepository {
  Future<List<Artist>> getFeaturedArtists();
  Future<List<Artist>> getFavoriteArtists();
  Future<List<Album>> getArtistAlbums(String artistId);

  Future<String?> toggleLike(String artistId, [String? likeId]);
}
