import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/album.dart';

part 'artist.freezed.dart';

@freezed
class Artist with _$Artist {
  const factory Artist({
    required String id,
    required String artistName,
    required String imageUrl,
    @Default(false) bool isLiked,
    String? likeId,
  }) = _Artist;
}
