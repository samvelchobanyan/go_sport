import 'package:go_sport/domain/entities/artist.dart';

class _CoverDto {
  final String url;
  final String thumbnailUrl;

  _CoverDto({required this.url, required this.thumbnailUrl});

  factory _CoverDto.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final formats = json['formats'] as Map<String, dynamic>?;
    final small = formats?['small'] as Map<String, dynamic>?;
    final thumbnail = formats?['thumbnail'] as Map<String, dynamic>?;
    return _CoverDto(
      url: url,
      thumbnailUrl:
          small?['url'] as String? ?? thumbnail?['url'] as String? ?? url,
    );
  }
}

class ArtistDto {
  final String documentId;
  final String name;
  final String coverUrl;
  final String? coverThumbnailUrl;
  final String? likeId;

  ArtistDto({
    required this.documentId,
    required this.name,
    required this.coverUrl,
    this.coverThumbnailUrl,
    this.likeId,
  });

  factory ArtistDto.fromJson(Map<String, dynamic> json) {
    final coverJson = json['Cover'] as Map<String, dynamic>?;
    final likeJson = json['Like'] as Map<String, dynamic>?;

    return ArtistDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      coverUrl: coverJson != null ? _CoverDto.fromJson(coverJson).url : '',
      coverThumbnailUrl: coverJson != null
          ? _CoverDto.fromJson(coverJson).thumbnailUrl
          : null,
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Artist toDomain() {
    return Artist(
      id: documentId,
      artistName: name,
      imageUrl: coverUrl,
      thumbnailUrl: coverThumbnailUrl,
      likeId: likeId,
    );
  }
}