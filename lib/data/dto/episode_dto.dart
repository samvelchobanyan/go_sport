import 'package:go_sport/domain/entities/track.dart';

class EpisodeDto {
  final String documentId;
  final String name;
  final int length;
  final String? fileUrl;
  final String? programName;
  final String? programCoverUrl;
  final DateTime? streamed;
  final String? likeId;

  EpisodeDto({
    required this.documentId,
    required this.name,
    required this.length,
    this.fileUrl,
    this.programName,
    this.programCoverUrl,
    this.streamed,
    this.likeId,
  });

  factory EpisodeDto.fromJson(Map<String, dynamic> json) {
    final fileJson = json['File'] as Map<String, dynamic>?;
    final programJson = json['Program'] as Map<String, dynamic>?;
    final coverJson = programJson?['Cover'] as Map<String, dynamic>?;
    final likeJson = json['Like'] as Map<String, dynamic>?;

    return EpisodeDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      length: json['Length'] as int? ?? 0,
      fileUrl: fileJson?['url'] as String?,
      programName: programJson?['Name'] as String?,
      programCoverUrl: coverJson?['url'] as String?,
      streamed: json['Streamed'] != null
          ? DateTime.parse(json['Streamed'] as String)
          : null,
      likeId: likeJson?['documentId'] as String?,
    );
  }

  Track toDomain() {
    return Track(
      id: documentId,
      title: name,
      artistName: programName ?? '',
      imageUrl: programCoverUrl,
      duration: Duration(seconds: length),
      audioUrl: fileUrl ?? '',
      releaseDate: streamed,
      isLiked: likeId != null,
      likeId: likeId,
    );
  }
}
