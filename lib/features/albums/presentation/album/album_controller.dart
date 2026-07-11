import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/repository_providers.dart';
import '../../../../domain/entities/album.dart';
import '../../../../domain/entities/track.dart';

part 'album_controller.freezed.dart';

@freezed
sealed class AlbumTracksState with _$AlbumTracksState {
  const factory AlbumTracksState.loading() = _AlbumTracksLoading;

  const factory AlbumTracksState.data({
    required Album album,
    required List<Track> tracks,
  }) = _AlbumTracksData;

  const factory AlbumTracksState.error({
    required String message,
  }) = _AlbumTracksError;
}

class AlbumController extends AutoDisposeFamilyNotifier<AlbumTracksState, String> {
  @override
  AlbumTracksState build(String albumId) {
    Future.microtask(() => loadTracks());
    return const AlbumTracksState.loading();
  }

  Future<void> loadTracks() async {
    state = const AlbumTracksState.loading();

    try {
      final details =
          await ref.read(albumsRepositoryProvider).getAlbumDetails(arg);
      state = AlbumTracksState.data(
        album: details.album,
        tracks: details.tracks,
      );
    } catch (e) {
      state = AlbumTracksState.error(message: e.toString());
    }
  }
}

final albumControllerProvider = NotifierProvider.autoDispose
    .family<AlbumController, AlbumTracksState, String>(
  AlbumController.new,
);
