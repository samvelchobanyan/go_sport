import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/song.dart';
import '../repositories/song_repository.dart';
import '../../core/di/repository_providers.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default({}) Map<String, Song> favorites,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _FavoritesState;
}

extension FavoritesStateX on FavoritesState {
  List<Song> get favoritesList => favorites.values.toList();

  Song? getFavorite(String id) => favorites[id];
}

class FavoritesNotifier extends Notifier<FavoritesState> {
  late final SongRepository _repository;

  @override
  FavoritesState build() {
    _repository = ref.watch(songRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const FavoritesState();
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final songs = await _repository.getFeaturedSongs();
      final favoritesMap = {for (final song in songs) song.id: song};
      state = state.copyWith(favorites: favoritesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newSongs = await _repository.getFeaturedSongs();
      final favoritesMap = {
        ...state.favorites,
        for (final song in newSongs) song.id: song,
      };
      state = state.copyWith(favorites: favoritesMap, isLoadingMore: false);
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(favorites: {});
    await loadFavorites();
  }

  Future<void> toggleFavorite(String id) async {
    final song = state.favorites[id];
    if (song == null) return;

    // Optimistic update
    final updatedSong = song.copyWith(isLiked: !song.isLiked);
    state = state.copyWith(favorites: {...state.favorites, id: updatedSong});

    try {
      // Would call repository to toggle on backend
      // await _repository.toggleLike(id);
    } catch (e) {
      // Rollback on error
      state = state.copyWith(
        favorites: {...state.favorites, id: song},
        error: e.toString(),
      );
    }
  }
}

final favoritesStateProvider =
    NotifierProvider<FavoritesNotifier, FavoritesState>(FavoritesNotifier.new);
