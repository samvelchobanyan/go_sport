import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/track.dart';
import '../../../../domain/state/like_registry.dart';

part 'my_favorites_controller.freezed.dart';

@freezed
class MyFavoritesState with _$MyFavoritesState {
  const factory MyFavoritesState({
    @Default([]) List<Track> favorites,
  }) = _MyFavoritesState;
}

class MyFavoritesNotifier extends Notifier<MyFavoritesState> {
  @override
  MyFavoritesState build() {
    final favorites = ref.watch(
      likeRegistryProvider.select((s) => s.likedTracks),
    );
    return MyFavoritesState(favorites: favorites);
  }

  Future<void> refresh() async {
    await ref.read(likeRegistryProvider.notifier).initSession();
  }
}

final myFavoritesStateProvider =
    NotifierProvider<MyFavoritesNotifier, MyFavoritesState>(
  MyFavoritesNotifier.new,
);
