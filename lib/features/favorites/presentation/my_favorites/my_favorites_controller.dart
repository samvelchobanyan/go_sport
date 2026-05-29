import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/track.dart';
import '../../../../domain/repositories/featured_playlist_repository.dart';
import '../../../../core/di/repository_providers.dart';
import '../../../../domain/state/like_registry.dart';

part 'my_favorites_controller.freezed.dart';

@freezed
class MyFavoritesState with _$MyFavoritesState {
  const factory MyFavoritesState({
    @Default([]) List<Track> favorites,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    String? error,
  }) = _MyFavoritesState;
}

class MyFavoritesNotifier extends Notifier<MyFavoritesState> {
  late final FeaturedPlaylistRepository _repository;

  @override
  MyFavoritesState build() {
    _repository = ref.watch(featuredPlaylistRepositoryProvider);
    ref.listen(
      likeRegistryProvider.select((s) => s.trackLikes),
      (_, next) {
        if (state.favorites.isEmpty) return;
        final kept = state.favorites.where((t) => next.containsKey(t.id)).toList();
        if (kept.length != state.favorites.length) {
          state = state.copyWith(favorites: kept);
        }
      },
    );
    Future.microtask(() => loadFavorites());
    return const MyFavoritesState();
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getFavoriteTracks(page: 1);
      state = state.copyWith(
        favorites: result.items,
        currentPage: 1,
        hasMore: result.hasMore,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final result = await _repository.getFavoriteTracks(page: nextPage);
      state = state.copyWith(
        favorites: [...state.favorites, ...result.items],
        currentPage: nextPage,
        hasMore: result.hasMore,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(
      favorites: [],
      currentPage: 1,
      hasMore: true,
    );
    await loadFavorites();
  }
}

final myFavoritesStateProvider =
    NotifierProvider<MyFavoritesNotifier, MyFavoritesState>(
  MyFavoritesNotifier.new,
);
