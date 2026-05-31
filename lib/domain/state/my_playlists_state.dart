import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/repositories/custom_playlist_repository.dart';
import 'package:go_sport/domain/state/like_registry.dart';

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
  late final CustomPlaylistRepository _customRepo;
  List<Playlist> _customPlaylists = const [];

  @override
  MyPlaylistsState build() {
    _customRepo = ref.watch(customPlaylistRepositoryProvider);

    // Re-combine when registry's liked playlists change.
    ref.listen(
      likeRegistryProvider.select((s) => s.likedPlaylists),
      (_, next) {
        state = state.copyWith(playlists: [...next, ..._customPlaylists]);
      },
    );

    Future.microtask(loadFavorites);

    final initialFeatured = ref.read(likeRegistryProvider).likedPlaylists;
    return MyPlaylistsState(playlists: initialFeatured);
  }

  /// Loads only custom playlists from API; featured-liked come from registry.
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      _customPlaylists = await _customRepo.getCustomPlaylists();
      state = state.copyWith(
        playlists: [..._likedFeatured, ..._customPlaylists],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(playlists: []);
    await loadFavorites();
  }

  void removePlaylist(String id) {
    _customPlaylists = _customPlaylists.where((p) => p.id != id).toList();
    state = state.copyWith(playlists: [..._likedFeatured, ..._customPlaylists]);
  }

  void addPlaylist(Playlist playlist) {
    _customPlaylists = [playlist, ..._customPlaylists];
    state = state.copyWith(playlists: [..._likedFeatured, ..._customPlaylists]);
  }

  void updatePlaylist(Playlist playlist) {
    _customPlaylists = _customPlaylists
        .map((p) => p.id == playlist.id ? playlist : p)
        .toList();
    state = state.copyWith(playlists: [..._likedFeatured, ..._customPlaylists]);
  }

  List<Playlist> get _likedFeatured =>
      ref.read(likeRegistryProvider).likedPlaylists;
}

final myPlaylistsStateProvider =
    NotifierProvider<MyPlaylistsStateNotifier, MyPlaylistsState>(
  MyPlaylistsStateNotifier.new,
);
