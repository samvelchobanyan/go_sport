import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/repositories/albums_repository.dart';

part 'my_albums_controller.freezed.dart';

@freezed
class MyAlbumsState with _$MyAlbumsState {
  const factory MyAlbumsState({
    @Default([]) List<Album> albums,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    String? error,
  }) = _MyAlbumsState;
}

extension MyAlbumsStateX on MyAlbumsState {
  Album? getAlbum(String id) {
    try {
      return albums.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}

class MyAlbumsNotifier extends Notifier<MyAlbumsState> {
  late final AlbumsRepository _repository;

  @override
  MyAlbumsState build() {
    _repository = ref.watch(albumsRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const MyAlbumsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getFavoriteAlbums(page: 1);

      state = state.copyWith(
        albums: result.items,
        currentPage: 1,
        hasMore: result.hasMore,
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
  // Future<void> toggleLike(String id) async {
  //   final index = state.albums.indexWhere((a) => a.id == id);
  //   if (index == -1) return;

  //   final album = state.albums[index];
  //   final updated = album.copyWith(isLiked: !album.isLiked);

  //   // Optimistic update
  //   final updatedList = [...state.albums];
  //   updatedList[index] = updated;

  //   state = state.copyWith(albums: updatedList);

  //   try {
  //     await _repository.toggleLike(id);
  //   } catch (e) {
  //     // rollback
  //     final rollbackList = [...state.albums];
  //     rollbackList[index] = album;

  //     state = state.copyWith(
  //       albums: rollbackList,
  //       error: e.toString(),
  //     );
  //   }
  // }

  Future<void> refresh() async {
    state = state.copyWith(
      albums: [],
      currentPage: 1,
      hasMore: true,
    );
    await loadFavorites();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final result = await _repository.getFavoriteAlbums(page: nextPage);

      state = state.copyWith(
        albums: [...state.albums, ...result.items],
        currentPage: nextPage,
        hasMore: result.hasMore,
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

final myAlbumsStateProvider =
    NotifierProvider<MyAlbumsNotifier, MyAlbumsState>(
  MyAlbumsNotifier.new,
);
