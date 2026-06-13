import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';

part 'music_dashboard_controller.freezed.dart';

@freezed
class MusicDashboardState with _$MusicDashboardState {
  const factory MusicDashboardState({
    @Default(false) bool isLoading,
    String? error,
    @Default([]) List<Album> featuredAlbums,
    @Default([]) List<Artist> featuredArtists,
  }) = _MusicDashboardState;
}

class MusicDashboardController
    extends AutoDisposeNotifier<MusicDashboardState> {
  late final ArtistsRepository _artistsRepository;
  late final AlbumsRepository _albumRepository;

  @override
  MusicDashboardState build() {
    _albumRepository = ref.watch(albumsRepositoryProvider);
    _artistsRepository = ref.watch(artistsRepositoryProvider);
    Future.microtask(load);
    return const MusicDashboardState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final (albums, artists) = await (
        _albumRepository.getFeaturedAlbums(),
        _artistsRepository.getFeaturedArtists(),
      ).wait;

      state = state.copyWith(
        isLoading: false,
        featuredAlbums: albums,
        featuredArtists: artists,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Pull-to-refresh: reloads without clearing, so current content stays
  /// visible while fetching and is replaced atomically when data arrives.
  Future<void> refresh() => load();
}

final musicStateProvider =
    NotifierProvider.autoDispose<MusicDashboardController, MusicDashboardState>(
      MusicDashboardController.new,
    );
