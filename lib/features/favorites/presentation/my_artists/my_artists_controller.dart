import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';
import 'package:go_sport/domain/state/like_registry.dart';

part 'my_artists_controller.freezed.dart';

@freezed
class MyArtistsState with _$MyArtistsState {
  const factory MyArtistsState({
    @Default([]) List<Artist> artists,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    String? error,
  }) = _MyArtistsState;
}

extension MyArtistsStateX on MyArtistsState {
  Artist? getArtist(String id) {
    try {
      return artists.firstWhere((e) => e.id == id);
    } catch (err) {
      return null;
    }
  }
}

class MyArtistsNotifier extends Notifier<MyArtistsState> {
  late final ArtistsRepository _repository;

  @override
  MyArtistsState build() {
    _repository = ref.watch(artistsRepositoryProvider);
    ref.listen(
      likeRegistryProvider.select((s) => s.artistLikes),
      (_, next) {
        if (state.artists.isEmpty) return;
        final kept = state.artists.where((a) => next.containsKey(a.id)).toList();
        if (kept.length != state.artists.length) {
          state = state.copyWith(artists: kept);
        }
      },
    );
    Future.microtask(loadFavorites);
    return const MyArtistsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getFavoriteArtists(page: 1);

      state = state.copyWith(
        artists: result.items,
        currentPage: 1,
        hasMore: result.hasMore,
        isLoading: false,
      );
    } catch (err) {
      state = state.copyWith(isLoading: false, error: err.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final result = await _repository.getFavoriteArtists(page: nextPage);

      state = state.copyWith(
        artists: [...state.artists, ...result.items],
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
      artists: [],
      currentPage: 1,
      hasMore: true,
    );
    await loadFavorites();
  }
}

final myArtistsStateProvider =
    NotifierProvider<MyArtistsNotifier, MyArtistsState>(
  MyArtistsNotifier.new,
);
