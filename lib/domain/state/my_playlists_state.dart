import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/repositories/custom_playlist_repository.dart';
import 'package:go_sport/domain/repositories/featured_playlist_repository.dart';

part 'my_playlists_state.freezed.dart';

@freezed
class MyPlaylistsState with _$MyPlaylistsState {
  const factory MyPlaylistsState({
    @Default([]) List<Playlist> playlists,
    @Default(false) bool isLoading,
    String? error,
  }) = _MyPlaylistsState;
}

class MyPlaylistsStateNotifier extends Notifier<MyPlaylistsState> {
  late final FeaturedPlaylistRepository _featuredRepo;
  late final CustomPlaylistRepository _customRepo;

  @override
  MyPlaylistsState build() {
    _featuredRepo = ref.watch(featuredPlaylistRepositoryProvider);
    _customRepo = ref.watch(customPlaylistRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const MyPlaylistsState();
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final results = await Future.wait([
        _featuredRepo.getLikedFeaturedPlaylists(),
        _customRepo.getCustomPlaylists(),
      ]);
      final playlists = [...results[0], ...results[1]];
      state = state.copyWith(playlists: playlists, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(playlists: []);
    await loadFavorites();
  }

  void removePlaylist(String id) {
    final updated = state.playlists.where((p) => p.id != id).toList();
    state = state.copyWith(playlists: updated);
  }

  void addPlaylist(Playlist playlist) {
    state = state.copyWith(playlists: [playlist, ...state.playlists]);
  }

  void updatePlaylist(Playlist playlist) {
    final updated = state.playlists.map((p) {
      return p.id == playlist.id ? playlist : p;
    }).toList();
    state = state.copyWith(playlists: updated);
  }
}

final myPlaylistsStateProvider =
    NotifierProvider<MyPlaylistsStateNotifier, MyPlaylistsState>(
  MyPlaylistsStateNotifier.new,
);
