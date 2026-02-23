import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/album.dart';
import '../repositories/album_repository.dart';
import '../../core/di/repository_providers.dart';

part 'albums_state.freezed.dart';

@freezed
class AlbumsState with _$AlbumsState {
  const factory AlbumsState({
    @Default({}) Map<String, Album> albums,
    @Default(false) bool isLoading,
    String? error,
  }) = _AlbumsState;
}

extension AlbumsStateX on AlbumsState {
  List<Album> get albumsList => albums.values.toList();

  Album? getAlbum(String id) => albums[id];
}

class AlbumsNotifier extends AutoDisposeNotifier<AlbumsState> {
  late final AlbumRepository _repository;

  @override
  AlbumsState build() {
    _repository = ref.watch(albumRepositoryProvider);
    Future.microtask(() => loadAlbums());
    return const AlbumsState();
  }

  Future<void> loadAlbums() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final albums = await _repository.getAlbums();
      final albumsMap = {for (final a in albums) a.id: a};
      state = state.copyWith(albums: albumsMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> toggleLike(String albumId) async {
    try {
      await _repository.toggleLike(albumId);
      final album = state.albums[albumId];
      if (album != null) {
        final updatedAlbum = album.copyWith(isLiked: !album.isLiked);
        state = state.copyWith(
          albums: {...state.albums, albumId: updatedAlbum},
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final albumsStateProvider =
    NotifierProvider.autoDispose<AlbumsNotifier, AlbumsState>(
      AlbumsNotifier.new,
    );
