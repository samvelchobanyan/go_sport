import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/repositories/playlist_repository.dart';

part 'my_playlists_controller.freezed.dart';

@freezed
class MyPlaylistsState with _$MyPlaylistsState {
  const factory MyPlaylistsState({
    @Default([]) List<Playlist> playlists,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _MyPlaylistsState;
}

class MyPlaylistsNotifier extends Notifier<MyPlaylistsState> {
  late final PlaylistRepository _repository;

  @override
  MyPlaylistsState build() {
    _repository = ref.watch(playlistRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const MyPlaylistsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final playlists = await _repository.getFavoritePlaylists();

      state = state.copyWith(playlists: playlists, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newPlaylists = await _repository.getFavoritePlaylists();

      final merged = [...state.playlists, ...newPlaylists];

      state = state.copyWith(playlists: merged, isLoadingMore: false);
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(playlists: []);
    await loadFavorites();
  }
}

final myPlaylistsStateProvider =
    NotifierProvider<MyPlaylistsNotifier, MyPlaylistsState>(
  MyPlaylistsNotifier.new,
);
