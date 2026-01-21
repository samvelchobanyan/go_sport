import '../entities/artist.dart';

abstract interface class ArtistRepository {
  Future<List<Artist>> getFeaturedArtists();
}
