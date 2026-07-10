import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.freezed.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required String id,
    required String title,
    required String artistName,
    String? artistId,
    String? imageUrl,
    String? albumId,
    String? programId,
    required Duration duration,
    required String audioUrl,
    DateTime? releaseDate,
    String? likeId,
  }) = _Track;
}
