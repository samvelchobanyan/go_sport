import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';

part 'add_tracks_controller.freezed.dart';

@freezed
class AddTracksState with _$AddTracksState {
  const AddTracksState._();

  const factory AddTracksState({
    @Default([]) List<Track> tracks,
    @Default({}) Set<String> selectedTrackIds,
    @Default('') String query,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
    @Default(1) int currentPage,
  }) = _AddTracksState;

  bool get isSearchMode => query.isNotEmpty;
}

class AddTracksNotifier extends AutoDisposeNotifier<AddTracksState> {
  Timer? _debounce;

  @override
  AddTracksState build() {
    ref.onDispose(() => _debounce?.cancel());
    Future.microtask(() => _loadFavorites());
    return const AddTracksState(isLoading: true);
  }

  Future<void> _loadFavorites() async {
    try {
      final result = await ref
          .read(featuredPlaylistRepositoryProvider)
          .getFavoriteTracks(page: 1);
      state = state.copyWith(
        tracks: result.items,
        isLoading: false,
        hasMore: result.hasMore,
        currentPage: 1,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void search(String query) {
    state = state.copyWith(
      query: query,
      selectedTrackIds: const {},
    );
    _debounce?.cancel();

    if (query.isEmpty) {
      state = state.copyWith(
        tracks: [],
        isLoading: true,
        hasMore: true,
        currentPage: 1,
      );
      _loadFavorites();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () {
      state = state.copyWith(
        tracks: [],
        isLoading: true,
        hasMore: true,
        currentPage: 1,
      );
      _searchTracks(query);
    });
  }

  Future<void> _searchTracks(String query) async {
    try {
      final result = await ref
          .read(searchRepositoryProvider)
          .searchTracks(query: query, page: 1);
      state = state.copyWith(
        tracks: result.items,
        isLoading: false,
        hasMore: result.hasMore,
        currentPage: 1,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);
    final nextPage = state.currentPage + 1;

    try {
      final ({List<Track> items, bool hasMore}) result;
      if (state.isSearchMode) {
        result = await ref
            .read(searchRepositoryProvider)
            .searchTracks(query: state.query, page: nextPage);
      } else {
        result = await ref
            .read(featuredPlaylistRepositoryProvider)
            .getFavoriteTracks(page: nextPage);
      }
      state = state.copyWith(
        tracks: [...state.tracks, ...result.items],
        isLoadingMore: false,
        hasMore: result.hasMore,
        currentPage: nextPage,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void toggleTrack(String trackId) {
    final selected = {...state.selectedTrackIds};
    if (selected.contains(trackId)) {
      selected.remove(trackId);
    } else {
      selected.add(trackId);
    }
    state = state.copyWith(selectedTrackIds: selected);
  }

  List<Track> getSelectedTracks() {
    return state.tracks
        .where((t) => state.selectedTrackIds.contains(t.id))
        .toList();
  }
}

final addTracksControllerProvider =
    AutoDisposeNotifierProvider<AddTracksNotifier, AddTracksState>(
  AddTracksNotifier.new,
);
