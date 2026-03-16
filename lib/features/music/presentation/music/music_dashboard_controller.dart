import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/repositories/artists_repository.dart';
import 'package:go_sport/domain/repositories/music_repository.dart';

part 'music_dashboard_controller.freezed.dart';

@freezed
class MusicDashboardState with _$MusicDashboardState {
  const factory MusicDashboardState({
    @Default(false) bool isLoading,
    String? error,
    @Default(0) int favoritesCount,
    @Default(0) int playlistsCount,
    @Default(0) int albumsCount,
    @Default(0) int artistsCount,
    @Default(0) int episodesCount,
    @Default(0) int programsCount,
    @Default([]) List<Album> featuredAlbums,
    @Default([]) List<Artist> featuredArtists,
  }) = _MusicDashboardState;
}

class MusicDashboardController
    extends AutoDisposeNotifier<MusicDashboardState> {
  late final MusicRepository _repository;
  late final ArtistsRepository _artistsRepository;

  @override
  MusicDashboardState build() {
    _repository = ref.watch(musicRepositoryProvider);
    _artistsRepository = ref.watch(artistsRepositoryProvider);
    Future.microtask(() => load());
    return const MusicDashboardState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final (
        favorites,
        playlists,
        albumsCount,
        artistsCount,
        episodes,
        programs,
        albums,
        artists,
      ) = await (
        _repository.getFavoritesCount(),
        _repository.getPlaylistsCount(),
        _repository.getAlbumsCount(),
        _repository.getArtistsCount(),
        _repository.getEpisodesCount(),
        _repository.getProgramsCount(),
        _repository.getFeaturedAlbums(),
        _artistsRepository.getFeaturedArtists(),
      ).wait;

      state = state.copyWith(
        isLoading: false,
        favoritesCount: favorites,
        playlistsCount: playlists,
        albumsCount: albumsCount,
        artistsCount: artistsCount,
        episodesCount: episodes,
        programsCount: programs,
        featuredAlbums: albums,
        featuredArtists: artists,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async => await load();
}

final musicStateProvider =
    NotifierProvider.autoDispose<MusicDashboardController, MusicDashboardState>(
      MusicDashboardController.new,
    );