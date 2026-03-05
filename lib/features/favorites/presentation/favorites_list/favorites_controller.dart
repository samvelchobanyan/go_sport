import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/track.dart';
import '../../../../domain/repositories/playlist_repository.dart';
import '../../../../core/di/repository_providers.dart';

part 'favorites_controller.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default({}) Map<String, Track> favorites,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _FavoritesState;
}

extension FavoritesStateX on FavoritesState {
  List<Track> get favoritesList => favorites.values.toList();

  Track? getFavorite(String id) => favorites[id];
}

class FavoritesNotifier extends Notifier<FavoritesState> {
  late final PlaylistRepository _repository;

  @override
  FavoritesState build() {
    _repository = ref.watch(playlistRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const FavoritesState();
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final tracks = await _repository.getFavoritesPlaylist();
      final favoritesMap = <String, Track>{
        for (final track in tracks) track.id: track,
      };
      state = state.copyWith(favorites: favoritesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newTracks = await _repository.getFavoritesPlaylist();
      final favoritesMap = <String, Track>{
        ...state.favorites,
        for (final track in newTracks) track.id: track,
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
}

final favoritesStateProvider =
    NotifierProvider<FavoritesNotifier, FavoritesState>(FavoritesNotifier.new);
