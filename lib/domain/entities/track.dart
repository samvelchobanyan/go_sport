import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/artist.dart';

part 'track.freezed.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required String id,
    required String title,
    required List<Artist> artists,
    String? imageUrl,
    String? albumId,
    String? programId,
    required Duration duration,
    required String audioUrl,
    DateTime? releaseDate,
    int? year,
    String? likeId,
  }) = _Track;
}

extension TrackX on Track {
  // Первый артист (для быстрого доступа к объекту)
  Artist? get firstArtist => artists.isNotEmpty ? artists.first : null;
  String get firstArtistName => artists.isNotEmpty ? artists.first.artistName : '';

  // Все артисты через запятую
  String get allArtistsName => artists.map((a) => a.artistName).join(', ');

  // Число артистов
  int get artistCount => artists.length;

  // Форматированное отображение для UI: один или "первый +N"
  String get displayArtistName {
    if (artists.isEmpty) return '';
    if (artists.length == 1) return artists.first.artistName;
    final remaining = artists.length - 1;
    return '${artists.first.artistName} +$remaining';
  }
}
