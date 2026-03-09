import 'package:go_sport/domain/repositories/music_repository.dart';

class MusicRepositoryMock implements MusicRepository {
  @override
  Future<int> getFavoritesCount() async => 5;

  @override
  Future<int> getPlaylistsCount() async => 14;

  @override
  Future<int> getAlbumsCount() async => 21;

  @override
  Future<int> getArtistsCount() async => 16;

  @override
  Future<int> getEpisodesCount() async => 6;

  @override
  Future<int> getProgramsCount() async => 5;
}
