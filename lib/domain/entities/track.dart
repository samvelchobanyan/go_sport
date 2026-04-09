import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.freezed.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required String id,
    required String title,
    required String artistName,
    String? imageUrl,
    required Duration duration,
    required String audioUrl,
    DateTime? releaseDate,
    @Default(false) bool isLiked,
    String? likeId,
  }) = _Track;
}
