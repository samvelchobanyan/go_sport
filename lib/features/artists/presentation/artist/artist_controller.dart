import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/repository_providers.dart';
import '../../../../domain/entities/album.dart';
import '../../../../domain/entities/artist.dart';
import '../../../../domain/entities/track.dart';

part 'artist_controller.freezed.dart';

enum ArtistTab { tracks, albums, singles }

/// One tab's list: loaded items + pagination cursor.
@freezed
class PagedList<T> with _$PagedList<T> {
  const factory PagedList({
    @Default([]) List<T> items,
    @Default(1) int page,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _PagedList<T>;
}

@freezed
class ArtistState with _$ArtistState {
  const factory ArtistState({
    /// Loaded on demand for id-only opens (player); list/search opens render
    /// the hero from the navigation hint instead.
    Artist? artist,
    @Default(ArtistTab.tracks) ArtistTab selectedTab,
    @Default(PagedList<Track>()) PagedList<Track> tracks,
    @Default(PagedList<Album>()) PagedList<Album> albums,

    /// Album-less tracks, rendered as one-track pseudo-albums by the screen.
    @Default(PagedList<Track>()) PagedList<Track> singles,
    @Default(true) bool isLoading,
    String? error,
  }) = _ArtistState;
}

class ArtistController extends AutoDisposeFamilyNotifier<ArtistState, String> {
  /// Guards against a stale response landing after a retry.
  int _requestId = 0;

  @override
  ArtistState build(String artistId) {
    Future.microtask(loadAll);
    return const ArtistState();
  }

  /// First page of all three tabs at once: the responses double as the
  /// "does this artist have albums/singles?" check that drives chip
  /// visibility, and tab switching never needs a network call.
  Future<void> loadAll() async {
    final reqId = ++_requestId;
    state = state.copyWith(isLoading: true, error: null);

    final repo = ref.read(artistsRepositoryProvider);
    try {
      final (tracks, albums, singles) = await (
        repo.getArtistTracks(arg),
        repo.getArtistAlbums(arg),
        repo.getArtistSingles(arg),
      ).wait;

      if (reqId != _requestId) return;
      state = state.copyWith(
        tracks: PagedList(items: tracks.items, hasMore: tracks.hasMore),
        albums: PagedList(items: albums.items, hasMore: albums.hasMore),
        singles: PagedList(items: singles.items, hasMore: singles.hasMore),
        isLoading: false,
      );
    } catch (e) {
      if (reqId != _requestId) return;
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Hero data for id-only opens. The screen calls this when it has no
  /// artist hint. Failure is silent — the hero keeps its plain backdrop and
  /// the screen-level retry re-triggers this together with [loadAll].
  Future<void> loadArtist() async {
    try {
      final artist = await ref.read(artistsRepositoryProvider).getArtist(arg);
      state = state.copyWith(artist: artist);
    } catch (_) {}
  }

  void selectTab(ArtistTab tab) {
    if (tab == state.selectedTab) return;
    state = state.copyWith(selectedTab: tab);
  }

  /// Next page for the active tab only.
  Future<void> loadMore() async {
    if (state.isLoading) return;

    final tab = state.selectedTab;
    final current = switch (tab) {
      ArtistTab.tracks => state.tracks,
      ArtistTab.albums => state.albums,
      ArtistTab.singles => state.singles,
    };
    if (!current.hasMore || current.isLoadingMore) return;

    final reqId = ++_requestId;
    final nextPage = current.page + 1;
    final repo = ref.read(artistsRepositoryProvider);

    switch (tab) {
      case ArtistTab.tracks:
        state = state.copyWith(
          tracks: state.tracks.copyWith(isLoadingMore: true),
        );
        try {
          final r = await repo.getArtistTracks(arg, page: nextPage);
          if (reqId != _requestId) return;
          state = state.copyWith(
            tracks: PagedList(
              items: [...state.tracks.items, ...r.items],
              page: nextPage,
              hasMore: r.hasMore,
            ),
          );
        } catch (_) {
          if (reqId != _requestId) return;
          state = state.copyWith(
            tracks: state.tracks.copyWith(isLoadingMore: false),
          );
        }
      case ArtistTab.albums:
        state = state.copyWith(
          albums: state.albums.copyWith(isLoadingMore: true),
        );
        try {
          final r = await repo.getArtistAlbums(arg, page: nextPage);
          if (reqId != _requestId) return;
          state = state.copyWith(
            albums: PagedList(
              items: [...state.albums.items, ...r.items],
              page: nextPage,
              hasMore: r.hasMore,
            ),
          );
        } catch (_) {
          if (reqId != _requestId) return;
          state = state.copyWith(
            albums: state.albums.copyWith(isLoadingMore: false),
          );
        }
      case ArtistTab.singles:
        state = state.copyWith(
          singles: state.singles.copyWith(isLoadingMore: true),
        );
        try {
          final r = await repo.getArtistSingles(arg, page: nextPage);
          if (reqId != _requestId) return;
          state = state.copyWith(
            singles: PagedList(
              items: [...state.singles.items, ...r.items],
              page: nextPage,
              hasMore: r.hasMore,
            ),
          );
        } catch (_) {
          if (reqId != _requestId) return;
          state = state.copyWith(
            singles: state.singles.copyWith(isLoadingMore: false),
          );
        }
    }
  }
}

final artistControllerProvider = NotifierProvider.autoDispose
    .family<ArtistController, ArtistState, String>(
  ArtistController.new,
);
