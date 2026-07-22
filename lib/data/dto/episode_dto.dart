import 'package:go_sport/domain/entities/track.dart';

class EpisodeDto {
  final String documentId;
  final String name;
  final int length;
  final String? fileUrl;
  final String? programId;
  final String? programName;
  // final String? programCoverUrl;
  final String? coverUrl;
  final DateTime? streamed;
  final String? likeId;

  EpisodeDto({
    required this.documentId,
    required this.name,
    required this.length,
    this.fileUrl,
    this.programId,
    this.programName,
    // this.programCoverUrl,
    this.coverUrl,
    this.streamed,
    this.likeId,
  });

  factory EpisodeDto.fromJson(Map<String, dynamic> json) {
    final fileJson = json['File'] as Map<String, dynamic>?;
    final programJson = json['Program'] as Map<String, dynamic>?;
    // final coverJson = programJson?['Cover'] as Map<String, dynamic>?;
    final likeJson = json['Like'] as Map<String, dynamic>?;

    // 1. Check Episode's direct Cover
    final episodeCoverJson = json['Cover'] as Map<String, dynamic>?;

    // 2. Check Program's Cover as fallback
    final programCoverJson = programJson?['Cover'] as Map<String, dynamic>?;

    // 3. Resolve URL: Try Episode Cover -> Fallback to Program Cover
    final coverUrl =
        (episodeCoverJson?['url'] as String?) ??
        (programCoverJson?['url'] as String?);

    return EpisodeDto(
      documentId: json['documentId'] as String,
      name: json['Name'] as String,
      length: json['Length'] as int? ?? 0,
      fileUrl: fileJson?['url'] as String?,
      programId: programJson?['documentId'] as String?,
      programName: programJson?['Name'] as String?,
      // programCoverUrl: coverJson?['url'] as String?,
      coverUrl: coverUrl,
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
      // imageUrl: programCoverUrl,
      imageUrl: coverUrl,
      duration: Duration(seconds: length),
      audioUrl: fileUrl ?? '',
      programId: programId,
      releaseDate: streamed,
      likeId: likeId,
    );
  }
}
