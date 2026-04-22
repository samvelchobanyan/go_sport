import 'dart:developer';

import 'package:go_sport/domain/entities/scheduled_program.dart';

class _IconDto {
  final String url;

  _IconDto({required this.url});

  factory _IconDto.fromJson(Map<String, dynamic> json) {
    return _IconDto(url: json['url'] as String? ?? '');
  }
}

class ScheduledProgramDto {
  // У Strapi-компонента нет documentId, только числовой id — храним его строкой.
  final String id;
  final String title;
  final String parentDate;
  final String start;
  final int durationMinutes;
  final String iconUrl;

  ScheduledProgramDto({
    required this.id,
    required this.title,
    required this.parentDate,
    required this.start,
    required this.durationMinutes,
    required this.iconUrl,
  });

  factory ScheduledProgramDto.fromJson(Map<String, dynamic> json) {
    final iconJson = json['Icon'] as Map<String, dynamic>?;

    return ScheduledProgramDto(
      id: (json['id'] as int?)?.toString() ?? '',
      title: json['Title'] as String? ?? '',
      parentDate: json['parentDate'] as String? ?? '',
      start: json['Start'] as String? ?? '',
      durationMinutes: json['Duration'] as int? ?? 0,
      iconUrl: iconJson != null ? _IconDto.fromJson(iconJson).url : '',
    );
  }

  ScheduledProgram? toDomain() {
    if (id.isEmpty) {
      log('Skipped slot: empty id', name: 'ScheduledProgramDto');
      return null;
    }

    // Strapi отдаёт Start как "HH:mm:ss.SSS" — для DateTime.parse
    // берём "HH:mm:ss".
    final timePrefix = start.length > 8 ? start.substring(0, 8) : start;
    final startDate = DateTime.tryParse('${parentDate}T$timePrefix');
    if (startDate == null) {
      log(
        'Skipped slot "$id": invalid startDate from '
        'parentDate="$parentDate", start="$start"',
        name: 'ScheduledProgramDto',
      );
      return null;
    }

    if (durationMinutes <= 0) {
      log(
        'Skipped slot "$id": non-positive Duration $durationMinutes',
        name: 'ScheduledProgramDto',
      );
      return null;
    }

    return ScheduledProgram(
      id: id,
      title: title,
      startDate: startDate,
      duration: Duration(minutes: durationMinutes),
      imageUrl: iconUrl.isNotEmpty ? iconUrl : null,
    );
  }
}
