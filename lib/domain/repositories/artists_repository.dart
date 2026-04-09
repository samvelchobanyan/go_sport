import 'package:go_sport/domain/entities/artist.dart';

abstract interface class ArtistsRepository {
  Future<List<Artist>> getFeaturedArtists();
  Future<List<Artist>> getFavoriteArtists();

  Future<void> toggleLike(String id);
}
