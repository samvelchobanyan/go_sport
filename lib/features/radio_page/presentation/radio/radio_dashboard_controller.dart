import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

part 'radio_dashboard_controller.freezed.dart';

@freezed
class RadioDashboardState with _$RadioDashboardState {
  const factory RadioDashboardState({
    @Default(false) bool isLoading,
    String? error,
    // @Default(0) int favoritesCount,
    // @Default(0) int playlistsCount,
    // @Default(0) int albumsCount,
    // @Default(0) int artistsCount,
    // @Default(0) int episodesCount,
    // @Default(0) int programsCount,
    @Default([]) List<Program> featuredPrograms,
    @Default([]) List<Track> featuredEpisodes,
    // @Default([]) List<Artist> featuredArtists,
  }) = _RadioDashboardState;
}

class RadioDashboardController
    extends AutoDisposeNotifier<RadioDashboardState> {
  // late final MusicRepository _repository;
  // late final ArtistsRepository _artistsRepository;
  late final EpisodesRepository _episodesRepository;
  late final ProgramsRepository _programsRepository;

  @override
  RadioDashboardState build() {
    // _repository = ref.watch(musicRepositoryProvider);
    // _albumRepository = ref.watch(albumsRepositoryProvider);
    _episodesRepository = ref.watch(episodesRepositoryProvider);
    _programsRepository = ref.watch(programsRepositoryProvider);
    Future.microtask(() => load());
    return const RadioDashboardState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final (
        // favorites,
        // playlists,
        // albumsCount,
        // artistsCount,
        // episodes,
        featuredPrograms,
        featuredEpisodes,
        // albums,
        // artists,
      ) = await (
        // _repository.getFavoritesCount(),
        // _repository.getPlaylistsCount(),
        // _repository.getAlbumsCount(),
        // _repository.getArtistsCount(),
        // _repository.getEpisodesCount(),
        // _repository.getProgramsCount(),
        // _albumRepository.getFeaturedAlbums(),
        // _artistsRepository.getFeaturedArtists(),
        _programsRepository.getFeaturedPrograms(),
        _episodesRepository.getFeaturedEpisodes(),
      ).wait;

      state = state.copyWith(
        // isLoading: false,
        // favoritesCount: favorites,
        // playlistsCount: playlists,
        // albumsCount: albumsCount,
        // artistsCount: artistsCount,
        // episodesCount: episodes,
        // programsCount: programs,
        // featuredAlbums: albums,
        // featuredArtists: artists,
        featuredPrograms: featuredPrograms,
        featuredEpisodes: featuredEpisodes,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final radioStateProvider =
    NotifierProvider.autoDispose<RadioDashboardController, RadioDashboardState>(
      RadioDashboardController.new,
    );
