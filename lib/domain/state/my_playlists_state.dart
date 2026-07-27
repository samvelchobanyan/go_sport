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
    ref.listen(likeRegistryProvider.select((s) => s.likedPlaylists), (_, __) {
      state = state.copyWith(playlists: _recombine());
    });

    Future.microtask(loadFavorites);

    return MyPlaylistsState(playlists: _recombine());
  }

  /// Loads only custom playlists from API; featured-liked come from registry.
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      _customPlaylists = await _customRepo.getCustomPlaylists();
      state = state.copyWith(
        playlists: _recombine(),
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
    state = state.copyWith(playlists: _recombine());
  }

  void addPlaylist(Playlist playlist) {
    _customPlaylists = [playlist, ..._customPlaylists];
    state = state.copyWith(playlists: _recombine());
  }

  void updatePlaylist(Playlist playlist) {
    _customPlaylists = _customPlaylists
        .map((p) => p.id == playlist.id ? playlist : p)
        .toList();
    state = state.copyWith(playlists: _recombine());
  }

  List<Playlist> get _likedFeatured =>
      ref.read(likeRegistryProvider).likedPlaylists;

  /// Единая пересборка списка: сливает лайкнутые (из реестра) и кастомные,
  /// затем сортирует по времени попадания в списки (createdAt) — свежие сверху.
  /// Кастомные выигрывают при коллизии id, поэтому их метаданные (в т.ч.
  /// createdAt = время создания) остаются авторитетными. Инвариант: у элементов
  /// в стейте createdAt всегда заполнен, поэтому null-хвост — лишь страховка.
  List<Playlist> _recombine() {
    final merged = <String, Playlist>{};
    for (final p in _likedFeatured) {
      merged[p.id] = p;
    }
    for (final p in _customPlaylists) {
      merged[p.id] = p;
    }
    final list = merged.values.toList();
    list.sort((a, b) {
      final ax = a.createdAt;
      final bx = b.createdAt;
      if (ax == null && bx == null) return 0;
      if (ax == null) return 1; // null → в конец
      if (bx == null) return -1;
      return bx.compareTo(ax); // по убыванию: новое сверху
    });
    return list;
  }
}

final myPlaylistsStateProvider =
    NotifierProvider<MyPlaylistsStateNotifier, MyPlaylistsState>(
      MyPlaylistsStateNotifier.new,
    );
