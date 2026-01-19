import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/news_repository_mock.dart';
import '../../data/repositories/playlist_repository_mock.dart';
import '../../data/repositories/story_repository_mock.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/repositories/playlist_repository.dart';
import '../../domain/repositories/story_repository.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryMock();
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return MockNewsRepository();
});

final playlistRepositoryProvider = Provider<PlaylistRepository>((ref) {
  return PlaylistRepositoryMock();
});
