import 'package:go_sport/domain/entities/program.dart';

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

class ProgramDto {
  final String documentId;
  final String name;
  final _CoverDto? cover;
  final int cnt;
  final String? youtube;
  final String? likeId;

  ProgramDto({
    required this.documentId,
    required this.name,
    required this.cover,
    required this.cnt,
    this.youtube,
    this.likeId,
  });

  factory ProgramDto.fromJson(Map<String, dynamic> json) {
    final likeJson = json['Like'] as Map<String, dynamic>?;

    return ProgramDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      cover: json['Cover'] != null
          ? _CoverDto.fromJson(json['Cover'] as Map<String, dynamic>)
          : null,
      cnt: json['cnt'] as int? ?? 0,
      youtube: json['Youtube'] as String?,
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Program toDomain() {
    return Program(
      id: documentId,
      title: name,
      imageUrl: cover?.url ?? '',
      thumbnailUrl: cover?.thumbnailUrl,
      episodeCount: cnt,
      youtubeUrl: youtube,
      likeId: likeId,
    );
  }
}
