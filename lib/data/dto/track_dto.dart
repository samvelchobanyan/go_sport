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

class TrackDto {
  final String documentId;
  final String name;
  final int length;
  final _FileDto? file;
  final List<_ArtistDto> artists;

  TrackDto({
    required this.documentId,
    required this.name,
    required this.length,
    required this.file,
    required this.artists,
  });

  factory TrackDto.fromJson(Map<String, dynamic> json) {
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
    );
  }

  Track toDomain() {
    log('"$name" → audioUrl: "${file?.url ?? ''}"', name: 'TrackDto');
    return Track(
      id: documentId,
      title: name,
      artistName: artists.isNotEmpty ? artists.first.name : '',
      imageUrl: '',
      duration: Duration(seconds: length),
      audioUrl: file?.url ?? '',
    );
  }
}
