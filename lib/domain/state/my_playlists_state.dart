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
    ref.listen(likeRegistryProvider.select((s) => s.likedPlaylists), (_, next) {
      // Merge while avoiding duplicates (custom playlists may also be
      // present in the liked list after registry now includes custom).
      final merged = <String, Playlist>{};
      for (final p in next) merged[p.id] = p;
      // Ensure custom playlists take precedence so their metadata (title,
      // trackCount) remains authoritative when updated.
      for (final p in _customPlaylists) merged[p.id] = p;
      state = state.copyWith(playlists: merged.values.toList());
    });

    Future.microtask(loadFavorites);

    final initialFeatured = ref.read(likeRegistryProvider).likedPlaylists;
    return MyPlaylistsState(playlists: initialFeatured);
  }

  /// Loads only custom playlists from API; featured-liked come from registry.
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      _customPlaylists = await _customRepo.getCustomPlaylists();
      final merged = <String, Playlist>{};
      for (final p in _likedFeatured) merged[p.id] = p;
      for (final p in _customPlaylists) merged[p.id] = p;
      state = state.copyWith(
        playlists: merged.values.toList(),
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
    final merged = <String, Playlist>{};
    for (final p in _likedFeatured) merged[p.id] = p;
    for (final p in _customPlaylists) merged[p.id] = p;
    state = state.copyWith(playlists: merged.values.toList());
  }

  void addPlaylist(Playlist playlist) {
    _customPlaylists = [playlist, ..._customPlaylists];
    final merged = <String, Playlist>{};
    for (final p in _likedFeatured) merged[p.id] = p;
    for (final p in _customPlaylists) merged[p.id] = p;
    state = state.copyWith(playlists: merged.values.toList());
  }

  void updatePlaylist(Playlist playlist) {
    _customPlaylists = _customPlaylists
        .map((p) => p.id == playlist.id ? playlist : p)
        .toList();
    final merged = <String, Playlist>{};
    for (final p in _likedFeatured) merged[p.id] = p;
    for (final p in _customPlaylists) merged[p.id] = p;
    state = state.copyWith(playlists: merged.values.toList());
  }

  List<Playlist> get _likedFeatured =>
      ref.read(likeRegistryProvider).likedPlaylists;
}

final myPlaylistsStateProvider =
    NotifierProvider<MyPlaylistsStateNotifier, MyPlaylistsState>(
      MyPlaylistsStateNotifier.new,
    );
