import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';

part 'new_episodes_controller.freezed.dart';

@freezed
class NewEpisodesState with _$NewEpisodesState {
  const factory NewEpisodesState({
    @Default([]) List<Track> episodes,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _NewEpisodesState;
}

class NewEpisodesNotifier extends Notifier<NewEpisodesState> {
  late final EpisodesRepository _repository;

  @override
  NewEpisodesState build() {
    _repository = ref.watch(episodesRepositoryProvider);
    Future.microtask(() => loadEpisodes());
    return const NewEpisodesState();
  }

  Future<void> loadEpisodes() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final episodes = await _repository.getFavoriteEpisodes();

      state = state.copyWith(
        episodes: episodes,
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
      state = state.copyWith(
        episodes: [...state.episodes, ...newEpisodes],
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(episodes: []);
    await loadEpisodes();
  }
}

final newEpisodesStateProvider =
    NotifierProvider<NewEpisodesNotifier, NewEpisodesState>(
  NewEpisodesNotifier.new,
);
