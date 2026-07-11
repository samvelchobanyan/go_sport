import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';

abstract interface class ProgramsRepository {
  /// Returns every program available in the repository.
  Future<List<Program>> getAllPrograms();
  Future<List<Program>> getFeaturedPrograms();
  Future<({List<Program> items, bool hasMore})> getFavoritePrograms({
    int page = 1,
    int pageSize = 20,
  });
  Future<List<Program>> getProgramsByDate(DateTime date);
  /// Program header is derived from the episodes response (each episode
  /// carries its populated Program), so no extra request is needed.
  /// [program] is null when the program has no episodes.
  Future<({Program? program, List<Track> episodes})> getProgramDetails(
    String programId,
  );

  Future<String?> toggleLike(String programId, [String? likeId]);
}
