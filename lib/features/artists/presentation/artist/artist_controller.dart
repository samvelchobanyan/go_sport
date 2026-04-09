import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/repository_providers.dart';
import '../../../../domain/entities/album.dart';

part 'artist_controller.freezed.dart';

@freezed
sealed class ArtistAlbumsState with _$ArtistAlbumsState {
  const factory ArtistAlbumsState.loading() = _ArtistAlbumsLoading;

  const factory ArtistAlbumsState.data({
    required List<Album> albums,
  }) = _ArtistAlbumsData;

  const factory ArtistAlbumsState.error({
    required String message,
  }) = _ArtistAlbumsError;
}

class ArtistController extends AutoDisposeFamilyNotifier<ArtistAlbumsState, String> {
  @override
  ArtistAlbumsState build(String artistId) {
    Future.microtask(() => loadAlbums());
    return const ArtistAlbumsState.loading();
  }

  Future<void> loadAlbums() async {
    state = const ArtistAlbumsState.loading();

    try {
      final albums = await ref.read(artistsRepositoryProvider).getArtistAlbums(arg);
      state = ArtistAlbumsState.data(albums: albums);
    } catch (e) {
      state = ArtistAlbumsState.error(message: e.toString());
    }
  }

  Future<String?> toggleLike(String artistId, [String? likeId]) async {
    return await ref.read(artistsRepositoryProvider).toggleLike(artistId, likeId);
  }
}

final artistControllerProvider = NotifierProvider.autoDispose
    .family<ArtistController, ArtistAlbumsState, String>(
  ArtistController.new,
);
