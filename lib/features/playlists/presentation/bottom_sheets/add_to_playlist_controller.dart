import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/my_playlists_state.dart';

part 'add_to_playlist_controller.freezed.dart';

@freezed
class AddToPlaylistState with _$AddToPlaylistState {
  const factory AddToPlaylistState({
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    @Default([]) List<Playlist> playlists,
    @Default({}) Set<String> selectedIds,
    @Default({}) Set<String> initialSelectedIds,
    String? error,
  }) = _AddToPlaylistState;
}

class AddToPlaylistNotifier
    extends AutoDisposeFamilyNotifier<AddToPlaylistState, Track> {
  @override
  AddToPlaylistState build(Track arg) {
    Future.microtask(() => _init());
    return const AddToPlaylistState();
  }

  Future<void> _init() async {
    final myPlaylistsNotifier = ref.read(myPlaylistsStateProvider.notifier);
    var myPlaylists = ref.read(myPlaylistsStateProvider).playlists;

    // Если список пуст, значит мы еще не загружали вкладку "My Playlists"
    if (myPlaylists.isEmpty) {
      await myPlaylistsNotifier.loadFavorites();
      myPlaylists = ref.read(myPlaylistsStateProvider).playlists;
    }

    // Оставляем только кастомные плейлисты
    final customPlaylists =
        myPlaylists.where((p) => p.type == PlaylistType.custom).toList();

    // Находим, где трек уже добавлен
    final selected = <String>{};
    for (final p in customPlaylists) {
      if (p.trackDocIds.contains(arg.id)) {
        selected.add(p.id);
      }
    }

    state = state.copyWith(
      isLoading: false,
      playlists: customPlaylists,
      selectedIds: selected,
      initialSelectedIds: Set.from(selected),
    );
  }

  void toggle(String playlistId) {
    final newSelected = Set<String>.from(state.selectedIds);
    if (newSelected.contains(playlistId)) {
      newSelected.remove(playlistId);
    } else {
      newSelected.add(playlistId);
    }
    state = state.copyWith(selectedIds: newSelected);
  }

  Future<bool> save() async {
    state = state.copyWith(isSaving: true, error: null);
    try {
      final toAdd = state.selectedIds.difference(state.initialSelectedIds);
      final toRemove = state.initialSelectedIds.difference(state.selectedIds);

      // Если ничего не изменилось
      if (toAdd.isEmpty && toRemove.isEmpty) {
        state = state.copyWith(isSaving: false);
        return true;
      }

      final repo = ref.read(customPlaylistRepositoryProvider);
      final globalNotifier = ref.read(myPlaylistsStateProvider.notifier);

      for (final playlist in state.playlists) {
        bool needsUpdate = false;
        List<String> newTracks = List.from(playlist.trackDocIds);

        if (toAdd.contains(playlist.id)) {
          newTracks.add(arg.id);
          needsUpdate = true;
        } else if (toRemove.contains(playlist.id)) {
          newTracks.remove(arg.id);
          needsUpdate = true;
        }

        if (needsUpdate) {
          final updated = await repo.updateCustomPlaylist(
            id: playlist.id,
            name: playlist.title,
            trackDocIds: newTracks,
          );
          // Обновляем глобальный стейт, чтобы на остальных экранах сразу изменился trackCount
          globalNotifier.updatePlaylist(updated);
        }
      }

      state = state.copyWith(isSaving: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      return false;
    }
  }
}

final addToPlaylistControllerProvider = NotifierProvider.family
    .autoDispose<AddToPlaylistNotifier, AddToPlaylistState, Track>(
  AddToPlaylistNotifier.new,
);