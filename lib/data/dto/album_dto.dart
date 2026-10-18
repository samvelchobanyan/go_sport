import 'package:go_sport/domain/entities/album.dart';

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

class _ArtistDto {
  final String documentId;
  final String name;

  _ArtistDto({required this.documentId, required this.name});

  factory _ArtistDto.fromJson(Map<String, dynamic> json) {
    return _ArtistDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
    );
  }
}

class AlbumDto {
  final String documentId;
  final String name;
  final String artist;
  final String? artistId;
  final String coverUrl;
  final String? coverThumbnailUrl;
  final int cnt;
  final int year;
  final String? likeId;

  AlbumDto({
    required this.documentId,
    required this.name,
    required this.artist,
    required this.artistId,
    required this.coverUrl,
    this.coverThumbnailUrl,
    required this.cnt,
    required this.year,
    this.likeId,
  });

  factory AlbumDto.fromJson(Map<String, dynamic> json) {
    final artistJson = json['Artist'] as Map<String, dynamic>?;
    final artist = artistJson != null ? _ArtistDto.fromJson(artistJson) : null;
    final coverJson = json['Cover'] as Map<String, dynamic>?;
    final likeJson = json['Like'] as Map<String, dynamic>?;

    return AlbumDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      artist: artist?.name ?? '',
      artistId: artist?.documentId,
      coverUrl: coverJson != null ? _CoverDto.fromJson(coverJson).url : '',
      coverThumbnailUrl: coverJson != null
          ? _CoverDto.fromJson(coverJson).thumbnailUrl
          : null,
      cnt: json['cnt'] as int? ?? 0,
      year: json['Year'] as int? ?? 0,
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Album toDomain() {
    return Album(
      id: documentId,
      title: name,
      artist: artist,
      artistId: artistId,
      imageUrl: coverUrl,
      thumbnailUrl: coverThumbnailUrl,
      trackCount: cnt,
      releaseYear: year.toString(),
      likeId: likeId,
    );
  }
}