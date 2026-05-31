import 'package:go_sport/domain/entities/album.dart';

class _CoverDto {
  final String url;

  _CoverDto({required this.url});

  factory _CoverDto.fromJson(Map<String, dynamic> json) {
    return _CoverDto(url: json['url'] as String);
  }
}

class _ArtistDto {
  final String name;

  _ArtistDto({required this.name});

  factory _ArtistDto.fromJson(Map<String, dynamic> json) {
    return _ArtistDto(name: json['Name'] as String);
  }
}

class AlbumDto {
  final String documentId;
  final String name;
  final String artist;
  final String coverUrl;
  final int cnt;
  final int year;
  final String? likeId;

  AlbumDto({
    required this.documentId,
    required this.name,
    required this.artist,
    required this.coverUrl,
    required this.cnt,
    required this.year,
    this.likeId,
  });

  factory AlbumDto.fromJson(Map<String, dynamic> json) {
    final artistJson = json['Artist'] as Map<String, dynamic>?;
    final coverJson = json['Cover'] as Map<String, dynamic>?;
    final likeJson = json['Like'] as Map<String, dynamic>?;

    return AlbumDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      artist: artistJson != null ? _ArtistDto.fromJson(artistJson).name : '',
      coverUrl: coverJson != null ? _CoverDto.fromJson(coverJson).url : '',
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
      imageUrl: coverUrl,
      trackCount: cnt,
      releaseYear: year.toString(),
      likeId: likeId,
    );
  }
}