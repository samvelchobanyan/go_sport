import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';

@freezed
class Episode with _$Episode {
  const factory Episode({
    required String id,
    required String title,
    String? subtitle,
    String? imageUrl,
    String? description,
    int? duration,
    DateTime? releaseDate,
  }) = _Episode;
}
