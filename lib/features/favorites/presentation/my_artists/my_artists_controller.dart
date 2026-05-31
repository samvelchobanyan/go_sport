import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/state/like_registry.dart';

part 'my_artists_controller.freezed.dart';

@freezed
class MyArtistsState with _$MyArtistsState {
  const factory MyArtistsState({
    @Default([]) List<Artist> artists,
  }) = _MyArtistsState;
}

class MyArtistsNotifier extends Notifier<MyArtistsState> {
  @override
  MyArtistsState build() {
    final artists = ref.watch(
      likeRegistryProvider.select((s) => s.likedArtists),
    );
    return MyArtistsState(artists: artists);
  }

  Future<void> refresh() async {
    await ref.read(likeRegistryProvider.notifier).initSession();
  }
}

final myArtistsStateProvider =
    NotifierProvider<MyArtistsNotifier, MyArtistsState>(
  MyArtistsNotifier.new,
);
