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
  final String? likeId;

  _ArtistDto({
    required this.documentId,
    required this.name,
    this.imageUrl,
    this.likeId,
  });

  factory _ArtistDto.fromJson(Map<String, dynamic> json) {
    final coverJson = json['Cover'] as Map<String, dynamic>?;
    final likeJson = json['Like'] as Map<String, dynamic>?;

    return _ArtistDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      imageUrl: coverJson != null ? _CoverDto.fromJson(coverJson).url : null,
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Artist toDomain() => Artist(
    id: documentId,
    artistName: name,
    imageUrl: imageUrl ?? '',
    likeId: likeId,
  );
}

class _CoverDto {
  final String url;

  _CoverDto({required this.url});

  factory _CoverDto.fromJson(Map<String, dynamic> json) {
    return _CoverDto(url: json['url'] as String);
  }
}

class TrackDto {
  final String documentId;
  final String name;
  final int length;
  final _FileDto? file;
  final List<_ArtistDto> artists;
  final String? coverUrl;
  final String? albumCoverUrl;
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
    this.albumCoverUrl,
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
      albumCoverUrl: albumCoverJson != null
          ? _CoverDto.fromJson(albumCoverJson).url
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
      duration: Duration(seconds: length),
      audioUrl: file?.url ?? '',
      albumId: albumId,
      year: year,
      likeId: likeId,
    );
  }
}
