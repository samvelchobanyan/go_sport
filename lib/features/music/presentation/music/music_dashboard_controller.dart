import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/repositories/music_repository.dart';

part 'music_dashboard_controller.freezed.dart';

@freezed
class MusicDashboardState with _$MusicDashboardState {
  const factory MusicDashboardState({
    @Default(false) bool isLoading,
    String? error,
    @Default(0) int favoritesCount,
    @Default(0) int playlistsCount,
    @Default(0) int albumsCount,
    @Default(0) int artistsCount,
    @Default(0) int episodesCount,
    @Default(0) int programsCount,
  }) = _MusicDashboardState;
}
class MusicDashboardController
    extends AutoDisposeNotifier<MusicDashboardState> {
  late final MusicRepository _repository;

  @override
  MusicDashboardState build() {
    _repository = ref.watch(musicRepositoryProvider);
    Future.microtask(() => load());
    return const MusicDashboardState();
  }


  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final favorites = await _repository.getFavoritesCount();
      final playlists = await _repository.getPlaylistsCount();
      final albums = await _repository.getAlbumsCount();
      final artists = await _repository.getArtistsCount();
      final episodes = await _repository.getEpisodesCount();
      final programs = await _repository.getProgramsCount();

      state = state.copyWith(
        isLoading: false,
        favoritesCount: favorites,
        playlistsCount: playlists,
        albumsCount: albums,
        artistsCount: artists,
        episodesCount: episodes,
        programsCount: programs,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async => await load();
}

final musicStateProvider =
    NotifierProvider.autoDispose<MusicDashboardController, MusicDashboardState>(
        MusicDashboardController.new);