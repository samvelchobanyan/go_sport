import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';

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
  late final EpisodesRepository _repository;

  @override
  EpisodesState build() {
    _repository = ref.watch(episodesRepositoryProvider);
    Future.microtask(() => loadEpisodes());
    return const EpisodesState();
  }

  Future<void> loadEpisodes() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final episodes = await _repository.getFeaturedEpisodes();

      final episodesMap = {
        ...state.episodes,
        for (final episode in episodes) episode.id: episode,
      };

      state = state.copyWith(episodes: episodesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadFeaturedPrograms() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final episodes = await _repository.getFeaturedEpisodes();

      final episodesMap = {for (final episode in episodes) episode.id: episode};

      state = state.copyWith(episodes: episodesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final episodes = await _repository.getFavoriteEpisodes();

      final episodesMap = {for (final episode in episodes) episode.id: episode};

      state = state.copyWith(episodes: episodesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    // try {
    //   final newEpisodes = _repository.getAllEpisodes();
    //   final episodesMap = {
    //     ...state.episodes,
    //     for (final episode in newEpisodes) episode.id: episode,
    //   };
    //   state = state.copyWith(episodes: episodesMap, isLoadingMore: false);
    // } catch (e) {
    //   state = state.copyWith(isLoadingMore: false, error: e.toString());
    // }
  }

  Future<void> refresh() async {
    state = state.copyWith(episodes: {});
    await loadEpisodes();
  }
}

final episodesStateProvider = NotifierProvider<EpisodesNotifier, EpisodesState>(
  EpisodesNotifier.new,
);
