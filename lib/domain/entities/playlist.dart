import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist.freezed.dart';

@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    required String id,
    required String title,
    required String imageUrl,
    required int trackCount,
    @Default(false) bool isLiked,
  }) = _Playlist;
}
