import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/data/repositories/episodes_repository_mock.dart';

part 'episodes_controller.freezed.dart';

@freezed
class EpisodesListState with _$EpisodesListState {
  const factory EpisodesListState({
    @Default([]) List<Track> episodes,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    String? error,
  }) = _EpisodesListState;
}

class EpisodesListNotifier extends AutoDisposeNotifier<EpisodesListState> {
  static const int _pageSize = 20;
  List<Track> _allEpisodes = [];

  @override
  EpisodesListState build() {
    Future.microtask(() => loadInitial());
    return const EpisodesListState();
  }

  Future<void> loadInitial() async {
    state = state.copyWith(isLoading: true, error: null, episodes: []);
    _allEpisodes = [];

    try {
      _allEpisodes = EpisodesRepositoryMock.getMockEpisodes();
      state = state.copyWith(
        episodes: _allEpisodes,
        hasMore: _allEpisodes.length >= _pageSize,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    _allEpisodes = [];
    await loadInitial();
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newEpisodes = EpisodesRepositoryMock.getMockEpisodes();
      _allEpisodes = [..._allEpisodes, ...newEpisodes];
      state = state.copyWith(
        episodes: _allEpisodes,
        hasMore: newEpisodes.length >= _pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }
}

final episodesListStateProvider =
    NotifierProvider.autoDispose<EpisodesListNotifier, EpisodesListState>(
      EpisodesListNotifier.new,
    );
