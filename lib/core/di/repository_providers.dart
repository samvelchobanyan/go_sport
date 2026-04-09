import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/data/repositories/albums_repository_mock.dart';
import 'package:go_sport/data/repositories/artists_repository_mock.dart';
import 'package:go_sport/data/repositories/auth_repository_mock.dart';
import 'package:go_sport/data/repositories/episodes_repository_mock.dart';
import 'package:go_sport/data/repositories/music_repository_mock.dart';
import 'package:go_sport/data/repositories/programs_repository_mock.dart';
import 'package:go_sport/data/repositories/schedule_repository_mock.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';
import 'package:go_sport/domain/repositories/music_repository.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

import '../../data/repositories/news_repository_mock.dart';
import '../../data/repositories/playlist_repository_mock.dart';
import '../../data/repositories/story_repository_mock.dart';
import '../../data/repositories/tracks_repository_mock.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/repositories/playlist_repository.dart';
import '../../domain/repositories/story_repository.dart';
import '../../domain/repositories/track_repository.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryMock();
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return MockNewsRepository();
});

final playlistRepositoryProvider = Provider<PlaylistRepository>((ref) {
  return PlaylistRepositoryMock();
});

final tracksRepositoryProvider = Provider<TrackRepository>((ref) {
  return TrackRepositoryMock();
});

final episodesRepositoryProvider = Provider<EpisodesRepository>((ref) {
  return EpisodesRepositoryMock();
});

final programsRepositoryProvider = Provider<ProgramsRepository>((ref) {
  return ProgramsRepositoryMock();
});


final musicRepositoryProvider = Provider<MusicRepository>((ref) {
  return MusicRepositoryMock();
});

final artistsRepositoryProvider = Provider<ArtistsRepository>((ref) {
  return ArtistsRepositoryMock();
});

final albumsRepositoryProvider = Provider<AlbumsRepository>((ref) {
  return AlbumsRepositoryMock();
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryMock();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryMock();
});