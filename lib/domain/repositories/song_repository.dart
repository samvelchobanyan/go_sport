import '../entities/song.dart';

abstract interface class SongRepository {
  Future<List<Song>> getFeaturedSongs();
}
