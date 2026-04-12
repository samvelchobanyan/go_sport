import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';

abstract interface class ProgramsRepository {
  /// Returns every program available in the repository.
  Future<List<Program>> getAllPrograms();
  Future<List<Program>> getFeaturedPrograms();
  Future<List<Program>> getFavoritePrograms();
  Future<List<Program>> getProgramsByDate(DateTime date);
  Future<List<Track>> getProgramEpisodes(String programId);

  Future<String?> toggleLike(String programId, [String? likeId]);
}
