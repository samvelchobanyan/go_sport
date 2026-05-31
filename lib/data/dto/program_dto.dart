import 'package:go_sport/domain/entities/program.dart';

class _CoverDto {
  final String url;

  _CoverDto({required this.url});

  factory _CoverDto.fromJson(Map<String, dynamic> json) {
    return _CoverDto(url: json['url'] as String);
  }
}

class ProgramDto {
  final String documentId;
  final String name;
  final _CoverDto? cover;
  final int cnt;
  final String? likeId;

  ProgramDto({
    required this.documentId,
    required this.name,
    required this.cover,
    required this.cnt,
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
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Program toDomain() {
    return Program(
      id: documentId,
      title: name,
      imageUrl: cover?.url ?? '',
      episodeCount: cnt,
      likeId: likeId,
    );
  }
}
