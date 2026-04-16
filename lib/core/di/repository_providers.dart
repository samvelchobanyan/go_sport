import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/data/repositories/auth_repository_impl.dart';
import 'package:go_sport/data/repositories/albums_repository_impl.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';
import 'package:go_sport/data/repositories/artists_repository_impl.dart';
import 'package:go_sport/data/repositories/episodes_repository_impl.dart';
import 'package:go_sport/data/repositories/music_repository_mock.dart';
import 'package:go_sport/data/repositories/programs_repository_impl.dart';
import 'package:go_sport/data/repositories/schedule_repository_mock.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';
import 'package:go_sport/domain/repositories/music_repository.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

import '../../data/repositories/news_repository_mock.dart';
import '../../data/repositories/custom_playlist_repository_impl.dart';
import '../../data/repositories/featured_playlist_repository_impl.dart';
import '../../data/repositories/story_repository_mock.dart';
import '../../data/repositories/tracks_repository_mock.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/repositories/custom_playlist_repository.dart';
import '../../domain/repositories/featured_playlist_repository.dart';
import '../../domain/repositories/story_repository.dart';
import '../../domain/repositories/track_repository.dart';
import '../di/network_providers.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryMock();
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return MockNewsRepository();
});

final featuredPlaylistRepositoryProvider = Provider<FeaturedPlaylistRepository>((ref) {
  return FeaturedPlaylistRepositoryImpl(ref.read(apiClientProvider));
});

final customPlaylistRepositoryProvider = Provider<CustomPlaylistRepository>((ref) {
  return CustomPlaylistRepositoryImpl(ref.read(apiClientProvider));
});

final tracksRepositoryProvider = Provider<TrackRepository>((ref) {
  return TrackRepositoryMock();
});

final episodesRepositoryProvider = Provider<EpisodesRepository>((ref) {
  return EpisodesRepositoryImpl(ref.read(apiClientProvider));
});

final programsRepositoryProvider = Provider<ProgramsRepository>((ref) {
  return ProgramsRepositoryImpl(ref.read(apiClientProvider));
});

final musicRepositoryProvider = Provider<MusicRepository>((ref) {
  return MusicRepositoryMock();
});

final artistsRepositoryProvider = Provider<ArtistsRepository>((ref) {
  return ArtistsRepositoryImpl(ref.read(apiClientProvider));
});

final albumsRepositoryProvider = Provider<AlbumsRepository>((ref) {
  return AlbumsRepositoryImpl(ref.read(apiClientProvider));
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryMock();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(apiClientProvider));
});
