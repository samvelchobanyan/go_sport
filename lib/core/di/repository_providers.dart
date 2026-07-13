import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/data/repositories/auth_repository_impl.dart';
import 'package:go_sport/data/repositories/albums_repository_impl.dart';
import 'package:go_sport/data/repositories/banner_repository_impl.dart';
import 'package:go_sport/data/repositories/device_repository_impl.dart';
import 'package:go_sport/data/repositories/profile_repository_impl.dart';
import 'package:go_sport/data/repositories/notifications_repository_impl.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';
import 'package:go_sport/data/repositories/artists_repository_impl.dart';
import 'package:go_sport/data/repositories/episodes_repository_impl.dart';
import 'package:go_sport/data/repositories/programs_repository_impl.dart';
import 'package:go_sport/data/repositories/schedule_repository_impl.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';
import 'package:go_sport/domain/repositories/banner_repository.dart';
import 'package:go_sport/domain/repositories/device_repository.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';
import 'package:go_sport/domain/repositories/profile_repository.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

import '../../data/repositories/news_repository_impl.dart';
import '../../data/repositories/custom_playlist_repository_impl.dart';
import '../../data/repositories/featured_playlist_repository_impl.dart';
import '../../data/repositories/story_repository_impl.dart';
import '../../data/repositories/tracks_repository_mock.dart';
import '../../domain/repositories/news_repository.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/custom_playlist_repository.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../../domain/repositories/featured_playlist_repository.dart';
import '../../domain/repositories/search_repository.dart';
import '../../domain/repositories/story_repository.dart';
import '../../domain/repositories/track_repository.dart';
import '../di/network_providers.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryImpl(ref.read(apiClientProvider));
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(ref.read(apiClientProvider));
});

final featuredPlaylistRepositoryProvider = Provider<FeaturedPlaylistRepository>(
  (ref) {
    return FeaturedPlaylistRepositoryImpl(ref.read(apiClientProvider));
  },
);

final customPlaylistRepositoryProvider = Provider<CustomPlaylistRepository>((
  ref,
) {
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

final artistsRepositoryProvider = Provider<ArtistsRepository>((ref) {
  return ArtistsRepositoryImpl(ref.read(apiClientProvider));
});

final albumsRepositoryProvider = Provider<AlbumsRepository>((ref) {
  return AlbumsRepositoryImpl(ref.read(apiClientProvider));
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl(ref.read(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(apiClientProvider));
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepositoryImpl(ref.read(apiClientProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.read(apiClientProvider));
});

final notificationsRepositoryProvider = Provider<NotificationsRepository>((
  ref,
) {
  return NotificationsRepositoryImpl(ref.read(apiClientProvider));
});

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  return DeviceRepositoryImpl(ref.read(apiClientProvider));
});

final bannerRepositoryProvider = Provider<BannerRepository>((ref) {
  return BannerRepositoryImpl(ref.read(apiClientProvider));
});
