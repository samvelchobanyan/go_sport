import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';

@freezed
class Album with _$Album {
  const factory Album({
    required String id,
    required String title,
    required String imageUrl,
    required String artist,
    required int trackCount,
    required String releaseYear,
    @Default(false) bool isLiked,
    String? likeId,
  }) = _Album;
}
