import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';
import 'package:go_sport/domain/repositories/playlist_repository.dart';

part 'playlists_controller.freezed.dart';

@freezed
class PlaylistsState with _$PlaylistsState {
  const factory PlaylistsState({
    @Default([]) List<Playlist> playlists,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _PlaylistsState;
}

class PlaylistsNotifier extends Notifier<PlaylistsState> {
  late final PlaylistRepository _repository;

  @override
  PlaylistsState build() {
    _repository = ref.watch(playlistRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const PlaylistsState();
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

  /// Optimistic like toggle
  // Future<void> toggleLike(String id) async {
  // final index = state.playlists.indexWhere((p) => p.id == id);
  // if (index == -1) return;

  // final playlist = state.playlists[index];
  // final updated = playlist.copyWith(isLiked: !playlist.isLiked);

  // // Optimistic update
  // final updatedList = [...state.playlists];
  // updatedList[index] = updated;

  // state = state.copyWith(playlists: updatedList);

  // try {
  //   await _repository.toggleLike(id);
  // } catch (e) {
  //   // rollback
  //   final rollbackList = [...state.playlists];
  //   rollbackList[index] = playlist;

  //   state = state.copyWith(
  //     playlists: rollbackList,
  //     error: e.toString(),
  //   );
  // }
  // }

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

final playlistsStateProvider =
    NotifierProvider<PlaylistsNotifier, PlaylistsState>(PlaylistsNotifier.new);
