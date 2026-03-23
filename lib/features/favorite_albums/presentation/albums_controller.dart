import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';

part 'albums_controller.freezed.dart';

@freezed
class AlbumsState with _$AlbumsState {
  const factory AlbumsState({
    @Default([]) List<Album> albums,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _AlbumsState;
}

extension AlbumsStateX on AlbumsState {
  Album? getAlbum(String id) {
    try {
      return albums.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}

class AlbumsNotifier extends Notifier<AlbumsState> {
  late final AlbumsRepository _repository;

  @override
  AlbumsState build() {
    _repository = ref.watch(albumsRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const AlbumsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final albums = await _repository.getFavoriteAlbums();

      state = state.copyWith(
        albums: albums,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Optimistic like toggle
  Future<void> toggleLike(String id) async {
    final index = state.albums.indexWhere((a) => a.id == id);
    if (index == -1) return;

    final album = state.albums[index];
    final updated = album.copyWith(isLiked: !album.isLiked);

    // Optimistic update
    final updatedList = [...state.albums];
    updatedList[index] = updated;

    state = state.copyWith(albums: updatedList);

    try {
      await _repository.toggleLike(id);
    } catch (e) {
      // rollback
      final rollbackList = [...state.albums];
      rollbackList[index] = album;

      state = state.copyWith(
        albums: rollbackList,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(albums: []);
    await loadFavorites();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newAlbums = await _repository.getFavoriteAlbums();

      // Avoid duplicates (optional but recommended)
      final existingIds = state.albums.map((a) => a.id).toSet();

      final merged = [
        ...state.albums,
        ...newAlbums.where((a) => !existingIds.contains(a.id)),
      ];

      state = state.copyWith(
        albums: merged,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }
}

final albumsStateProvider =
    NotifierProvider<AlbumsNotifier, AlbumsState>(
  AlbumsNotifier.new,
);