import 'package:freezed_annotation/freezed_annotation.dart';

part 'song.freezed.dart';

@freezed
class Song with _$Song {
  const factory Song({
    required String id,
    required String title,
    String? artist,
    String? albumName,
    String? imageUrl,
    required bool liked,
    Duration? duration,
  }) = _Song;
}
