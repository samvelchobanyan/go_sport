import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/state/like_registry.dart';

part 'my_albums_controller.freezed.dart';

@freezed
class MyAlbumsState with _$MyAlbumsState {
  const factory MyAlbumsState({
    @Default([]) List<Album> albums,
  }) = _MyAlbumsState;
}

class MyAlbumsNotifier extends Notifier<MyAlbumsState> {
  @override
  MyAlbumsState build() {
    final albums = ref.watch(
      likeRegistryProvider.select((s) => s.likedAlbums),
    );
    return MyAlbumsState(albums: albums);
  }

  Future<void> refresh() async {
    await ref.read(likeRegistryProvider.notifier).initSession();
  }
}

final myAlbumsStateProvider =
    NotifierProvider<MyAlbumsNotifier, MyAlbumsState>(
  MyAlbumsNotifier.new,
);
