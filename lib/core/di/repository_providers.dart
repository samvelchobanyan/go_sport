import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/data/repositories/episodes_repository_mock.dart';
import 'package:go_sport/data/repositories/programs_repository_mock.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

import '../../data/repositories/news_repository_mock.dart';
import '../../data/repositories/playlist_repository_mock.dart';
import '../../data/repositories/story_repository_mock.dart';
import '../../data/repositories/artist_repository_mock.dart';
import '../../data/repositories/tracks_repository_mock.dart';
import '../../data/repositories/album_repository_mock.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/repositories/playlist_repository.dart';
import '../../domain/repositories/story_repository.dart';
import '../../domain/repositories/artist_repository.dart';
import '../../domain/repositories/track_repository.dart';
import '../../domain/repositories/album_repository.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryMock();
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return MockNewsRepository();
});

final playlistRepositoryProvider = Provider<PlaylistRepository>((ref) {
  return PlaylistRepositoryMock();
});

final artistRepositoryProvider = Provider<ArtistRepository>((ref) {
  return ArtistRepositoryMock();
});

final tracksRepositoryProvider = Provider<TrackRepository>((ref) {
  return TrackRepositoryMock();
});

final albumRepositoryProvider = Provider<AlbumRepository>((ref) {
  return AlbumRepositoryMock();
});

final episodesRepositoryProvider = Provider<EpisodesRepository>((ref) {
  return EpisodesRepositoryMock();
});

final programsRepositoryProvider = Provider<ProgramsRepository>((ref) {
  return ProgramsRepositoryMock();
});
