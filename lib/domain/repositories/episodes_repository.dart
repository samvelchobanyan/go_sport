import 'package:go_sport/domain/entities/track.dart';

abstract interface class EpisodesRepository {
  // Future<List<Track>> getAllEpisodes();
  Future<List<Track>> getFeaturedEpisodes();
  Future<List<Track>> getFavoriteEpisodes();

  Future<void> toggleLike(String id);

  /// The previous behaviour of `getFeaturedSongs` was to return some hard‑
  /// coded subset; now it is a convenience wrapper that filters
  /// `getAllEpisodes()` by [Track.isLiked].
}
