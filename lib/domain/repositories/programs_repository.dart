import 'package:go_sport/domain/entities/program.dart';

abstract interface class ProgramsRepository {
  /// Returns every program available in the repository.
  Future<List<Program>> getAllPrograms();
  Future<List<Program>> getFeaturedPrograms();
  Future<List<Program>> getFavoritePrograms();
  Future<Program> getProgram(String programId);

  Future<void> toggleLike(String id);

  /// The previous behaviour of `getFeaturedSongs` was to return some hard‑
  /// coded subset; now it is a convenience wrapper that filters
  /// `getAllPrograms()` by [Track.isLiked].
}
