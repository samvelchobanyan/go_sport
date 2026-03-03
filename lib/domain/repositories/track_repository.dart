import 'package:go_sport/domain/entities/track.dart';

abstract interface class TrackRepository {
  /// Returns every track available in the repository.
  Future<List<Track>> getAllTracks();

  /// Returns only the liked tracks (favorites).
  ///
  /// The previous behaviour of `getFeaturedSongs` was to return some hard‑
  /// coded subset; now it is a convenience wrapper that filters
  /// `getAllTracks()` by [Track.isLiked].
  Future<List<Track>> getFeaturedTracks();
}
