import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';

@freezed
class Album with _$Album {
  const factory Album({
    required String id,
    required String title,
    required String imageUrl,
    required String artist,
    String? artistId,
    required int trackCount,
    required String releaseYear,
    String? likeId,
  }) = _Album;
}
