import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/track.dart';
import '../../../../domain/repositories/playlist_repository.dart';
import '../../../../core/di/repository_providers.dart';

part 'my_favorites_controller.freezed.dart';

@freezed
class MyFavoritesState with _$MyFavoritesState {
  const factory MyFavoritesState({
    @Default([]) List<Track> favorites,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _MyFavoritesState;
}

class MyFavoritesNotifier extends Notifier<MyFavoritesState> {
  late final PlaylistRepository _repository;

  @override
  MyFavoritesState build() {
    _repository = ref.watch(playlistRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const MyFavoritesState();
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final tracks = await _repository.getFavoriteTracks();
      state = state.copyWith(favorites: tracks, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newTracks = await _repository.getFavoriteTracks();
      state = state.copyWith(
        favorites: [...state.favorites, ...newTracks],
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(favorites: []);
    await loadFavorites();
  }
}

final myFavoritesStateProvider =
    NotifierProvider<MyFavoritesNotifier, MyFavoritesState>(
  MyFavoritesNotifier.new,
);
