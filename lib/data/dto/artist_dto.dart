import 'package:go_sport/domain/entities/artist.dart';

class _CoverDto {
  final String url;

  _CoverDto({required this.url});

  factory _CoverDto.fromJson(Map<String, dynamic> json) {
    return _CoverDto(url: json['url'] as String);
  }
}

class ArtistDto {
  final String documentId;
  final String name;
  final String coverUrl;

  ArtistDto({
    required this.documentId,
    required this.name,
    required this.coverUrl,
  });

  factory ArtistDto.fromJson(Map<String, dynamic> json) {
    final coverJson = json['Cover'] as Map<String, dynamic>?;

    return ArtistDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      coverUrl: coverJson != null
          ? _CoverDto.fromJson(coverJson).url
          : '',
    );
  }

  Artist toDomain() {
    return Artist(
      id: documentId,
      artistName: name,
      imageUrl: coverUrl,
    );
  }
}