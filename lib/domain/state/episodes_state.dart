import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/track.dart';

import '../../data/repositories/episodes_repository_mock.dart';

part 'episodes_state.freezed.dart';

@freezed
class EpisodesState with _$EpisodesState {
  const factory EpisodesState({
    @Default({}) Map<String, Track> episodes,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _EpisodesState;
}

extension EpisodesStateX on EpisodesState {
  List<Track> get episodesList => episodes.values.toList();

  Track? getEpisode(String id) => episodes[id];
}

class EpisodesNotifier extends Notifier<EpisodesState> {
  @override
  EpisodesState build() {
    Future.microtask(() => loadEpisodes());
    return const EpisodesState();
  }

  Future<void> loadEpisodes() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final episodes = EpisodesRepositoryMock.getMockEpisodes();
      final episodesMap = {for (final episode in episodes) episode.id: episode};
      state = state.copyWith(episodes: episodesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newEpisodes = EpisodesRepositoryMock.getMockEpisodes();
      final episodesMap = {
        ...state.episodes,
        for (final episode in newEpisodes) episode.id: episode,
      };
      state = state.copyWith(episodes: episodesMap, isLoadingMore: false);
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(episodes: {});
    await loadEpisodes();
  }

}

final episodesStateProvider = NotifierProvider<EpisodesNotifier, EpisodesState>(
  EpisodesNotifier.new,
);
