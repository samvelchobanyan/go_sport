import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';

part 'my_artists_controller.freezed.dart';

@freezed
class MyArtistsState with _$MyArtistsState {
  const factory MyArtistsState({
    @Default([]) List<Artist> artists,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
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
    Future.microtask(loadFavorites);
    return const MyArtistsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final artists = await _repository.getFavoriteArtists();

      state = state.copyWith(
        artists: artists,
        isLoading: false,
      );
    } catch (err) {
      state = state.copyWith(isLoading: false, error: err.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final moreArtists = await _repository.getFavoriteArtists();

      state = state.copyWith(
        artists: [...state.artists, ...moreArtists],
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(artists: []);
    await loadFavorites();
  }
}

final myArtistsStateProvider =
    NotifierProvider<MyArtistsNotifier, MyArtistsState>(
  MyArtistsNotifier.new,
);
