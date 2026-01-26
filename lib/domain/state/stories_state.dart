import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/story.dart';
import '../repositories/story_repository.dart';
import '../../core/di/repository_providers.dart';

part 'stories_state.freezed.dart';

@freezed
class StoriesState with _$StoriesState {
  const factory StoriesState({
    @Default({}) Map<String, Story> stories,
    @Default(false) bool isLoading,
    String? error,
  }) = _StoriesState;
}

extension StoriesStateX on StoriesState {
  List<Story> get storiesList => stories.values.toList();
  
  Story? getStory(String id) => stories[id];
}

class StoriesNotifier extends Notifier<StoriesState> {
  late final StoryRepository _repository;

  @override
  StoriesState build() {
    _repository = ref.watch(storyRepositoryProvider);
    Future.microtask(() => loadStories());
    return const StoriesState();
  }

  Future<void> loadStories() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final stories = await _repository.getStories();
      final storiesMap = {for (final story in stories) story.id: story};
      state = state.copyWith(stories: storiesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void markAsViewed(String id) {
    final story = state.stories[id];
    if (story == null || story.isViewed) return;

    final updatedStory = story.copyWith(isViewed: true);
    state = state.copyWith(
      stories: {...state.stories, id: updatedStory},
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(stories: {});
    await loadStories();
  }
}

final storiesStateProvider = NotifierProvider<StoriesNotifier, StoriesState>(
  StoriesNotifier.new,
);
