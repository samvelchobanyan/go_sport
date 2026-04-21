import '../entities/track.dart';

abstract interface class SearchRepository {
  Future<({List<Track> items, bool hasMore})> searchTracks({
    required String query,
    int page = 1,
    int pageSize = 25,
  });
}
