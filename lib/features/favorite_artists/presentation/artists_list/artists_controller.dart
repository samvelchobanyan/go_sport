import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';

part 'artists_controller.freezed.dart';

@freezed
class ArtistsState with _$ArtistsState {
  const factory ArtistsState({
    @Default([]) List<Artist> favoriteArtists,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _ArtistsState;
}

extension ArtistsStateX on ArtistsState {
  List<Artist> get artistsList => favoriteArtists;

  Artist? getArtist(String id) {
    try {
      return favoriteArtists.firstWhere((e) => e.id == id);
    } catch (err) {
      return null;
    }
  }
}

class ArtistsNotifier extends Notifier<ArtistsState> {
  late final ArtistsRepository _repository;

  @override
  ArtistsState build() {
    _repository = ref.watch(artistsRepositoryProvider);
    Future.microtask(loadFavorites);
    return ArtistsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final favoriteArtists = await _repository.getFavoriteArtists();

      state = state.copyWith(
        favoriteArtists: favoriteArtists,
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
        favoriteArtists: [...state.favoriteArtists, ...moreArtists],
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(favoriteArtists: []);
    await loadFavorites();
  }
}

final artistsStateProvider = NotifierProvider<ArtistsNotifier, ArtistsState>(
  ArtistsNotifier.new,
);
