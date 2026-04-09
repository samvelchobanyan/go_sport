import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/track.dart';

part 'program.freezed.dart';

@freezed
class Program with _$Program {
  const factory Program({
    required String id,
    required String title,
    required String imageUrl,
    String? description,
    required int episodeCount,
    required bool isLiked,
    required List<Track> episodes,
  }) = _Program;
}
