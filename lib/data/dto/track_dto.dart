import 'dart:developer';

import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/entities/artist.dart';

class _FileDto {
  final String url;

  _FileDto({required this.url});

  factory _FileDto.fromJson(Map<String, dynamic> json) {
    return _FileDto(url: json['url'] as String);
  }
}

class _ArtistDto {
  final String documentId;
  final String name;
  final String? imageUrl;
  final String? thumbnailUrl;
  final String? likeId;

  _ArtistDto({
    required this.documentId,
    required this.name,
    this.imageUrl,
    this.thumbnailUrl,
    this.likeId,
  });

  factory _ArtistDto.fromJson(Map<String, dynamic> json) {
    final coverJson = json['Cover'] as Map<String, dynamic>?;
    final likeJson = json['Like'] as Map<String, dynamic>?;

    return _ArtistDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      imageUrl: coverJson != null ? _CoverDto.fromJson(coverJson).url : null,
      thumbnailUrl: coverJson != null
          ? _CoverDto.fromJson(coverJson).thumbnailUrl
          : null,
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Artist toDomain() => Artist(
    id: documentId,
    artistName: name,
    imageUrl: imageUrl ?? '',
    thumbnailUrl: thumbnailUrl,
    likeId: likeId,
  );
}

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

class TrackDto {
  final String documentId;
  final String name;
  final int length;
  final _FileDto? file;
  final List<_ArtistDto> artists;
  final String? coverUrl;
  final String? coverThumbnailUrl;
  final String? albumCoverUrl;
  final String? albumCoverThumbnailUrl;
  final String? albumId;
  final int? year;
  final String? likeId;

  TrackDto({
    required this.documentId,
    required this.name,
    required this.length,
    required this.file,
    required this.artists,
    this.coverUrl,
    this.coverThumbnailUrl,
    this.albumCoverUrl,
    this.albumCoverThumbnailUrl,
    this.albumId,
    this.year,
    this.likeId,
  });

  factory TrackDto.fromJson(Map<String, dynamic> json) {
    final album = json['Album'] as Map<String, dynamic>?;
    final albumCoverJson = album?['Cover'] as Map<String, dynamic>?;
    final coverJson = json['Cover'] as Map<String, dynamic>?;
    final likeJson = json['Like'] as Map<String, dynamic>?;

    return TrackDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      length: json['Length'] as int? ?? 0,
      file: json['File'] != null
          ? _FileDto.fromJson(json['File'] as Map<String, dynamic>)
          : null,
      artists:
          (json['Artists'] as List<dynamic>?)
              ?.map((e) => _ArtistDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      coverUrl: coverJson != null ? _CoverDto.fromJson(coverJson).url : null,
      coverThumbnailUrl: coverJson != null
          ? _CoverDto.fromJson(coverJson).thumbnailUrl
          : null,
      albumCoverUrl: albumCoverJson != null
          ? _CoverDto.fromJson(albumCoverJson).url
          : null,
      albumCoverThumbnailUrl: albumCoverJson != null
          ? _CoverDto.fromJson(albumCoverJson).thumbnailUrl
          : null,
      albumId: album?['documentId'] as String?,
      year: json['Year'] as int?,
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Track toDomain() {
    log('"$name" → audioUrl: "${file?.url ?? ''}"', name: 'TrackDto');
    return Track(
      id: documentId,
      title: name,
      artists: artists.map((a) => a.toDomain()).toList(),
      imageUrl: coverUrl ?? albumCoverUrl,
      thumbnailUrl: coverThumbnailUrl ?? albumCoverThumbnailUrl,
      duration: Duration(seconds: length),
      audioUrl: file?.url ?? '',
      albumId: albumId,
      year: year,
      likeId: likeId,
    );
  }
}
