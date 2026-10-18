import 'package:go_sport/domain/entities/playlist.dart';

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

class PlaylistDto {
  final String documentId;
  final String name;
  final _CoverDto? cover;
  final int cnt;
  final String? likeId;
  final DateTime? createdAt;

  PlaylistDto({
    required this.documentId,
    required this.name,
    required this.cover,
    required this.cnt,
    this.likeId,
    this.createdAt,
  });

  factory PlaylistDto.fromJson(Map<String, dynamic> json) {
    final likeJson = json['Like'] as Map<String, dynamic>?;
    final createdAtRaw = json['createdAt'] as String?;

    return PlaylistDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      cover: json['Cover'] != null
          ? _CoverDto.fromJson(json['Cover'] as Map<String, dynamic>)
          : null,
      cnt: json['cnt'] as int? ?? 0,
      likeId: likeJson?['documentId'] as String?,
      createdAt: createdAtRaw != null ? DateTime.tryParse(createdAtRaw) : null,
    );
  }

  Playlist toDomain() {
    return Playlist(
      id: documentId,
      title: name,
      imageUrl: cover?.url ?? '',
      thumbnailUrl: cover?.thumbnailUrl,
      trackCount: cnt,
      likeId: likeId,
      createdAt: createdAt,
    );
  }
}
