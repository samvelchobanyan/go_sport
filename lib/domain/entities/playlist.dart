import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist.freezed.dart';

enum PlaylistType { featured, custom }

@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    required String id,
    required String title,
    required String imageUrl,
    required int trackCount,
    @Default(PlaylistType.featured) PlaylistType type,
    @Default(false) bool isLiked,
    String? likeId,
  }) = _Playlist;
}
