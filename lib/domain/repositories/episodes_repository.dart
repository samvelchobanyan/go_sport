import 'package:go_sport/domain/entities/track.dart';

abstract interface class EpisodesRepository {
  Future<List<Track>> getFeaturedEpisodes();
  Future<({List<Track> items, bool hasMore})> getFavoriteEpisodes({
    int page = 1,
    int pageSize = 20,
  });

  /// Toggles like for an episode. Pass [likeId] to unlike, omit to like.
  /// Returns the new like documentId, or null if unliked.
  Future<String?> toggleLikeEpisode(String episodeId, [String? likeId]);
}
