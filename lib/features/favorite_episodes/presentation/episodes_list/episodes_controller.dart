import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';

part 'episodes_controller.freezed.dart';

@freezed
class EpisodesState with _$EpisodesState {
  const factory EpisodesState({
    @Default([]) List<Track> episodes,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _EpisodesState;
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

      state = state.copyWith(
        episodes: [...state.episodes, ...episodes],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newEpisodes = await _repository.getFavoriteEpisodes();
      state = state.copyWith(episodes: [...state.episodes, ...newEpisodes]);
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(episodes: []);
    await loadFavoriteEpisodes();
  }
}

final episodesStateProvider = NotifierProvider<EpisodesNotifier, EpisodesState>(
  EpisodesNotifier.new,
);
