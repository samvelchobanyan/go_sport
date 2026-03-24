import 'package:go_sport/domain/entities/track.dart';

abstract interface class TrackRepository {
  /// Returns every track available in the repository.
  Future<List<Track>> getAllTracks();
}
