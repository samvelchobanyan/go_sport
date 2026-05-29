import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';
import 'package:go_sport/domain/state/like_registry.dart';

part 'new_episodes_controller.freezed.dart';

@freezed
class NewEpisodesState with _$NewEpisodesState {
  const factory NewEpisodesState({
    @Default([]) List<Track> episodes,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    String? error,
  }) = _NewEpisodesState;
}

class NewEpisodesNotifier extends Notifier<NewEpisodesState> {
  late final EpisodesRepository _repository;

  @override
  NewEpisodesState build() {
    _repository = ref.watch(episodesRepositoryProvider);
    ref.listen(
      likeRegistryProvider.select((s) => s.episodeLikes),
      (_, next) {
        if (state.episodes.isEmpty) return;
        final kept = state.episodes.where((e) => next.containsKey(e.id)).toList();
        if (kept.length != state.episodes.length) {
          state = state.copyWith(episodes: kept);
        }
      },
    );
    Future.microtask(() => loadEpisodes());
    return const NewEpisodesState();
  }

  Future<void> loadEpisodes() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getFavoriteEpisodes(page: 1);

      state = state.copyWith(
        episodes: result.items,
        currentPage: 1,
        hasMore: result.hasMore,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final result = await _repository.getFavoriteEpisodes(page: nextPage);
      state = state.copyWith(
        episodes: [...state.episodes, ...result.items],
        currentPage: nextPage,
        hasMore: result.hasMore,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(
      episodes: [],
      currentPage: 1,
      hasMore: true,
    );
    await loadEpisodes();
  }
}

final newEpisodesStateProvider =
    NotifierProvider<NewEpisodesNotifier, NewEpisodesState>(
  NewEpisodesNotifier.new,
);
