import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/playlist.dart';
import '../repositories/featured_playlist_repository.dart';
import '../../core/di/repository_providers.dart';
import 'like_registry.dart';

part 'featured_playlists_state.freezed.dart';

@freezed
class FeaturedPlaylistsState with _$FeaturedPlaylistsState {
  const factory FeaturedPlaylistsState({
    @Default({}) Map<String, Playlist> playlists,
    @Default(false) bool isLoading,
    String? error,
  }) = _FeaturedPlaylistsState;
}

extension FeaturedPlaylistsStateX on FeaturedPlaylistsState {
  List<Playlist> get playlistsList => playlists.values.toList();

  Playlist? getPlaylist(String id) => playlists[id];
}

class FeaturedPlaylistsNotifier extends Notifier<FeaturedPlaylistsState> {
  late final FeaturedPlaylistRepository _repository;

  @override
  FeaturedPlaylistsState build() {
    _repository = ref.watch(featuredPlaylistRepositoryProvider);
    ref.listen(
      likeRegistryProvider.select((s) => s.playlistLikes),
      (_, next) {
        var changed = false;
        final updated = <String, Playlist>{};
        for (final entry in state.playlists.entries) {
          final p = entry.value;
          final liked = next.containsKey(p.id);
          final likeId = next[p.id];
          if (p.isLiked == liked && p.likeId == likeId) {
            updated[entry.key] = p;
          } else {
            changed = true;
            updated[entry.key] = p.copyWith(isLiked: liked, likeId: likeId);
          }
        }
        if (changed) {
          state = state.copyWith(playlists: updated);
        }
      },
    );
    Future.microtask(() => loadPlaylists());
    return const FeaturedPlaylistsState();
  }

  Future<void> loadPlaylists() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final playlists = await _repository.getFeaturedPlaylists();
      final playlistsMap = {for (final p in playlists) p.id: p};
      state = state.copyWith(playlists: playlistsMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(playlists: {});
    await loadPlaylists();
  }

  void updateLike(String playlistId, String? likeId) {
    final playlist = state.playlists[playlistId];
    if (playlist == null) return;

    final updated = playlist.copyWith(
      isLiked: likeId != null,
      likeId: likeId,
    );
    state = state.copyWith(
      playlists: {...state.playlists, playlistId: updated},
    );
  }
}

final featuredPlaylistsStateProvider =
    NotifierProvider<FeaturedPlaylistsNotifier, FeaturedPlaylistsState>(
      FeaturedPlaylistsNotifier.new,
    );
