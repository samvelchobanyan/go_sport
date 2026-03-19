import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';

part 'episodes_controller.freezed.dart';

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
  late final EpisodesRepository _repository;

  @override
  EpisodesState build() {
    _repository = ref.watch(episodesRepositoryProvider);
    Future.microtask(() => loadFavoriteEpisodes());
    return const EpisodesState();
  }

  Future<void> loadFavoriteEpisodes() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final episodes = await _repository.getFavoriteEpisodes();

      final episodesMap = {
        ...state.episodes,
        for (final episode in episodes) episode.id: episode,
      };

      state = state.copyWith(episodes: episodesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final episodes = await _repository.getFavoriteEpisodes();
      final episodesMap = {
        ...state.episodes,
        for (final episode in episodes) episode.id: episode,
      };
      state = state.copyWith(episodes: episodesMap, isLoadingMore: false);
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(episodes: {});
    await loadFavoriteEpisodes();
  }
}

final episodesStateProvider = NotifierProvider<EpisodesNotifier, EpisodesState>(
  EpisodesNotifier.new,
);
