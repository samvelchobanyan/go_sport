import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';

part 'search_controller.freezed.dart';

enum SearchCategory { all, tracks, albums, artists, programs }

@freezed
class SearchState with _$SearchState {
  const SearchState._();

  const factory SearchState({
    @Default('') String query,
    @Default(SearchCategory.all) SearchCategory category,
    @Default([]) List<Track> tracks,
    @Default([]) List<Album> albums,
    @Default([]) List<Artist> artists,
    @Default([]) List<Program> programs,
    @Default([]) List<Playlist> playlists,
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _SearchState;

  bool get hasResults =>
      tracks.isNotEmpty ||
      albums.isNotEmpty ||
      artists.isNotEmpty ||
      programs.isNotEmpty ||
      playlists.isNotEmpty;
}

class SearchNotifier extends AutoDisposeNotifier<SearchState> {
  static const _debounceDuration = Duration(milliseconds: 400);
  static const _allPreviewPageSize = 3;
  static const _categoryPageSize = 25;

  Timer? _debounce;
  int _requestId = 0;

  @override
  SearchState build() {
    ref.onDispose(() => _debounce?.cancel());
    return const SearchState();
  }

  void onQueryChanged(String query) {
    _debounce?.cancel();

    if (query.isEmpty) {
      state = const SearchState();
      return;
    }

    state = state.copyWith(query: query);
    _debounce = Timer(_debounceDuration, _runSearch);
  }

  void setCategory(SearchCategory category) {
    if (category == state.category) return;

    state = state.copyWith(
      category: category,
      currentPage: 1,
      hasMore: false,
      error: null,
    );

    if (state.query.isEmpty) return;
    _runSearch();
  }

  Future<void> _runSearch() async {
    final reqId = ++_requestId;
    final query = state.query;
    final category = state.category;

    state = state.copyWith(isLoading: true, error: null);

    final repo = ref.read(searchRepositoryProvider);

    try {
      if (category == SearchCategory.all) {
        final results = await (
          _safe(() => repo.searchTracks(
                query: query,
                pageSize: _allPreviewPageSize,
              )),
          _safe(() => repo.searchAlbums(
                query: query,
                pageSize: _allPreviewPageSize,
              )),
          _safe(() => repo.searchArtists(
                query: query,
                pageSize: _allPreviewPageSize,
              )),
          _safe(() => repo.searchPrograms(
                query: query,
                pageSize: _allPreviewPageSize,
              )),
          _safe(() => repo.searchPlaylists(
                query: query,
                pageSize: _allPreviewPageSize,
              )),
        ).wait;

        if (reqId != _requestId) return;

        state = state.copyWith(
          tracks: results.$1,
          albums: results.$2,
          artists: results.$3,
          programs: results.$4,
          playlists: results.$5,
          currentPage: 1,
          hasMore: false,
          isLoading: false,
        );
      } else {
        switch (category) {
          case SearchCategory.tracks:
            final r = await repo.searchTracks(
              query: query,
              page: 1,
              pageSize: _categoryPageSize,
            );
            if (reqId != _requestId) return;
            state = state.copyWith(
              tracks: r.items,
              currentPage: 1,
              hasMore: r.hasMore,
              isLoading: false,
            );
          case SearchCategory.albums:
            final r = await repo.searchAlbums(
              query: query,
              page: 1,
              pageSize: _categoryPageSize,
            );
            if (reqId != _requestId) return;
            state = state.copyWith(
              albums: r.items,
              currentPage: 1,
              hasMore: r.hasMore,
              isLoading: false,
            );
          case SearchCategory.artists:
            final r = await repo.searchArtists(
              query: query,
              page: 1,
              pageSize: _categoryPageSize,
            );
            if (reqId != _requestId) return;
            state = state.copyWith(
              artists: r.items,
              currentPage: 1,
              hasMore: r.hasMore,
              isLoading: false,
            );
          case SearchCategory.programs:
            final r = await repo.searchPrograms(
              query: query,
              page: 1,
              pageSize: _categoryPageSize,
            );
            if (reqId != _requestId) return;
            state = state.copyWith(
              programs: r.items,
              currentPage: 1,
              hasMore: r.hasMore,
              isLoading: false,
            );
          case SearchCategory.all:
            break;
        }
      }
    } catch (e) {
      if (reqId != _requestId) return;
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.category == SearchCategory.all) return;
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    final reqId = ++_requestId;
    final nextPage = state.currentPage + 1;
    final query = state.query;

    state = state.copyWith(isLoadingMore: true);

    final repo = ref.read(searchRepositoryProvider);

    try {
      switch (state.category) {
        case SearchCategory.tracks:
          final r = await repo.searchTracks(
            query: query,
            page: nextPage,
            pageSize: _categoryPageSize,
          );
          if (reqId != _requestId) return;
          state = state.copyWith(
            tracks: [...state.tracks, ...r.items],
            currentPage: nextPage,
            hasMore: r.hasMore,
            isLoadingMore: false,
          );
        case SearchCategory.albums:
          final r = await repo.searchAlbums(
            query: query,
            page: nextPage,
            pageSize: _categoryPageSize,
          );
          if (reqId != _requestId) return;
          state = state.copyWith(
            albums: [...state.albums, ...r.items],
            currentPage: nextPage,
            hasMore: r.hasMore,
            isLoadingMore: false,
          );
        case SearchCategory.artists:
          final r = await repo.searchArtists(
            query: query,
            page: nextPage,
            pageSize: _categoryPageSize,
          );
          if (reqId != _requestId) return;
          state = state.copyWith(
            artists: [...state.artists, ...r.items],
            currentPage: nextPage,
            hasMore: r.hasMore,
            isLoadingMore: false,
          );
        case SearchCategory.programs:
          final r = await repo.searchPrograms(
            query: query,
            page: nextPage,
            pageSize: _categoryPageSize,
          );
          if (reqId != _requestId) return;
          state = state.copyWith(
            programs: [...state.programs, ...r.items],
            currentPage: nextPage,
            hasMore: r.hasMore,
            isLoadingMore: false,
          );
        case SearchCategory.all:
          break;
      }
    } catch (_) {
      if (reqId != _requestId) return;
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<List<T>> _safe<T>(
    Future<({List<T> items, bool hasMore})> Function() fetch,
  ) async {
    try {
      final r = await fetch();
      return r.items;
    } catch (_) {
      return <T>[];
    }
  }
}

final searchControllerProvider =
    AutoDisposeNotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
