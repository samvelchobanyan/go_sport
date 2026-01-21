import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist.freezed.dart';

@freezed
class Artist with _$Artist {
  const factory Artist({
    required String id,
    required String title,
    String? albumName,
    required String imageUrl,
    required bool liked,
  }) = _Artist;
}
