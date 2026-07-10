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
  final String? albumId;
  final String? programId;
  final String? likeId;

  TrackDto({
    required this.documentId,
    required this.name,
    required this.length,
    required this.file,
    required this.artists,
    this.albumCoverUrl,
    this.albumId,
    this.programId,
    this.likeId,
  });

  // factory TrackDto.fromJson(Map<String, dynamic> json) {
  //   final album = json['Album'] as Map<String, dynamic>?;
  //   final coverJson = album?['Cover'] as Map<String, dynamic>?;
  //   final program = json['Program'] as Map<String, dynamic>?;

  //   final likeJson = json['Like'] as Map<String, dynamic>?;

  //   return TrackDto(
  //     documentId: json['documentId'] as String,
  //     name: json['Name'] as String,
  //     length: json['Length'] as int? ?? 0,
  //     file: json['File'] != null
  //         ? _FileDto.fromJson(json['File'] as Map<String, dynamic>)
  //         : null,
  //     artists:
  //         (json['Artists'] as List<dynamic>?)
  //             ?.map((e) => _ArtistDto.fromJson(e as Map<String, dynamic>))
  //             .toList() ??
  //         [],
  //     albumCoverUrl: coverJson != null
  //         ? _CoverDto.fromJson(coverJson).url
  //         : null,
  //     albumId: album?['documentId'] as String?,
  //     programId: program?['documentId'] as String?,
  //     likeId: likeJson?['documentId'] as String?,
  //   );
  // }

  factory TrackDto.fromJson(Map<String, dynamic> json) {
    // If the json parameter contains the root list, extract the first item safely
    Map<String, dynamic> targetJson = json;
    if (json.containsKey('data')) {
      if (json['data'] is List && (json['data'] as List).isNotEmpty) {
        targetJson = json['data'][0] as Map<String, dynamic>;
      } else if (json['data'] is Map<String, dynamic>) {
        targetJson = json['data'] as Map<String, dynamic>;
      }
    }

    final album = targetJson['Album'] as Map<String, dynamic>?;
    final coverJson =
        targetJson['Cover'] as Map<String, dynamic>? ??
        album?['Cover'] as Map<String, dynamic>?;

    final program = targetJson['Program'] is Map<String, dynamic>
        ? targetJson['Program'] as Map<String, dynamic>
        : (targetJson['Program'] is Map
              ? Map<String, dynamic>.from(targetJson['Program'] as Map)
              : null);

    final likeJson = targetJson['Like'] as Map<String, dynamic>?;

    return TrackDto(
      documentId: targetJson['documentId'] as String? ?? '',
      name: targetJson['Name'] as String? ?? '',
      length: targetJson['Length'] as int? ?? 0,
      file: targetJson['File'] != null
          ? _FileDto.fromJson(targetJson['File'] as Map<String, dynamic>)
          : null,
      artists:
          (targetJson['Artists'] as List<dynamic>?)
              ?.map((e) => _ArtistDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      albumCoverUrl: coverJson != null
          ? _CoverDto.fromJson(coverJson).url
          : null,
      albumId: album?['documentId'] as String?,
      programId:
          program?['documentId'] as String? ?? program?['id']?.toString(),
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Track toDomain() {
    log('"$name" → audioUrl: "${file?.url ?? ''}"', name: 'TrackDto');
    log('"$name" → imageUrl: "$albumCoverUrl"', name: 'TrackDto');
    return Track(
      id: documentId,
      title: name,
      artistName: artists.isNotEmpty ? artists.first.name : '',
      artistId: artists.isNotEmpty ? artists.first.documentId : null,
      imageUrl: albumCoverUrl,
      duration: Duration(seconds: length),
      audioUrl: file?.url ?? '',
      albumId: albumId,
      programId: programId,
      likeId: likeId,
    );
  }
}
