import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/artist.dart';
import '../../../domain/repositories/artist_repository.dart';
import '../../../core/di/repository_providers.dart';

part 'featured_artists_state.freezed.dart';

@freezed
class FeaturedArtistsState with _$FeaturedArtistsState {
  const factory FeaturedArtistsState({
    @Default({}) Map<String, Artist> artists,
    @Default(false) bool isLoading,
    String? error,
  }) = _FeaturedArtistsState;
}

extension FeaturedArtistsStateX on FeaturedArtistsState {
  List<Artist> get artistsList => artists.values.toList();

  Artist? getArtist(String id) => artists[id];
}

class FeaturedArtistsNotifier
    extends AutoDisposeNotifier<FeaturedArtistsState> {
  late final ArtistRepository _repository;

  @override
  FeaturedArtistsState build() {
    _repository = ref.watch(artistRepositoryProvider);
    Future.microtask(() => loadArtists());
    return const FeaturedArtistsState();
  }

  Future<void> loadArtists() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final artists = await _repository.getFeaturedArtists();
      final artistsMap = {for (final a in artists) a.id: a};
      state = state.copyWith(artists: artistsMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void toggleLike(String artistId) {
    final artist = state.artists[artistId];
    if (artist == null) return;

    final updated = artist.copyWith(isLiked: !artist.isLiked);
    state = state.copyWith(artists: {...state.artists, artistId: updated});
  }
}

final featuredArtistsStateProvider =
    NotifierProvider.autoDispose<FeaturedArtistsNotifier, FeaturedArtistsState>(
      FeaturedArtistsNotifier.new,
    );
