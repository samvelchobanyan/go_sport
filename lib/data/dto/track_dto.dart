import 'dart:developer';

import 'package:go_sport/domain/entities/track.dart';

class _FileDto {
  final String url;

  _FileDto({required this.url});

  factory _FileDto.fromJson(Map<String, dynamic> json) {
    return _FileDto(url: json['url'] as String);
  }
}

class _ArtistDto {
  final String name;

  _ArtistDto({required this.name});

  factory _ArtistDto.fromJson(Map<String, dynamic> json) {
    return _ArtistDto(name: json['Name'] as String);
  }
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
  final String? albumCoverUrl;
  final String? likeId;

  TrackDto({
    required this.documentId,
    required this.name,
    required this.length,
    required this.file,
    required this.artists,
    this.albumCoverUrl,
    this.likeId,
  });

  factory TrackDto.fromJson(Map<String, dynamic> json) {
    final album = json['Album'] as Map<String, dynamic>?;
    final coverJson = album?['Cover'] as Map<String, dynamic>?;

    final likeJson = json['Like'] as Map<String, dynamic>?;

    return TrackDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      length: json['Length'] as int? ?? 0,
      file: json['File'] != null
          ? _FileDto.fromJson(json['File'] as Map<String, dynamic>)
          : null,
      artists: (json['Artists'] as List<dynamic>?)
              ?.map((e) => _ArtistDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      albumCoverUrl: coverJson != null ? _CoverDto.fromJson(coverJson).url : null,
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Track toDomain() {
    log('"$name" → audioUrl: "${file?.url ?? ''}"', name: 'TrackDto');
    return Track(
      id: documentId,
      title: name,
      artistName: artists.isNotEmpty ? artists.first.name : '',
      imageUrl: albumCoverUrl,
      duration: Duration(seconds: length),
      audioUrl: file?.url ?? '',
      likeId: likeId,
    );
  }
}
