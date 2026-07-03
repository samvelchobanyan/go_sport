import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/repository_providers.dart';
import '../../../../domain/entities/album.dart';
import '../../../../domain/entities/artist.dart';

part 'artist_controller.freezed.dart';

@freezed
sealed class ArtistDetailsState with _$ArtistDetailsState {
  const factory ArtistDetailsState.loading() = _ArtistDetailsLoading;

  const factory ArtistDetailsState.data({
    required Artist artist,
    required List<Album> albums,
  }) = _ArtistDetailsData;

  const factory ArtistDetailsState.error({
    required String message,
  }) = _ArtistDetailsError;
}

class ArtistController
    extends AutoDisposeFamilyNotifier<ArtistDetailsState, String> {
  @override
  ArtistDetailsState build(String artistId) {
    Future.microtask(() => loadDetails());
    return const ArtistDetailsState.loading();
  }

  Future<void> loadDetails() async {
    state = const ArtistDetailsState.loading();

    try {
      final details =
          await ref.read(artistsRepositoryProvider).getArtistDetails(arg);
      state = ArtistDetailsState.data(
        artist: details.artist,
        albums: details.albums,
      );
    } catch (e) {
      state = ArtistDetailsState.error(message: e.toString());
    }
  }
}

final artistControllerProvider = NotifierProvider.autoDispose
    .family<ArtistController, ArtistDetailsState, String>(
  ArtistController.new,
);
